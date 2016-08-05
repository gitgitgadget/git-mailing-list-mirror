Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA702018E
	for <e@80x24.org>; Fri,  5 Aug 2016 08:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934727AbcHEIVY (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 04:21:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:53485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbcHEIVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 04:21:16 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LtJ5T-1b8JHl0c9b-012r3t; Fri, 05 Aug 2016 10:20:50
 +0200
Date:	Fri, 5 Aug 2016 10:20:47 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Stefan Beller <sbeller@google.com>
cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608050925240.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com> <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qb8G5npAMb1sT7UVF026UVK0K6NyNAM91TrWYPS9jSPeak+tu6R
 di6ryId8drKAmrDrAZTSyDGpIQjm3EoUxVMwbChWp1t8YU5KOhTAr4iq/4SoUdZ+fY1sx/C
 dNSpFomDcTC2KeOrN6ru9bYAfnZT+9oK0givd4q5W3+lvrD9UnHAjN4dcCIXkCjrDbsUS5A
 s6nRWrtLFJ6PQ9X6XSO8g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mw3OQ3GkzFc=:NNTcDcQx3RhR/fjpv2ss+d
 wSigxRPSSo1KN/nurjwZRUq77EuPlTJOTQH6bbRPved21Z79XTGbeZ+7iKBV4FsYJDOLljIt5
 ZCVmmfWsRq6TUQch+aWMxbRZnbEOkCNlAoJzSMvKzVdu5bbyFtaThhwBxnanog4Eft7/taACI
 nLXURH+m8FeCGaEFIdOTNgWb95VxJ123LEbLYTndM6GDqEPcQuFkBm7qsKcs3u4Tg8lvepW8A
 ChM2/UYpGaFWc4GJQb709KDSZ4B236JzWhUs9mzrIu2vkFe9fHnBC48awUOYcAuu1q0Jc9hqn
 cUPDhOyNy7g1iiJK1OM1M4e9e8xM+BZjaMPSQkiczOR6Le8BTwYmWQmG9tHmqqYyNq2lz60Nf
 NvJ7p1oKekItBAjOmulv4TtwxF6krWtl+qrwLnCRRTlNODgxMIrn3R/rGV0CAU/Tj1+PtYhnW
 5E4KaB532EzvmgBmHuRDarIPpefzMt+yJ2HGEmstX7u1QR5lnJy+8/LB0xQsuhIHa9lKkna1e
 QMJ26gwmBP+0P0FgHYWVxGNs/0tgyoy2sd0w/dAWrtKN3gCUSFsHM+mJ3j9/acHKok9WTsT4h
 j6Z3LC31GE4QJjKTNpgavDPA1VICb2wjGTCawzF8bFFokKqBR0AxEgW6bOtL/MFQO1u3wJguN
 RGXLrcMxQIlsT0b7Y7ytP+XbasNiIph5WqgIVsJbxdzqfAQ9GobdOvmPdiSL+cWJg9lkshext
 u2lCFRPFYIYtRg9fcuDqWTAqWZhBRsqsg2/6RfX57Magm7V/A7fX54hdWE8kyK88cjPi0UPyZ
 eLiQG6v
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stefan,

On Thu, 4 Aug 2016, Stefan Beller wrote:

> On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >> If we were to change our workflows drastically, I'd propose to go a
> >> way[1] similar to notedb in Gerrit, or git-series,
> >
> > Gerrit is a huge, non-distributed system. Complex, too. If we change
> > the patch submission process, we should make things *easier*, not
> > *harder*. So I think Gerrit is pretty much out of the question.
> 
> I did not propose to use Gerrit or git-series or git appraise.
> 
> However whenever I see these projects talking to each other, the talk
> focuses on a "unified review storage format" pretty often, which would
> make them compatible with each other.

Unless you have a splendid idea how to integrate that unified format with
our review process on the mailing list, I think this makes for a fine
discussion elsewhere. I'd really like to focus on the Git project and its
patch contribution process in this here thread.

> So then I could choose git-series, while you could go with git appraise
> (although that is written in go, so maybe too fancy already ;)

I think you misunderstood me in a big way.

New languages are awesome. I play with new toys whenever I find the time
(and streamlining the contribution process would give me more time for
that). You are talking to a person who implemented the Householder
transformation in Postscript, a 6502 assembler in Forth, and a music
composing system in Emacs Lisp. No language is to fancy for me. "me", as
in "me, personally".

Now let's think about Git for a moment, and its language choices, and the
rationale behind them. The majority of the critically important code is
written in C. Is C a good language? Decent, yes, but of course also
limiting, Resource leaks are very easy to overlook, and we have a share of
them. No object orientation, so when we need to "subclass", we have no
compile time safety. The pre-processor constructs make static analysis
nigh impossible. Plenty of downsides. So why was it chosen? Developers are
*familiar* with it, that's why. Similar considerations apply to the use of
shell scripts, and to Perl, to a certain extent.

I am not talking about contrib/ of course. That's fair game, it contains
only non-critical/fringe stuff.

Note that the same rationale goes for choosing to accept patch submissions
via mail to a list that is not subscribers-only.

When it comes to inviting developers to contribute to your project,
personal preferences become irrelevant, the deciding factor becomes how
easy it is to join. Is the language popular, many developers already
familiar with it? Is the build system readily available? Are the
maintainers responsive?

I vividly remember my reaction to Darcs, for example. It's written in
Haskell. I am a mathematician originally, so Haskell appeals to me. Did
the choice of language appear to be designed to keep contributors out? To
me, it looked that way.

Other example: submitGit. I really like what its intention. For a while, I
even hoped to move my *own* patch submissions to submitGit. I planned to
help get the kinks out of the code by contributing to it. It is written in
Scala, using a web application and testing framework I have not
encountered elsewhere. I struggled with installing it locally and wrapping
my head around the coding paradigms, for 1.5 days (which was all I could
afford at that time). Then I had to give up. Which made me very sad. I
would not have written my mail-path-series.sh tool if submitGit had been
written in node.js, for example, with which I am familiar enough to jump
right in.

So I hope you understand better now why I find Rust a poor choice for
something like git-series, because it should not waste contributors' time
by insisting that their price of entry is learning a new language they are
unfamiliar with, using a new packaging system, installing a new build
setup. I would find Clojure, Crystal or Swift just as poor a choice. Even
node.js. It is just too much of a "Keep Out" sign for busy developers. And
all the developers worth their salt are busy.

> > Additionally, I would like to point out that defining a way to store
> > reviews in Git is not necessarily improving the way our code
> > contribution process works. If you want to record the discussions
> > revolving around the code, I think public-inbox already does a pretty
> > good job at that.
> 
> Yeah recording is great, but we want to talk about replying and
> modifying a series? So if I see a patch flying by on the mailing list,
> ideally I could attach a "!fixup, signed off by Stefan" thing to that
> patch. (I said "thing" as I do not necessarily mean email here.

Right. I briefly considered suggesting a new tool that would operate on
attachments, integrating tightly with the local git.git checkout. Briefly.
I had to reject this idea because I do not think that requiring new tools
just to contribute to Git would fly well.

> > I guess I have no really good idea yet, either, how to retain the ease
> > of access of sending mails to the list, yet somehow keep a strong tie
> > with the original data stored in Git.
> 
> Does it have to be email? Transmitting text could be solved differently
> as well.

Well, you can only convince old-timers like Junio and Peff incrementally,
by showing them something that makes their life easier, and that they do
not *have* to use.

Additionally, keep in mind that the single thing *all* potential
contributors have in common is access to email.

So yes, I think that any improvement would have to happen incrementally,
opt-in. Meaning: on top of the current process.

> With git push/fetch we can interact with a git remote and pertain the
> state (commits, ancestor graph) at a full level even including notes
> that comment on commits.

Including much more, in fact: *any* kind of data.

But how to build on top of the current process, where some reviewers jump
in via NNTP, for crying out loud? How to ensure the integrity between what
is flying around as mails and what is present in the Git repository?

> git send-email/format-patch recently learned to include a base commit

You may have noticed that my mail-patch-series.sh-generated code
submissions contain that base commit. But they still do not contain the
SHA-1s of my local commits corresponding to the patches, and even if they
did, the replies with suggested edits would most likely have lost said
information.

I also hate to break it to you that git-send-email is not going to be part
of any solution.

> You wrote:
> > In short, I agree that our patch submission process is a saber tooth
> > tiger that still reflects pre-Git times. While we use Git's tools, the
> > workflow really tries to cut out Git as much as possible, in favor of
> > pure mails with non-corrupted, non-HTML patches in them, a charmingly
> > anachronistic requirement until you try to use state-of-the-art mail
> > clients to send them.
> 
> And there are two ways out:
> * either we teach git how to deal with emails (completely, i.e.
> sending+receiving)
> * or we change the development model (e.g. no emails any more)
> 
> There is no golden third way IMHO.

There are plenty more options.

In Git for Windows, I would accept patches via mail (curiously, nobody
tried that in the past 12 months, not that I recall). I accept Pull
Requests. I try to use patches mentioned in issue comments (!) and apply
them.

The point is: you do not *have* to limit yourself to accepting patches
*only* in one way.

Another option would be to come up with a non-opinionated tool that helps
with submitting *and accepting* patches via mail. Non-opinionated, as in:
it does not expect to write an entire raw mail and have that entire raw
mail transmitted intact. It could, for example, generate human-consumable
plain text and *also* an attachment that the tool understands. This tool
could then even show a GUI to help with inspecting the relevant
code/patches.

Yet another option would be to have a tool that integrates with the Git
repository of the Git mailing list represented by public-inbox.

Plenty more options.

Ciao,
Dscho
