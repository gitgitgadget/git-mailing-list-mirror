From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (May 2014, #02; Fri, 9)
Date: Sun, 11 May 2014 18:03:23 -0500
Message-ID: <537001bbb2ac6_5ae11e52fc34@nysa.notmuch>
References: <xmqq61lewtkf.fsf@gitster.dls.corp.google.com>
 <536d4bd48e3f9_585ea5308b2@nysa.notmuch>
 <xmqqk39suru0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 01:03:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjcmQ-0003NQ-G0
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 01:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726AbaEKXDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 19:03:34 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:48171 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbaEKXDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 19:03:33 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so7190741obc.7
        for <git@vger.kernel.org>; Sun, 11 May 2014 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qAzrSBR7XeRhgaFRq3UN9l7iC3OxOziEfCC0sjLWbSs=;
        b=smzYvLYkMoSJrKt4d1BKemCwKO7jkF88R2JeprUqxX1RrgTAaYbJqlio6LbhFqgfvP
         0jHvLjGPgOoNVcnP8/CLIb04yiYPqTRO3kUx0qwFp6GaTmzdQnNtnBAwM4+8oybg8xDQ
         Nhmi+iLs9873JmQcz3TjBubSpeNdwv2HF/bTdOaR1Zrvs41Kw1cbMZHSAh1Fjcj7zBw7
         0CFim+BlIx41H10enPaUN0A3y44JYnFU4xOoavOdXCDMCdBN9xH2ht87HUwylK2Mp2LA
         Z25e8l4vn+KKDTywARAItI2KMM/CvwbPKL5A/otLtnUWVSPlqCJLAVtELxakUCjJc5Xr
         wHQw==
X-Received: by 10.182.144.194 with SMTP id so2mr28862265obb.31.1399849413293;
        Sun, 11 May 2014 16:03:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p1sm16861536obh.28.2014.05.11.16.03.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 May 2014 16:03:31 -0700 (PDT)
In-Reply-To: <xmqqk39suru0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248683>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
> >>  - remote-hg: trivial cleanups
> >>  - remote-hg: make sure we omit multiple heads
> >>  - git-remote-hg: use internal clone's hgrc
> >>  - t: remote-hg: split into setup test
> >>  - remote-hg: properly detect missing contexts
> >>  - remote-{hg,bzr}: store marks only on success
> >>  - remote-hg: update to 'public' phase when pushing
> >>  - remote-hg: fix parsing of custom committer
> >>   (merged to 'next' on 2014-04-22 at fed170a)
> >>  + remote-helpers: move tests out of contrib
> >>  + remote-helpers: move out of contrib
> >>  + remote-helpers: squelch python import exceptions
> >> 
> >>  As there were announcements for these two to be maintained as
> >>  independent third-party projects ($gmane/248561, $gmane/248583),
> >
> > Clarification: after Junio unlilaterally blocked any further progress
> > towards grauduation to the core, which was the intention since the very
> > beginning.
> 
> After seeing your repeated attempts to spread misinformation, I was
> planning to totally ignore you, but because "What's cooking" is one
> of the important project-wide report, I'll respond one last time.
> 
> Even though I was originally leaning towards moving them into core
> (after all, why would I have merged the bottom three commits to
> 'next' otherwise?), I was later convinced, during the discussion
> that started with John Keeping's objection [*1*], that I was wrong,

Funny how you simply put a reference to the objection, and don't even
mention it, even though I asked you multiple times to state clearly what
was this "argument" that moved you so deeply. Even now the link you
posted is to this same thread, not John Keeping's objection.

Since you have failed to clarify, I'll make a guess and assume it's this
one[1]:

  I do not want to end up in a situation where an update to Git is
  blocked by a distribution because git-remote-hg is not updated to
  support newer versions of Mercurial sufficiently quickly; this
  previously happened in Gentoo due to git-svn and meant that was stuck
  on 1.7.8 until 1.7.13 was released [2].

First of all, John Keeping is not arguing that such situation *will*
arise, he is arguing that it *might*. Well, an asteriod *might* wipe all
humans on Earth tomorrow, should we all act like it *will* happen, throw
away all our money and run naked on the streets? No, we assess what is
the *likelihood* that such an event would happen.

That's what sane human beings do all the time; we try to calculate the
future using the past and logic as a reference. That's why you see most
people not check their chairs before sitting, they assume the chair
functions correctly, even it *might* be broken, and indeed sometimes
they are and they fall, but it happens so rarely that it doesn't make
sense to worry about.

But you are not like that, are you? To you is enough that something
*might* happen to act like it *will*. I told you the hypothetical event
that John Keeping was talking about would not happen, we have checks in
place to ensure that it doesn't[2].

And you don't use history as an indicator of the future; there hasn't
been *a single* change in git-remote-hg that was needed for newer
versions of Mercurial. The only one was extremely recent, and I didn't
catch it sooner because I wasn't testing for hg's development version,
which I am now.

Moreover, the reason of the failure was that I wrote my own custom
push() method, which relies on things too deep in the API, and those
things do change from time to time. To mitigate the possibility of that
happening I'm planning to contact the Mercurial developers to see how it
would be possible to change their API so I wouldn't need my custom
push() method in the future, and therefore if they change something
inside their push() method, that change wouldn't hit us.

But you are not interested in that are you? You are not interesed in how
likely is the event, nor on mitigation strategies, you only care that it
*might* happen, even though in reality it proably never *will*. Perhaps
you do check every chair before sitting.

Let's assume that it *will* happen (it won't), what is the worst case
scenario? The users of git-remote-hg might get some broken
functionality, but that would happen regardless if they are in the core,
contrib, or out-of-tree. 'make test' might break and prevent packages
and other people to build correctly. This is a real issue, however, it's
not impossible to solve (nothing is), and there's many ways to deal with
this:

 a) Distribute remote-hg tests separately. This is actually how my patch
    series started: t/remote-helpers was separate from the other tests.
    This way we can tell distributions that they shouldn't rely on these
    tests passing always.
 b) Add a new test_expect_success_maybe. This way distributions can keep
    running the tests, but if something fails the build wouldn't stop.
 c) Just remove all tests. Given that there are tools in the core
    already without tests, actually, a few foreign scm tools don't have
    any tests at all: `git archimport` and `git quiltimport`.

