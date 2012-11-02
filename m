From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 19:39:21 +0100
Message-ID: <CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
	<20121102144618.GA11170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUM9Y-0005ki-OT
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 19:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933965Ab2KBSjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 14:39:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57569 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930Ab2KBSjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 14:39:21 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3895145obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=znJoj6P5BsEGsdrAJg5lMLwCF7NgAk1WpV2qwSoFATg=;
        b=WcGuin6ZEMG1Aswljy9lFTtYGy9wrx7QiQuykoxP1mzkE7A8bn5DaYegDuxy9ZpMNp
         0q5sZEdHKsOcNdNRiqEpOXlZamuEWWtu5gu3PHkAFfKVAExFf8Oahm35KfciXUsdkaie
         jhT5WXFDKpGDsCQORa9jYyr5e1FIFBdFA2nf8IMYON5T1BiaOlFRILWKW/6YYh79p+gu
         2sQOTvXZPq3JFQOwgTObrDohA/GK78FIhKWFXwvHWd/gGLwjd+5lkffhQC7hCF+YQfP9
         PDy2x+MWnYOf/W/rOsmb33enpfAhRZf+4B9gjtcJtzot2lhxeJAGhyw6K8E75CkobGFS
         tvVw==
Received: by 10.182.38.101 with SMTP id f5mr2086385obk.80.1351881561192; Fri,
 02 Nov 2012 11:39:21 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 11:39:21 -0700 (PDT)
In-Reply-To: <20121102144618.GA11170@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208967>

On Fri, Nov 2, 2012 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 31, 2012 at 05:11:39PM +0100, Felipe Contreras wrote:
>
>> > As a patch
>> > submitter, you ("generic you") want the attention of others as
>> > reviewers. It's in your own (again "generic you") interest not to put
>> > them off, in the same way as it's up to the submitter to argue why a
>> > patch is desirable and correct.
>>
>> Ah, so you are making me a favor by reviewing the code?
>
> I do not want to get embroiled in a discussion of manners and netiquette
> (or, for that matter, nazis). But I think this point is worth calling
> attention to, because it seems to be at the crux of the matter.
>
> Basically, my opinion is that yes, he is doing a favor to you by
> reviewing the code. Just as you have done us a favor by submitting the
> code.

Who cares about _us_? What is important is the bigger picture, git,
the project, and its users.

Yes, some people might think only about themselves, and that's their
choice, but I don't think us (the git project) should worry about
making me favors, only about improving the project.

> And this is not specific to this topic or to you as a submitter.
> It is a part of how the open source process works.

I disagree. The open source process works not by making favors to each
other, but by everyone sharing and improving the code, by
*collaborating*. "I review your code if you review mine", or "if you
by me a bear in the next conference" is not the spirit of open source,
although it might happen often.

> We have an existing code base that works well. It certainly has some
> bugs, and it certainly is missing some features. But people use it every
> day and are happy. The maintainers of that code base would want it to
> improve over time, but they would also have to be careful not to
> introduce regressions. And not just specific regressions in behavior; I
> mean regressions in overall quality. A half-implemented feature that
> crashes is worse than no feature at all. A change that fixes one bug but
> hurts the readability of the code, leading to many future bugs, is a net
> negative.

Indeed, but that has nothing to do with _us_ making _us_ favors, this
is about the *project*.

And having said that, this particular remote-hg helper is meant for
the *contrib* area, it's not half-implemented at all, and it's
certainly not crashing, or at least nobody has shown any evidence of
that. And for that matter, I'm sure I can point out to code that sits
in contrib that does meat that criteria (it's half-implemented, and
might even crash).

I know that you didn't mean otherwise, but in the context of
remote-hg, this seems hardly relevant.

And even if this wasn't for contrib, and this was half-implemented,
and this crashed... he still wouldn't be making _me_ any favors. The
review is for the project, not for me.

> So when a contributor shows up with code, we are very grateful that
> they've spent their time improving our software. But at the same time,
> we must recognize that the contributor is generally scratching their own
> itch. And we must make sure that in doing so, they did not hurt other
> people's use cases, nor regress the overall quality of the code base.

I fail to see how any code sitting in 'contrib/remote-hg' could do any of that.

> It is the job of the maintainer to measure the risk and reward of each
> change and to find a balance in accepting patches. But it's difficult to
> do alone, and that is why volunteer reviewers on the list are very
> valuable. They distribute the reviewing load across many brains, and in
> many cases have expertise in particular areas that the maintainer can
> rely on.

Yes, that is helpful, _for the project_.

