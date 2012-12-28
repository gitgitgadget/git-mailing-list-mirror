From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v3 00/19] new git check-ignore sub-command
Date: Fri, 28 Dec 2012 21:15:59 +0100
Message-ID: <CALWbr2wEVzjJ_Y+W9BmakvXCwdFR3OjVH+15tPaDeXsrwaO86w@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<7v38yqj9ix.fsf@alter.siamese.dyndns.org>
	<CAOkDyE8gfW9TvyP=iE7gVEXOqCpOqMRjpr=Vnyd_pnummy4Qsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:16:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TogM8-0006AK-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab2L1UQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:16:01 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:44668 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab2L1UQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:16:00 -0500
Received: by mail-ee0-f52.google.com with SMTP id d17so5017372eek.25
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 12:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=APRffmz7Vb4CDM7ne4PD4ni9mSUiOApBCI+7GkI/W2c=;
        b=FazCMdaVNoQ/PHeUAIOnV1M0hNOZlEZpicGm6fLZNG1MKG4g95l0U0hzUkH10jlUqC
         nxyRCA8MmV9sBKHcrp4g1SufzTPwHEU0PsC5Iz42owMCZjBVqWL6I/pb5dMTxfe1YQF6
         WCfDRRgXbiFR4NPdnfZvfg6GZFcRh+i1JQyTqqFVwXAsG2RK0AX8SQx/tYzd2jHO6T4l
         c6L4TmoR3o+4Y0obZ6xkYtVF6aYbXh5hDMFXiE39kdQM/GevpoxGeE/+Y6fowPwpZpd/
         w68JRv3sRRcAoRXAv2fO0feeW5qmoOsjzIpLMm+r6emiGA7FZkIf+PDxACQ7xpYgFPxk
         LzrA==
Received: by 10.14.223.135 with SMTP id v7mr88957081eep.41.1356725759211; Fri,
 28 Dec 2012 12:15:59 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 28 Dec 2012 12:15:59 -0800 (PST)
In-Reply-To: <CAOkDyE8gfW9TvyP=iE7gVEXOqCpOqMRjpr=Vnyd_pnummy4Qsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212255>

I think they will interact, but I need to have a deeper look to Adam's series.
If it does, do you want me to base my work on the top of his branch ?

On Fri, Dec 28, 2012 at 8:39 PM, Adam Spiers <git@adamspiers.org> wrote:
> On Fri, Dec 28, 2012 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>>
>>> This v3 re-roll of my check-ignore series is a reasonably substantial
>>> revamp over v2, and applies on top of Junio's current
>>> nd/attr-match-optim-more branch (82dce998c202).
>>
>> Thanks.
>>
>> Does this (and should this, if it doesn't) interact with the more
>> recent discussion around "git status --untracked/--ignored" [*1*],
>> which also wants to touch the recursive directory traversal logic in
>> "dir.c"?
>
> I cannot think of a reason why they would or should interact.  If I'm
> wrong, I expect that either set of unit tests would show me up :-)
