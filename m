From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 11:47:34 +0200
Message-ID: <CALWbr2w0C77j-Qw0L03dT04pm81iz0sn-W8+=t7271nhCW=OYw@mail.gmail.com>
References: <xmqqsiy0nnlr.fsf@gitster.dls.corp.google.com>
	<1377353267-3886-1-git-send-email-apelisse@gmail.com>
	<20130825040122.GA18676@sigill.intra.peff.net>
	<xmqqob8ml588.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 11:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDWzh-0005pB-5t
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 11:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab3HYJrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 05:47:36 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:44832 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab3HYJrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 05:47:35 -0400
Received: by mail-qe0-f43.google.com with SMTP id t7so1208621qeb.30
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8cRBg9sSHFm6gT3UQLz29iNkINk8C1r+uvE9I5xLlJU=;
        b=pd9mx5LKSe+E8+BqRllvZkdWaGy/SnWEW5pbia51tc9wm3OtjAIrkmu2ibgmeMoami
         2dMaCxfNJNqoxQoktIGAMUjMaFLBiJCvvPSslUlQjrUnLSB5JAQROFJSMR6u5IiO8Al0
         CvyhjhWUwBx8IsuYMpib5dotCpAxQ6m/6eUrmvUvbL7il36eaqZoNJFio1z4/fFOULms
         xZ/PCQERBJ4tj5K071L9cDarPnXurieHvOZa6/vnjlKaJfsRpvQTxqbnyyhmiEDzTi6q
         MoNy5jRJLODlXqMP1NpRs2C0LLZBUTopfHTbMR1x5Ngo4UOe7Z/wsXz5n9aVtipQPhso
         1hQw==
X-Received: by 10.224.156.197 with SMTP id y5mr158159qaw.83.1377424054672;
 Sun, 25 Aug 2013 02:47:34 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Sun, 25 Aug 2013 02:47:34 -0700 (PDT)
In-Reply-To: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232945>

On Sun, Aug 25, 2013 at 7:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> Do we need to clear_mailmap before returning to avoid a leak?
>
> Good question. What I queued yesterday seems to have a call to
> clear_mailmap(&mailmap) before that return.

Indeed, the version you queued has clear_mailmap(), not the version
you sent by email.

Will resend.

Thanks,
