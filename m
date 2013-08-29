From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] transport-helper: add dont-update-private capability
Date: Thu, 29 Aug 2013 14:14:20 -0500
Message-ID: <CAMP44s2aV8X8TJigSqiSPB2HkK7hdxC2dFPWf5X62h90Y7M8Jg@mail.gmail.com>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
	<1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377802704-30881-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:14:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7g0-0001F4-Uy
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771Ab3H2TOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:14:23 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:49250 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab3H2TOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:14:21 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so1070552lbi.39
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QcYKfFlUT3NUyab0iVuu8VTyuNkt2TijkpBioc2QmEE=;
        b=YkQlQ6gKe1EihqruV7ezG9YkLeK0Wbb9huKqhtDEOo5bMugra5HT/j7+pmKMZHMIB8
         z5HAAYbrDoAgArBHeMWa4ZbYeOU07ocq7yz8/70rlGx/5Y2I46oBgbw29x9ctIGarPkb
         OvTTLaW6EJJQ1F1GE3mqggLVHwqdnUIvMDTpD82oMtzBBa75gvGoTeMBlpHgYoGtvcbH
         TDJIg7D6LLyAnOqGaUVKzYLVYD2JDZ7tonQGQXS4fHqU6T+Ord5aM6ok+S7nxRu0rrxP
         AaQB5T12VvhvdpXT9RR8ni4IVl1z+qPKcHTDRhuxdLmy0eqT/MylqMtA1Kbp9ODNZ9pZ
         WdCA==
X-Received: by 10.152.22.35 with SMTP id a3mr1978686laf.45.1377803660362; Thu,
 29 Aug 2013 12:14:20 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 12:14:20 -0700 (PDT)
In-Reply-To: <1377802704-30881-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233344>

On Thu, Aug 29, 2013 at 1:58 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Since 664059fb62 (Felipe Contreras, Apr 17 2013, transport-helper: update
> remote helper namespace), a 'push' operation on a remote helper updates
> the private ref by default. This is often a good thing, but it can also
> be desirable to disable this update to force the next 'pull' to re-import
> the pushed revisions.
>
> Allow remote-helpers to disable the automatic update by introducing a new
> capability.

Looks good to me, but how about 'no-private-update'?

-- 
Felipe Contreras
