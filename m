Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09031FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 10:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbdFOKbc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 06:31:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:62666 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdFOKba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 06:31:30 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiIgB-1e7h6Z3M1r-00nRU5; Thu, 15
 Jun 2017 12:30:48 +0200
Date:   Thu, 15 Jun 2017 12:30:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
Subject: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
In-Reply-To: <20170306182423.GB183239@google.com>
Message-ID: <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net> <20170306182423.GB183239@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GE3Q3hm5o9/GQdxVi4u6y8DcjV7DKSI43CEASXRFvwTFvHJAduW
 40AwTVO2TrcdJHNvnssHg8XX3HndPbAtrZhbm/3tPqhiAhyx/7GhpGjYBablsG8iyHG9GZq
 AhUbWVUkgQIQBFEOO+8xf/tOuwvDWY9lRZeHP3QOnxcE+xDcgjhESi+IRr2cJiKCLb0KBcX
 NGJT2Dk+/TCBz9raunj4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pQiGx8ZD8oU=:ItG3KDXTQwTDjdWCCN3MHC
 UH5DBfNy8h0tlFtVo/feafZbmzw4CnbjdwWpIHnb+AQXQhDzxXfcBrS1PyBHNSUD9ZoyFuk5c
 r9xV2nX7PK9P1wdlz67Oa8I9ZuUZ7j4sju6fscUxC0VdPZ4JPbLJ6ttRRi+UwG5nSOJEy0LB6
 dCyOrJdu9ZZQiEiWvQriYhD3SiSPZ7BAEjYPLAnMCbECDTcrf3GARIIFJEc/svfM1XK2C1kjU
 mdD/QpL4e/WsMVJip0EZqA1FDnCwCHuY1ZNvNshOSiCr6ZPMzmEDii/sqz3pRUULUi6qseywa
 7JziD3DeKn6pHbjxEKVCuhOl+HP2/vP0fZBHXP3rCtoFm+oerTC3zl95alNwmSZgQtyVi21Bg
 watEDipd0qbfUSdVN//ujTZfGXafJrVfygoEiS4iGRSWp8D8y8hrL5ipBun8Z+An2tGEeQI27
 AsvSS+DmbobyhV28Yn25vH6alDzcgFKJEfIOqfRZHWD6HdzSBRfaeA3tzn5ZcysyWfLFZe0VS
 /qD8WB0Axzhrj/XIvSqBLvWM2fihKbrhq0hixS5lAQADG99uGESdb+B4YoQiEylMdmLVrKDOX
 iVBj3PCF42AqJQxv+NQUzc3pClq+opIYznu+d3i81g6cfMpdoY9WuQMkGWca43pVT2BUXAwRA
 lwC6XTAdlODhnO7oKGmUCh36wL2HZU0CttnDGywIAda4TbLhdIYbfFDqX9ikagOOUZbSwUYDh
 bebHvquxjxt2Is8oNI2h7ESY4KCmpHfziSsQUmUCQkppkIYKzdmyDs5SRmnfHkhXnLa50er0C
 wUQqrby
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I thought it better to revive this old thread rather than start a new
thread, so as to automatically reach everybody who chimed in originally.

On Mon, 6 Mar 2017, Brandon Williams wrote:

> On 03/06, brian m. carlson wrote:
>
> > On Sat, Mar 04, 2017 at 06:35:38PM -0800, Linus Torvalds wrote:
> >
> > > Btw, I do think the particular choice of hash should still be on the
> > > table. sha-256 may be the obvious first choice, but there are
> > > definitely a few reasons to consider alternatives, especially if
> > > it's a complete switch-over like this.
> > > 
> > > One is large-file behavior - a parallel (or tree) mode could improve
> > > on that noticeably. BLAKE2 does have special support for that, for
> > > example. And SHA-256 does have known attacks compared to SHA-3-256
> > > or BLAKE2 - whether that is due to age or due to more effort, I
> > > can't really judge. But if we're switching away from SHA1 due to
> > > known attacks, it does feel like we should be careful.
> > 
> > I agree with Linus on this.  SHA-256 is the slowest option, and it's
> > the one with the most advanced cryptanalysis.  SHA-3-256 is faster on
> > 64-bit machines (which, as we've seen on the list, is the overwhelming
> > majority of machines using Git), and even BLAKE2b-256 is stronger.
> > 
> > Doing this all over again in another couple years should also be a
> > non-goal.
> 
> I agree that when we decide to move to a new algorithm that we should
> select one which we plan on using for as long as possible (much longer
> than a couple years).  While writing the document we simply used
> "sha256" because it was more tangible and easier to reference.

