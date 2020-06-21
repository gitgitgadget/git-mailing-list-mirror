Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B87AC433DF
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB07D2527A
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 20:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="kGDSbMa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgFUUOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:14:47 -0400
Received: from lkcl.net ([217.147.94.29]:55497 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgFUUOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 16:14:47 -0400
X-Greylist: delayed 1408 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 16:14:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=s6DwSx7mSFze60//kAnV+OMQQgUh6NhBRbxeJbhcWFU=;
        b=kGDSbMa9xY1sXZH4lyPJU5kCcMubX41Q6Y8FEc4t1yb6QeFJkdfJWFdrmXQk6uTgSFyIXMvrZ7ieY7gP76ICPG4cgMn6lcNtxQxlzIMQ9cjY5XNbilpcB4TzIRKpX0ZhtmgLn1hmY1tFibFnOcjMJJz2++ZqWFStZf+qDQNiwpM=;
Received: from fizzy ([10.5.0.2] helo=localhost)
        by lkcl.net with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1jn5zg-0005My-Ej; Sun, 21 Jun 2020 19:51:16 +0000
Received: from lkcl by localhost with local (Exim 4.80)
        (envelope-from <lkcl@localhost>)
        id 1jn5zQ-00GHpb-4k; Sun, 21 Jun 2020 20:50:52 +0100
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To:     simon@bocoup.com, git@vger.kernel.org
Cc:     lkcl@lkcl.net
Subject: Social Justice Movements [was: Rename offensive terminology (master)]
Date:   Sun, 21 Jun 2020 20:50:23 +0100
Message-Id: <20200621195023.3881634-1-lkcl@lkcl.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lkcl@lkcl.net

> From: Simon Pieters @ 2020-05-04 17:20 UTC (permalink / raw)
>   To: git
> 
> "master" is an offensive term, as it can be interpreted as being
> slavery-origin terminology. See

simon,

sadly i regret to inform you that both the subject line that you've
used, and the assertion that you make - that "master" is automatically
an inherently offensive term - is what a lawyer would call "leading
the witness".  it is a false correlation and unfortunately nobody
has picked up on this in a significant way.

it would have been far better and much less problematic not to have
made any false language-based assumptions as the *fundamental basis*
for this entire conversation, by using, for example, the following
neutral and objective words:

    "some people may believe that there is an implication - false or
    otherwise - that the use of the word master in git implies a
    corresponding association with slavery.  whilst i appreciate that
    this is a technical list, in light of today's current social
    climate i would welcome open and honest discussion on this subject"

do you see the difference?  instead of indicating that you respect
that this is a technical list, and *invite* people to discuss it,
you opened with a *demand*, backed up by not one but *two* false
correlative assertions: one in the subject and the second in the
opening sentence, which has proven difficult for people to unpack.

i notice also in follow-ups that you also use similar language and make
similar assumptions, which _are_ picked up on and found to themselves
be *offensive by readers*.  in light of the topic being to change
the use of an offensive word, this is highly ironic!  (i am delighted
to then see that you apologised and indicate that this was in no
way intentional).

my observation is however that you have a pattern of this type of
false-correlative language usage that you may wish to examine more
closely, in order to not mislead or offend others.  do not think
that you are alone in this!  we all do it, myself included,
unintentionally.  our strength of character is in how we react
when it is *pointed out* to us our mistakes, and it is a hugely
positive sign to see that you are well-intended and wish not to
cause offense to others.

we have also engaged in a discussion on our list, provided some insights
into this topic.  as an ethical technology advocate with a responsibility
and a duty to consider the full implications of the use of my skill,
i have been thinking about this "political movement" to change the
landscape of engineering terminology for some years.

summary: it's not a good sign.

interestingly, one of our team members opened the discussion with
a similarly loaded question:
http://lists.libre-riscv.org/pipermail/libre-riscv-dev/2020-June/008259.html

    "should we avoid the association with slavery?"

which is again a highly loaded / charged / false-correlative question
(that i immediately picked up on).

the first follow-up simply pointed out that there are a huge number
of alternative overload meanings for the word "master":
http://lists.libre-riscv.org/pipermail/libre-riscv-dev/2020-June/008263.html

    Record-master
    Film-master
    Tape-master
    Digital-master

    Master (as in teacher)

followups on this include document management commonly-used phrases:

    Master copy
    Master document
    Master Bill of Materials

do you notice that *at no time* is there *any* association in any one's
mind with "slavery"?  nobody gets offended in Eastern countries when
they meet a "Master"!  it is a word of *deep* respect!

another follow-up goes into detail about the critical importance of
the use of the words "master" and "slave" from an engineering
perspective (we are implementing a processor: the Wishbone Specification
for example *has* to use the terms) as well as providing further insights:
http://lists.libre-riscv.org/pipermail/libre-riscv-dev/2020-June/008264.html

    the engineering meaning of master and slave is as follows:

    * master specifies unequivocably the action required.  this is
      an atomic contract

    * slave carries out that action unequivocably and atomically.

    in other words it is an atomically guaranteed 100 percent
    inviolate and 100% accurate transferrance of *information* from
    one source to another.

    any violation of that contract has such severe consequences in
    engineering (catastrophic data loss in the case of git, and loss
    of life in the case of mission critical real time control systems)
    that to consider anything other than this type of contract is
    unthinkable and flat-out impractical.

this reply also points out that the current motivation for changing the
meaning of the word is, sadly, for the purposes of "Social Justice"
that have at their heart a guilt-ridden desire to forget history
by eradicating words from common usage, with complete disregard for the
fact that the word has multiple meanings.  the "if you're not with
us you're against us" false-correlative argument that has caused untold
misery and strife throughout human history.

this then led another of our team, who has a degree in Liberal Studies
and Literature, specialising in the study of slavery, to write about
the dismaying ongoing inversion and distortion of ethical and liberal
movements:
http://lists.libre-riscv.org/pipermail/libre-riscv-dev/2020-June/008277.html

he points out in particular that the current "Social Justice" movement
has all the hallmarks of a modern-day religion!

https://newdiscourses.com/2020/06/postmodern-religion-faith-social-justice/

so i leave that with you to consider, and the observation that i am
witnessing a huge amount of guilt and deep-seated unease over this topic,
which is perfectly understandable and we - all of us - need to feel
comfortable being able to express that unease in a public way (being
part of an open movement after all), and to feel that we are being heard
and respected.

yet... at the same time recognising that this is *engineering terminology*,
for which, due to ongoing legacy usage, a substitute word would cause far
more harm than allowing the continuing use of that word.  further, that in
an *engineering context* and in other contexts, that word simply does
not have or cause offense in any way except in the minds of those
who - and this is a whole new subject - *choose to be victims*, and in
some contexts its usage is a deep and fundamental sign of respect!

in short: i invite everyone here to consider whether to choose to
"react" to the Social Justice Movement / Religion - (become mired and
victimised by it), and instead to focus on continuing to apply their
superb engineering skills to develop technically excellent code, whilst
at the same time remembering at all times to be deeply respectful and
conscious of the fact that people *are* going to raise these and many
other Social Justice style topics on public technical mailing lists,
and to give such people the space they need whilst also reminding
them of the core goals of the project on which they have brought up
that Social Justice topic.

respectfully,

l.