There could be a combination of a) and b), so we have a special location
of tests that might fail but we want to run anyway and warn if they do.

Problem solved.

What other problems would remain? It's hard to say because you never
actually clarified what you meant by John Keeping's "argument".

Even more; let's assume we don't go for any solution and include the
tests as they are, and let's assume the issue *will* happen (we know it
won't), wouldn't it make sense to wait until it does to make such a
drastic decision?

I know bees can sting pretty hard, but I've never been stung by one, I
just avoid them calmly. Should I be afraid of something that has never
happened? No, like any sane human being I use the past to predict the
future, and I assume I won't get sting if I act the same way I have
acted before. But apparently you act like something that has never
happened, will.

So let's recap:

 1) That issue that was mentioned won't happen
 2) No, really, it won't happen
 3) We are already doing things to mitigate the possibily
 4) More mitigation strategies are coming
 5) We can negate all the negative outcomes by making the tests optional
 6) If and when such an issue happens *THEN* we should act, not before

In other words; that argument is bullshit from every angle you look at
it.

The fact that you were convinced by such a bad argument is rather
worrying.

Moreover, I've been operating under the assumption that these tools
would get into the core, working very hard, fixing every bug,
implementing every feature, answering every question, going above and
beyond the quality of every other similar tool *by far*.

And then from one day to the next you say; "sorry, somebody said
something and I've changed my mind. Nyah nyah nyah!".

Honestly, after all this work I would have expected a little bit more
thought into this. At the very least some discussion. Not this "I'm not
going to explain it to you, re-read John's mail" bullshit.

This is fucked up.

> and if they moves outside contrib/, the best direction for them to
> go is not to the core but to become independent third-party plug-in
> for allow users to pick up the latest without being restricted by
> our release schedule to ensure no-regressions to the entire system.

If by "no-regressions to the entire system" you mean "so our test suite
doesn't fail". I already gave you multiple ways to work around it, the
most extreme is to simply don't include the tests.

> At some point I have to decide what would be the best next step, and
> your counter-arguments did not make much sense to me.

Really? WHY?! When did you said so? Where is the explanation.

All you said is "I'm convinced".

> Is making that decision as the maintainer unilateral?

Yes, when you make the decision by yourself without considering any
other point of view, that's unilateral.

> I would not mind asking the others, as your discussion tactic seems
> to be "repeated voices start sounding like a chorus, and a chorus is
> project concensus".
> 
> Those who are observing from the sideline, please raise your hand if
> you think the three-line "Clarification" Felipe gave us is a fair
> and accurate clarification.  Anybody?

Funny. This thread is titled "What's cooking in git.git", and nobody
that has worked on this is Cc'ed.

If your objective is for this mail to be ignored, this is definitely the
way to go.

> I'll stop wasting time even on fact-checking from now on whenever
> you say anything.  It's not worth the project's time.

Essentially you want to have the last word, stay on your high horse, and
avoid any discussion, so even if you are wrong, it will look like you
were right. How convenient.

> [Reference]
> 
> *1* http://thread.gmane.org/gmane.comp.version-control.git/248641/focus=248643

That's the wrong reference ^. Are you ever going to provide this
"convincing argument"?

[1] http://article.gmane.org/gmane.comp.version-control.git/248167
[2] https://travis-ci.org/felipec/git

-- 
Felipe Contreras