The SHA-1 transition *requires* a knob telling Git that the current
repository uses a hash function different from SHA-1.

It would make *a whole of a lot of sense* to make that knob *not* Boolean,
but to specify *which* hash function is in use.

That way, it will be easier to switch another time when it becomes
necessary.

And it will also make it easier for interested parties to use a different
hash function in their infrastructure if they want.

And it lifts part of that burden that we have to consider *very carefully*
which function to pick. We still should be more careful than in 2005, when
Git was born, and when, incidentally, when the first attacks on SHA-1
became known, of course. We were just lucky for almost 12 years.

Now, with Dunning-Kruger in mind, I feel that my degree in mathematics
equips me with *just enough* competence to know just how little *even I*
know about cryptography.

The smart thing to do, hence, was to get involved in this discussion and
act as Lt Tawney Madison between us Git developers and experts in
cryptography.

It just so happens that I work at a company with access to excellent
cryptographers, and as we own the largest Git repository on the planet, we
have a vested interest in ensuring Git's continued success.

After a couple of conversations with a couple of experts who I cannot
thank enough for their time and patience, let alone their knowledge about
this matter, it would appear that we may not have had a complete enough
picture yet to even start to make the decision on the hash function to
use.

From what I read, pretty much everybody who participated in the discussion
was aware that the essential question is: performance vs security.

It turns out that we can have essentially both.

SHA-256 is most likely the best-studied hash function we currently know
about (*maybe* SHA3-256 has been studied slightly more, but only
slightly). All the experts in the field banged on it with multiple sticks
and other weapons. And so far, they only found one weakness that does not
even apply to Git's usage [*1*]. For cryptography experts, this is the
ultimate measure of security: if something has been attacked that
intensely, by that many experts, for that long, with that little effect,
it is the best we got at the time.

And since SHA-256 has become the standard, and more importantly: since
SHA-256 was explicitly designed to allow for relatively inexpensive
hardware acceleration, this is what we will soon have: hardware support in
the form of, say, special CPU instructions. (That is what I meant by: we
can have performance *and* security.)

This is a rather important point to stress, by the way: BLAKE's design is
apparently *not* friendly to CPU instruction implementations. Meaning that
SHA-256 will be faster than BLAKE (and even than BLAKE2) once the Intel
and AMD CPUs with hardware support for SHA-256 become common.

I also heard something really worrisome about BLAKE2 that makes me want to
stay away from it (in addition to the difficulty it poses for hardware
acceleration): to compete in the SHA-3 contest, BLAKE added complexity so
that it would be roughly on par with its competitors. To allow for faster
execution in software, this complexity was *removed* from BLAKE to create
BLAKE2, making it weaker than SHA-256.

Another important point to consider is that SHA-256 implementations are
everywhere. Think e.g. how difficult we would make it on, say, JGit or
go-git if we chose a less common hash function.

As to KangarooTwelve: it has seen substantially less cryptanalysis than
SHA-256 and SHA3-256. That does not necessarily mean that it is weaker,
but it means that we simply cannot know whether it is as strong. On that
basis alone, I would already reject it, and then there are far fewer
implementations, too.

When it comes to choosing SHA-256 vs SHA3-256, I would like to point out
that hardware acceleration is a lot farther in the future than SHA-256
support. And according to the experts I asked, they are roughly equally
secure as far as Git's usage is concerned, even if the SHA-3 contest
provided SHA3-256 with even fiercer cryptanalysis than SHA-256.

In short: my takeaway from the conversations with cryptography experts was
that SHA-256 would be the best choice for now, and that we should make
sure that the next switch is not as painful as this one (read: we should
not repeat the mistake of hard-coding the new hash function into Git as
much as we hard-coded SHA-1 into it).

Ciao,
Johannes

Footnote *1*: SHA-256, as all hash functions whose output is essentially
the entire internal state, are susceptible to a so-called "length
extension attack", where the hash of a secret+message can be used to
generate the hash of secret+message+piggyback without knowing the secret.
This is not the case for Git: only visible data are hashed. The type of
attacks Git has to worry about is very different from the length extension
attacks, and it is highly unlikely that that weakness of SHA-256 leads to,
say, a collision attack.
