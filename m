From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 15:57:34 +0530
Message-ID: <CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
 <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
 <CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com> <CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USm4r-0000jX-97
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968151Ab3DRK2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:28:18 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52345 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965638Ab3DRK2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:28:15 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so3072842iea.38
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sGhzaODRPm8aUei/Ogwke34UEDKELimEhVVgYFiidDA=;
        b=Vsd4HeGHbK+Zay4CDPB5zU0yVrvQU2popwg5t9/fgoJHvZuhSd3V8DzBMVeDG/S03F
         RV1GiG7V099dHHLEnZhfr9VQBwAZsRKW/cim7CQHY3ERpctk2KJjjSExtHcKKiliCaxb
         RV/QxXd/0up2mMaSQiSSeQu7OP2+sOVPMSMcNCF/IOk3PfRB5J0Dqbzg3AxRAYyAQucZ
         waMMpm0RVZ8dN4GCkD+tMmOKrq9CDg3/RbLBU47D/d6OHBTj6dU3jRITToi48PLTmRQi
         Ne44xfXbtmBIUiXpjBfd52Yfobwx1q5dn9Mfblv8FXgZ/52vtZ5mSa5D2o0enUQ6xps3
         PEIA==
X-Received: by 10.50.129.66 with SMTP id nu2mr1832315igb.0.1366280894797; Thu,
 18 Apr 2013 03:28:14 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 03:27:34 -0700 (PDT)
In-Reply-To: <CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221645>

Felipe Contreras wrote:
> Except the customers are not git developers, it's git users. Git
> developers rejecting patches because of the commit message is akin to
> distributors rejecting products because they don't like the
> transportation packages; they are only hurting themselves, by hurting
> their customers.

Huh?  I certainly don't develop for some "git users" I don't even know
or care about.  In this order of precedence, my customers are:

1. Me.
2. People who develop git.git, whom I have to cooperate with.
3. People who exercise git heavily like the linux.git community, as
opposed to some little projects that operate using pull requests on
GitHub.
...
137. People who incidentally choose to use git.
138. People who incidentally choose to use git, but aren't on Linux.

I don't know if Junio or the others share this view, but this is how I
personally operate and I'm very happy.

And nobody is hurting anyone else.  Someone wrote some code, and
failed to sell it to the community.  That's all happened.

> The only one that gets bitten by fixes not getting merged are git
> users, not me. So if a discussion of a commit message impedes the
> merging of the commit, I don't get affected, but when we have agreed
> to disagree on what constitutes a good message, and the patch is still
> on hold, then there's a problem.

I think the whole issue of whether your commit message conforms to
some transcendental standard is orthogonal to the issue.  Is your
patch getting attention?  Has it attracted reviewers, and turned up on
the latest "What's cooking"?

> I don't think so. Unless you added your Signed-off-by, you are not.

Okay, so your view differs.

> I am not. Neither should they ask me to write the commit messages they
> want. They can make *suggestions*, and I can reject them.

Ofcourse you have a right to reject suggestions.  The question at the
end of the day doesn't change: did you manage to get people to read
your patch?

> When two persons have different ideas, often times both are wrong, and
> the middle-ground is best, but sometimes a person reaches the
> middle-ground, and sometimes one person was right from the start.

https://yourlogicalfallacyis.com/middle-ground :)

> But when everyone shares the *assumption* that there is never a commit
> message that is too long, you know the wrestling mat of ideas is
> rigged. I wonder if I should write a commit message as long as a book
> chapter for a one-liner, only to prove a point, but I'm honestly
> afraid that it would be committed as is.

I'm with you, and don't share that assumption.  I'm not accusing you
of writing commit messages that don't conform to some "transcendental
standard" either: I didn't look at your patches in the first place,
because the simple Signed-off-by: one-liner in the body didn't really
make me want to read it.

> And remember what started the conversation; do you think a patch with
> a possibly incomplete commit message should not be merged to pu
> (proposed updates), shouldn't even be mentioned in the "what's
> cooking" mail, and thus shouldn't even be considered "cooking"?

It's irrelevant what I think or others think.  The point is that it
wasn't mentioned.  Now, why wasn't it mentioned?  Is it because Junio
and the community hate you, and are conspiring against getting your
code merged?  Or is it because it didn't catch anyone's eye, and Junio
was waiting for it to happen (as always)?

TL;DR version: Your goal in submitting a patch is to sell it to other
people in the community.  If enough people like your patch, it gets
merged (but that is only the second step).  Your goal is not to fix
problems for some unknown "users", or argue about some "transcendental
standard".  Ofcourse the community shares some view about what a patch
should look like, but you can mould those expectations gradually.
