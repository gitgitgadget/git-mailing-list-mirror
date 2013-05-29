From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 08:18:22 -0500
Message-ID: <CAMP44s2tvUs813hrheWpWXR2G4kMJL4rscEtynaKYvw5a6HCHA@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
	<877giixl4c.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
	<87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0k5+2nebRLZfWFpxyPmptV_Qo3sKwgpbpvN-bK6_S6W3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:18:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgGr-0004m3-GY
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965757Ab3E2NSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:18:25 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:59984 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3E2NSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:18:24 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so8570436lab.2
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bRx4QmaaZYu4ACyUjNJg/ZMzaAVBFDpBmxR4/DXp88E=;
        b=TTnHISooNubmlmUjGQxq7Umghglq3tuZiQUm2UbrebgSD1nA6Ez5JHKDk/rR8uJr6I
         bCzzAeAPUvh/P+h610IcNIg79bSvcMlyid9TuKYF6JB+Vcc2kFIc6lB5dd/SCWG39kaT
         WTh91/bxQXUcIuoBaAZBnxYzG9PTaECBLQNgrGffDlF4E9InyGPK0KB8+x/PX8xH0d4s
         9LohV+x/uymhMFbpJZkGdAbtJMchgWeEOqLgb5hGsc6A03SDnv/1vU8IRVf42rXqD1Vo
         IzAWw6ZT0HGf4EDEtxmFELShMAJqe4AqqVrinf8AtO7FsrnEuRX1xszvbREA843/6+Ub
         5vgQ==
X-Received: by 10.112.236.70 with SMTP id us6mr1502488lbc.121.1369833502547;
 Wed, 29 May 2013 06:18:22 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:18:22 -0700 (PDT)
In-Reply-To: <CALkWK0k5+2nebRLZfWFpxyPmptV_Qo3sKwgpbpvN-bK6_S6W3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225810>

On Wed, May 29, 2013 at 7:09 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Thomas Rast wrote:
>> So until this changes, my $0.02 is a blanket NAK and a refusal to spend
>> my time reviewing.
>
> Then don't review the damn thing.  With Felipe, I have the following
> rule of thumb: make some concrete suggestions and forget about
> follow-ups.

He didn't make any suggestions.

> He's not going to accept any general guidelines, unless
> you're quoting Documentation/SubmittingPatches (and even then, it's
> subject to interpretation); so provide a commit message and hope that
> either he or Junio will use it.  There is no guarantee that he will
> take any of your suggestions, no matter how sensible you think they
> might be.

This is bullshit.

Let's look at some of the suggestions you have made:

== git-related ==

> s/l/line/?

I said fine, and I implemented it.

> Still no -CCC?

I said I forgot, and I implemented it.

What you are really complaining about is that I don't agree with
*every* single suggestion you make. And since you made them, they must
be sensible, and single I don't agree with you, I must not be
sensible, is that right?

And stop bringing irrelevant garbage to this discussion. The
discussion about the coding-style not about guidelines, because there
is no guideline for that open parenthesis, ad obviated by the fact
that there's over *FIVE HUNDRED* instances where it's not aligned that
way.

Nobody is denying the notes.rewritten.* guideline here, I didn't
because that is *actually* a guideline. So your comment about
guidelines is an irrelevant straw man.

> However, he is a productive programmer, and submits fixes
> to real issues.  He's stubborn, and we can't do much to change that:
> just learn to work with him.  I'm disappointed that I have to point
> this out: haven't you learnt anything from previous discussions with
> him?
>
> Felipe, I suggest you put this in your commit message:
>
>    This patch implements --copy-notes for 'git cherry-pick' so it can
> copy notes in the same way that 'git rebase' does.
>
> That is, if it's not too much trouble.
>
> Stop this back-and-fourth nonsense, both of you.  It's degrading the
> community, and hitting everyone's inboxes with garbage.

Thanks.

But let's take a step backwards, what are we trying to achieve here?
We are trying to improve Git, and the indisputable fact is that 'git
cherry-pick' is missing a way to copy the notes.

It's indisputable that this patch implements that, and I did it by
following existing code, and by running the whole test suit for 'git
rebase'. I've done my job already.

Thomas Rast doesn't like the way this is implemented, and nothing in
the commit message would change that.

This is was a sensible community, you would stop ganging up on me,
Thomas Rast would implement copy_notes_for_rewrite(), and add tests
for other commits (git am, git rebase) to check that the functionality
he claims to be so worried about is working properly.

And this was a sensible community you wouldn't complain about me
choosing how to spend my time however I see fit.

I did some work, I sent a patch, Thomas Rast has some issues, I'm not
interested enough in this patch to investigate them, I work on
something else. What's wrong with that?

Eventually I might come back to this patch, and eventually I might
implement copy_notes_for_rewrite, and I might implement the tests that
check for the behavior that I missed, if nobody beats me to it, which
is usually the case, but I think Thomas should put his personal issues
aside, put his money where his mouth is, and implement it himself.

There's nothing wrong with me choosing how best to spend my time. Really.

-- 
Felipe Contreras
