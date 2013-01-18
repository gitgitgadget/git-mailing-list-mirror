From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] git-completion.bash: replace zsh notation that breaks
 bash 3.X
Date: Fri, 18 Jan 2013 11:07:14 -0800
Message-ID: <CA+sFfMd6FLchoOcUpNZ3AxTLNp3qe=VjijRid4sWf-A3_w88qw@mail.gmail.com>
References: <1358505065-16913-1-git-send-email-drafnel@gmail.com>
	<m2obgmjzz0.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, felipe.contreras@gmail.com, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:07:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHI2-0008Vf-4j
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab3ARTHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 14:07:19 -0500
Received: from mail-vc0-f182.google.com ([209.85.220.182]:52915 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab3ARTHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 14:07:15 -0500
Received: by mail-vc0-f182.google.com with SMTP id fl17so58031vcb.13
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PIR5kl12wfpl0a3g2lNZKGF0+67otmokxjZr0h9Jhlo=;
        b=lpTNDnCbNoOE1bFcyd5HhdqHPRR3oQ2dQ2KoskDhMi5nPLPvPmLMHeSgNsRT+DUtnL
         8W/C1laFoKqN5KbdSuUkJQAnOfEqtYnkB2MvIDLa/+uTWH6NQO7SJL1UIR7evr3yezlo
         0gbs6f5AARroZUg/yIvGScelydsK8x6JIL2+gPDw3Gfg0TfOfpqSBssH7wPWrfVMKa7A
         KEW9xuS2dx7galn4GvkC0AnbjCxZndGkizqbMGW/kMZ09bLYjxo9FAPLS7Qch+eVMFM0
         pf7mXLr2ErOGaSlK8pMucvg5WNnashMHdglvpmzrb/CNRWHbWx00UKYHGKBjAihScgxQ
         yjCg==
X-Received: by 10.52.76.7 with SMTP id g7mr9513468vdw.95.1358536034732; Fri,
 18 Jan 2013 11:07:14 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Fri, 18 Jan 2013 11:07:14 -0800 (PST)
In-Reply-To: <m2obgmjzz0.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213927>

On Fri, Jan 18, 2013 at 7:02 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> +                             array[$(($#array+1))]="$c"
>
> You don't need $(( )) since the array index is already evaluated as an
> arithmethic expression.

Ah, I didn't know that.  Thanks.

I think Junio will probably fix this up if he thinks it's worth it,
but I can resubmit if necessary.

-Brandon
