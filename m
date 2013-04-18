From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 05:55:27 -0500
Message-ID: <CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
	<CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
	<CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USmV6-0003BG-6H
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967363Ab3DRKza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:55:30 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59384 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967253Ab3DRKz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:55:29 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so2559917lbi.33
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fsX3tW7B4A93GHyKA3/uS+tynJBqVVYKUTBVLQFTIOw=;
        b=LhAXMDV+32lsmGkF3EgitaK1AiXW000J/k1OvfUw9Kv4tq2LX/TjT+qcXWUZRKXWmX
         +JJUjHNgJXJTmGQbElaBEEzaY6j8FK8gdt3kIWM5rbbpXuqY/pUTMkT3HFdUZgOeI3rz
         V2GywvBpk3JWloJJ6qKpKt1mk01rrHf31EZA3VpRWXRZMdy3BFsl/oeZC94/mMcvXvOV
         MBsKN5ayZWAWFzQpmwEbPBjwwYqjlvDW7HlsfoojyY0vJN3Yjo1jILsnbyWk0HgpKMml
         vh1oGNbYVZwVnSWeZb/u/ddH3uEAKDQ0irPvdAW3ts5K6aeGgmporrwZkHYwHAiZXehC
         qTQw==
X-Received: by 10.112.139.226 with SMTP id rb2mr4603741lbb.12.1366282527574;
 Thu, 18 Apr 2013 03:55:27 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 03:55:27 -0700 (PDT)
In-Reply-To: <CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221646>

On Thu, Apr 18, 2013 at 5:27 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Except the customers are not git developers, it's git users. Git
>> developers rejecting patches because of the commit message is akin to
>> distributors rejecting products because they don't like the
>> transportation packages; they are only hurting themselves, by hurting
>> their customers.
>
> Huh?  I certainly don't develop for some "git users" I don't even know
> or care about.  In this order of precedence, my customers are:
>
> 1. Me.
> 2. People who develop git.git, whom I have to cooperate with.
> 3. People who exercise git heavily like the linux.git community, as
> opposed to some little projects that operate using pull requests on
> GitHub.
> ...
> 137. People who incidentally choose to use git.
> 138. People who incidentally choose to use git, but aren't on Linux.

As they are for most open source developers on the planet, not me. I
believe a project is nothing without its users.

> And nobody is hurting anyone else.  Someone wrote some code, and
> failed to sell it to the community.  That's all happened.

If remote-hg wasn't available for users, they would be hurt; if stash
wasn't available, if rebase --interactive didn't exist, if there was
no msysgit, if it wasn't so fast, if the object model wasn't so simple
and extensible; users would be hurt. And if users didn't have all
these, there would be less users, and if there were less users, there
would be less developers, and mercurial might have been more popular,
and most repositories you have to work on would be in mercurial, and
you might be developing mercurial right now.

But I won't bother trying to convince you that no project is more
important than its users (in the words of Linus Torvalds), because
most people don't see the big picture.

>> I don't think so. Unless you added your Signed-off-by, you are not.
>
> Okay, so your view differs.
>
>> I am not. Neither should they ask me to write the commit messages they
>> want. They can make *suggestions*, and I can reject them.
>
> Ofcourse you have a right to reject suggestions.  The question at the
> end of the day doesn't change: did you manage to get people to read
> your patch?

No, at the end of the day what matters is: did the users benefit from this?

The answer for this particular patch is no, and it's not my fault.

>> When two persons have different ideas, often times both are wrong, and
>> the middle-ground is best, but sometimes a person reaches the
>> middle-ground, and sometimes one person was right from the start.
>
> https://yourlogicalfallacyis.com/middle-ground :)

Yeah, but I didn't claim that, I said sometimes one person was right
from the start, no middle-ground.

>> But when everyone shares the *assumption* that there is never a commit
>> message that is too long, you know the wrestling mat of ideas is
>> rigged. I wonder if I should write a commit message as long as a book
>> chapter for a one-liner, only to prove a point, but I'm honestly
>> afraid that it would be committed as is.
>
> I'm with you, and don't share that assumption.

s/everyone/almost everyone/

> I'm not accusing you
> of writing commit messages that don't conform to some "transcendental
> standard" either: I didn't look at your patches in the first place,
> because the simple Signed-off-by: one-liner in the body didn't really
> make me want to read it.
>
>> And remember what started the conversation; do you think a patch with
>> a possibly incomplete commit message should not be merged to pu
>> (proposed updates), shouldn't even be mentioned in the "what's
>> cooking" mail, and thus shouldn't even be considered "cooking"?
>
> It's irrelevant what I think or others think.  The point is that it
> wasn't mentioned.  Now, why wasn't it mentioned?  Is it because Junio
> and the community hate you, and are conspiring against getting your
> code merged?  Or is it because it didn't catch anyone's eye, and Junio
> was waiting for it to happen (as always)?

My abridged version of the story is: because Jeff King pointed to an
area of improvement he wasn't even strongly attached to, I agreed to
resubmit, Junio saw that, then I changed my mind, Junio probably
didn't see that, and then he forgot about it.

Then, since it's taboo to suggest that a concise commit message is
fine, a discussion sprung.

> TL;DR version: Your goal in submitting a patch is to sell it to other
> people in the community.

I disagree.

> If enough people like your patch, it gets
> merged (but that is only the second step).  Your goal is not to fix
> problems for some unknown "users", or argue about some "transcendental
> standard".

I disagree.

> Ofcourse the community shares some view about what a patch
> should look like, but you can mould those expectations gradually.

If experience is any guide, doesn't look like that. But I've noticed
that after many months that a patch has been sent people realize that
it's more important to get the damn issue fixed than to have a hugely
verbose commit message...

Cheers.

-- 
Felipe Contreras