> A submitter has scratched their own itch by writing the code. But if
> they cannot cooperate with reviewers enough to get feedback, then the
> maintainer has only two choices: review the patches themselves, or
> reject the change. And when there is conflict with the regular reviewers
> and the submitter, it is a red flag to the maintainer that it might not
> be worth spending a lot of time there.

That would be unfortunate, _for the project_, not for the submitter. I
can still run the code, and I can still share it on github.

Reviewers wouldn't be making _me_ any favors. It's the project that
benefits, and it's for the project that they should do it, or for
themselves, not for me.

> Does the code base suffer for this in the end? Perhaps. There are
> features we might reject that could have benefited everybody. But we
> might also be saving ourselves from the headaches caused by poorly
> thought-out changes. The system cannot work if everybody does not show
> up and cooperate.

Maybe, but most probably not. Take a look at this example:

% git log --oneline contrib/hg-to-git
44211e8 Correct references to /usr/bin/python which does not exist on FreeBSD
0def5b6 hg-to-git: fix COMMITTER type-o
b0c051d hg-to-git: don't import the unused popen2 module
af9a01e hg-to-git: use git init instead of git init-db
96f2395 hg-to-git: rewrite "git-frotz" to "git frotz"
2553ede hg-to-git: abort if the project directory is not a hg repo
6376cff hg-to-git: avoid raising a string exception
37a12dd hg-to-git: add --verbose option
13bf1a9 hg-to-git: fix parent analysis
1bc7c13 hg-to-git: improve popen calls
90e0653 hg-to-git: handle an empty dir in hg.
7c0d741 hg-to-git speedup through selectable repack intervals
98d47d4 Add hg-to-git conversion utility.

Is this fully implemented? Is this not crashing? Is the people
involved showing up and cooperating?

It doesn't look like that, yet, it has not given you any headaches,
probably because it's segregated in the contrib area, which what I
have tried to do with my patches. _Precisely_ to minimize possible
headaches.

Perhaps this is a case of double standards.

> Now, as for this specific topic: it is proposed for contrib, which means
> that expectations are lower, and the rest of git does not suffer too
> much if it has rough edges. At the same time, it also means that it
> could live fairly easily outside of the tree. In fact, I think Michael
> and others have been reasonably happy with their own out-of-tree
> implementation.

It certainly could... to the detriment of the project.

> I do think the proliferation of various implementations has made it hard
> for users to see which ones are worth trying. So I think there is value
> in carrying something in contrib/, as it would focus the attention of
> users, and of other developers to make improvements.
>
> So I think what I'd like to do is take your latest series into pu, with
> the intention of merging it into next soon, and then cooking it in next
> for a while. That would hopefully make it very easy for people following
> 'next' to try it out and see how it compares in the field with other
> tools they have used (the msysgit one, or others).

Excellent! I do agree that this would make it easier for everybody:
users to try it, developers to contribute, and keep track of the
changes, etc.

> I'm a little worried about hurting progress on the msysgit version; it
> sounds like the functionality of your implementation is at parity with
> that one (thanks to both you and Johannes for answering my other email
> asking for a summary).  Johannes did mention that the design of their
> tool was meant to eventually facilitate more backends. That's something
> that might be valuable; on the other hand, that development hasn't been
> happening, and there has been no effort lately on getting it merged into
> git.git. I don't want to hold working code hostage to a future plan that
> might or might not happen.  So I hope by keeping it in next for a bit,
> that will give msysgit people time to check it out and mobilize their
> efforts to improve their version if they would like.

Fair enough. I do think my version would facilitate more backends
because the code is very simple and it should be easy to see what you
need to change, and you don't need to get familiarized with any
framework, or classes of classes, and so on. I also think that if
needed, I could come up with such a framework as well, and the
resulting framework would be much simpler.

As a rule, I don't see much value in writing a framework that works
only for one case, that smells more like over-engineering. If we had
two cases (hg and bzr), then we might be able to know with a modicum
of certainty what such a framework should have. So I would prefer to
have two standalone remote-helpers, and _then_ do a framework to
simplify both, but not before. But that's my personal opinion.

Now that I have free time, I might be able to spend time writing such
a proof-of-concept remote-bzr, and a simple framework. But I would be
concentrated on remote-hg.

That would be the last one of the supposed advantages of the msysGit
remote-hg approach, and I make emphasis on supposed because we don't
know _for sure_ if the current framework would be useful for a
remote-bzr or not, *not* because I'm trying to offend anybody (in case
anybody is thinking that). Hopefully that would show the people that
have been working on this other tool that there is indeed value in
this code, put aside their personal differences and work together _for
the project_, but I wouldn't be holding my breath.

But to me _first_ what is important is to provide the functionality to
users, and _then_ is how we organize the code to make life easier for
us (the project).

Cheers.

-- 
Felipe Contreras
