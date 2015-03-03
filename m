From: Mike Botsko <botsko@gmail.com>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and
 git rebase
Date: Tue, 3 Mar 2015 15:20:48 -0800
Message-ID: <CAPfvZp5jTTbWVL0QuZTP83=SWvsvyZWX0BG_q7jPLK5wNNvCgg@mail.gmail.com>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
	<20150303210900.GP890@serenity.lan>
	<CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
	<20150303214653.GQ890@serenity.lan>
	<xmqq61ahad18.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:20:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSw7R-0006q5-DB
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbbCCXUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:20:49 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:55842 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbbCCXUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:20:48 -0500
Received: by mail-qa0-f53.google.com with SMTP id v8so4764553qal.12
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DFokVSNmWnjPiWU/R88qpMJ//v+X8bIkebxQ1Sz5FVQ=;
        b=HCtpg4qnF4BsmQsB0wAc/CHn7nSXqjqup+Lxh84jm0kgVTtyf0w3hIsOLFanr+HtCs
         umyexnQFcnaGsICQfy8GjPcu+hxlLcTaNasOxFqR6VzWFZuj6oDqpQ0YoJCynhLsySuE
         VGqTlyxwTb332fX/NMTuyPw0nup8KY5vJPQQ4nmmfyyNhJVLFRTmzxjPi9rE0cwaVJgZ
         bEGOuI6f+R0nqxVBS/TMwGHymY7FL/jGw1UV5Bsg9cJ1HZwtJP5u2mHWLOndclRlEipB
         SQ1POnMDr3lGinefB+5jOtTAFkUbxm2y/fmV+bscQjWAciai7T4+q3DBuE+vEr72asYZ
         kuUg==
X-Received: by 10.140.81.74 with SMTP id e68mr1894208qgd.41.1425424848142;
 Tue, 03 Mar 2015 15:20:48 -0800 (PST)
Received: by 10.140.80.203 with HTTP; Tue, 3 Mar 2015 15:20:48 -0800 (PST)
In-Reply-To: <xmqq61ahad18.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264708>

Maybe I'm lacking the distinction regarding what I'm being specific about.

In both examples, I'm asking it specifically to rebase in changes from
the remote "upstream" and a named branch at that location. I'm giving
git the same information, it's just interpreting it differently - and
I'm not understanding why.

My local branch would have been created from the
upstream/feature-branch, and will eventually be merged back into it.
Until I'm ready for that, I regularly rebase the work done on
upstream/feature-branch so that my local work is always clean and
above anything else.



On Tue, Mar 3, 2015 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> git-rebase assumes that if you give an explicit upstream then you want
>> precisely what you asked for.  From git-rebase(1):
>>
>>       If either <upstream> or --root is given on the command line,
>>       then the default is `--no-fork-point`, otherwise the default is
>>       `--fork-point`.
>
> Correct.
>
> You ask it to rebase the history without guessing by being explicit;
> the command guesses when you are not explicit and being lazy ;-).
>



-- 
Mike Botsko
Lead Dev @ Helion3
Ph: 1-(503)-897-0155
