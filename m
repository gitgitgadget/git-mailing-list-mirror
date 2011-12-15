From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 3/4] wrapper: supply xsetenv and xputenv
Date: Thu, 15 Dec 2011 19:25:41 +0100
Message-ID: <CABPQNSZVRfFk=Y6JnnDkvcbPwXgm1MMeevDyrjFF=D4ubGPaTg@mail.gmail.com>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
 <1323871631-2872-4-git-send-email-kusmabite@gmail.com> <7vzketohvg.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, peff@peff.net, schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 19:26:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbG0h-0004yh-8G
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 19:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290Ab1LOS0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 13:26:23 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44216 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab1LOS0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 13:26:22 -0500
Received: by dajs34 with SMTP id s34so1522019daj.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SUi2G3Q/ynXYwesGjwMnOUvqJoVdLIqTlPKwJwRdkCo=;
        b=J6hpK13qWIzrUBFYHhyz6ivEpWw4TGd/5AhZftEVpM3S1nHX5W52Qj3fPutaHH591K
         KGoQwMHPTSDeFzJ7ikwTewPqG59spsAqioK4HgUiIwnOx67Z7TLjJStjsMV4hww47EN0
         7hfltYI3mrC1Ju4xsBGhEuEeQXLwLrl9sdyEk=
Received: by 10.68.72.6 with SMTP id z6mr11610425pbu.73.1323973582215; Thu, 15
 Dec 2011 10:26:22 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Thu, 15 Dec 2011 10:25:41 -0800 (PST)
In-Reply-To: <7vzketohvg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187221>

On Thu, Dec 15, 2011 at 6:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> +extern int xsetenv(const char *name, const char *val, int override);
>> +extern int xputenv(const char *string);
>
> Actually, putenv(3) takes "char *string".

Ah, thanks for spotting.

> I adjusted 3 & 4 locally before queuing, so there is no need for resend,
> and judging from the later part of the discussion, it seems that it may be
> better to use only the first two patches from this series after all.

Yeah, I agree; patch 1 and 2 are the only ones that makes sense.
