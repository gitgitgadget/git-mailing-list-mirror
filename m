Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F04B20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbcHDQFI (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:05:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:65245 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933816AbcHDQFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:05:04 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MUTSJ-1bdD180JGt-00RM1l; Thu, 04 Aug 2016 17:58:09
 +0200
Date:	Thu, 4 Aug 2016 17:58:07 +0200 (CEST)
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
In-Reply-To: <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608041730130.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GBNXwBzbRHhWz+/RBLYMS+ub2gR/HM3r8neAJFEdD1Uo8ODhkq6
 QG8SMzK1wq+OBSoYt/M8E1E2nYo6JcU5xxMHc9DDErWjwPJMv4D9Ss4a4U+ehC4Em3iz40b
 ZGYRUyV1vwEWU8cYAFUgZW2zKzPJW6YaT9wFJJ2mMLanNi4g8MHanDKsKojE63nPI/ZGYoX
 6WRxmF/p82UUh5+vEV7UA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XwyBy9N/MZE=:OGHLDBPXMh5LZWcoMx+bf1
 RF/c2uRcX6cN0gtfie1wXQ45nVLaT4neGP9NRLV5ErMuuxrgKk2qJvEgTJluGER2EwOq2ah2w
 moGZhG7hMkX8SKPb2xIYeJLtOJ8tbIwX6oPKj+WcAUJlQabum70tr02PYYVYXhp99D040gJbw
 Bi0L+ENc0Tp88bC4MlT3Dfz6GHByXAUdTxB5BgaLtN3lsLeKXg4/kIV/l6GmB47n8jEmB1tQp
 9KAZjv06ueGzYSXkNIRFEWc/BobJcId+wuEZlRu20FRAzNQegjlMUePRGJ9nJVJeYgNA3/CMn
 SpEV7Uk2Yl0LUxQs+dLRDD74IJClRK3ynq7yb0R5WpqybaKW5JQOIoZmVsNM+FKw7l4g7dJw+
 euYxsMKMgf+xpgphlDc45bqtjBSFyvpkZvx17To0uxB7MPAIcLLtyWpyC/eJk2a8tu5l1WVYU
 iaOgbR1OdsZPPiOmuvWv5FltgMAquC+hlwssAQ+r4HRr/tZHCGHAQ09PNCWX9u+eRvRk+ZMJB
 Jw1uh07d0pmi8TSce80HIxIMwMYiXzNvoGcYopBnRqBua+ynQZs85UMV/bmFyuny5NlInnejE
 wSKvrzP3sBcaRaGiqY7iNSnUQvINlwuczeZ7zPaLXf/aC8ffepa8mUwCR/7JRZ5UUmxo7ipnm
 TIXQl7rqcdDQKH0KSp1bKJpN+JkJ4Gd6p8jEYT6u8M7R1c9hffVR46wgS6zeahiF1ZE7rt8HN
 x2+U6x0/biehp6QYQgeRXXu/hnQPnlpdrazvr5Ft0/vXuGYIfUOdAejO5/WwSGkw+MHCJGK9p
 ESj+DWZ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stefan,

On Wed, 3 Aug 2016, Stefan Beller wrote:

> On Wed, Aug 3, 2016 at 9:07 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 3 Aug 2016, Junio C Hamano wrote:
> >
> >> On Wed, Aug 3, 2016 at 4:59 AM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >
> >> > I disagree, however, with the suggestion to sift through your `pu`
> >> > branch and to somehow replace local branches with the commits found
> >> > there.
> >>
> >> To be more in line with the "e-mailed patch" workflow, I think what I
> >> should do is to send the version I queued with fixups back to the
> >> list as follow-up.  Just like reviewers review, the maintainer
> >> reviews and queues, the original author should be able to work in the
> >> same workflow, i.e. reading and applying an improved version of the
> >> patch from her mailbox.
> >
> > You seem to assume that it isn't cumbersome for people like me to
> > extract patches out of mails and to replace existing commits using
> > those patches.
> >
> > So it probably comes as a huge surprise to you to learn that this *is*
> > cumbersome for me.
> 
> It is also cumbersome for me, because I never had the need to setup a
> proper mail client that has the strength to apply patches. The need was
> not there as I tend to apply only rarely patches by email, so I can go
> the painful way each time.

The reason is clear, too. Mail clients serve humans. That is their
purpose. Humans do not care all that much whether the text was preserved
exactly as the sender wrote it, except rich text (read: HTML), of course.

> > I got too used to the ease of git push, git pull with or without
> > --rebase, and many other Git commands. Having to transmogrify code
> > changes from commits in Git into a completely different universe:
> > plain text patches in my mailbox, and back, losing all kinds of data
> > in the process, is just not at all that easy. And it costs a lot of
> > time.
> >
> > In short: if you start "submitting patches" back to me via mail, it
> > does not help me. It makes things harder for me. In particular when
> > you add your sign-off to every patch and I have to strip it.
> 
> You don't have to strip the sign off, as it shows the flow of the patch,
> e.g.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> may indicate you proposed a patch, Junio picked it up (and fixed a typo
> optionally), I obtained the patch (via mail, via Git?) improved it, you
> improved it further and then Junio took it and merged it upstream.

Recently, I got yelled at because I took one of Junio's patches, made a
couple of changes, and *added* my sign-off.

Before that incident, I agreed with you that it may make for a nice record
of the back-and-forth that eventually resulted in the patch in question.
Now, I am not so sure anymore.

> > If you change your workflow, I would humbly request that you do it in
> > a way that makes things easier on both sides, not harder.
> 
> When attending the Git Merge conference in May, gregkh said roughtly:
> "We deliberately waste developers time, because it is not scarce.
> Maintainers time is scarce however " and it stuck with me. (and I am a
> developer, not a maintainer ;( so at least the kernel community deems it
> ok to waste my time).

Yeah. It was not the only thing I disagreed with in his talk. To be a
little bit blunt (by my standards, not by LKML's standards, that is): the
Linux kernel mailing list is not necessarily anything I would want to use
as a role model.

I agree that maintainers' time is scarce.

I am one.

So of course I agree with that statement. What I disagree with is that it
is okay to *waste* contributors' time. That's just inconsiderate. And I
say that also because I am a contributor *in addition* to being a
maintainer.

As a consequence, I commend Greg for recognizing that the patch submission
process must be light on the maintainer. And I would have commended him
even further if he had realized that proper tooling should waste nothing,
and no one's time.

> While that is true for the kernel community, I guess it is also true for
> the Git community, unless Junio (and the community) want to appoint a
> bunch of maintainer lieutenants, such that they outnumber the number of
> developers, e.g. divided by areas of the code: a refs backend
> maintainer, a submodule maintainer, ...  or rather by area of usage: a
> porcelain UI maintainer, a git-on-server maintainer.

As I mentioned earlier, I do not care much about following LKML's example.

What I see on this here list is that many a potential contributor is
scared away, that we waste precious time (also the maintainer's) pointing
out in what way certain contributions do not follow the guide lines, and
that even old-timers sometimes submit patches that are white-space
corrupted.

That is a *huge* waste of time. In my opinion, the culprit is that we do
not use appropriate tools. To a mail client, everything looks like a nail.
Wrong metaphor, but you get the point.

> > It would be a totally different matter, of course, if you used the
> > branches I publish via my GitHub repository, added fixup! and squash!
> > commits, published the result to a public repository and then told me
> > to pull from there, that would make things easier. We could even
> > introduce a reword! construct, to make the review of the suggested
> > edits of the commit message easier. I could easily verify that my
> > branch head agrees with the base commit of your branch, I could build
> > proper tooling around this workflow, and it would lighten my load.
> >
> > I guess what I am saying is that we might just as well start using this
> > awesome tool to work with code, that tool named "Git".
> 
> I think Git itself is for the tracking the code and managing it, e.g.
> merging, moving, keeping it. That doesn't quite include modifying and
> creating code (e.g. there is no "git edit" command)

Git is not only for tracking the code. It knows about editors
(core.editor), it can export .zip files (git-archive), it can show
human-readable (not machine-readable) word diffs, etc.

Whenever we needed a certain functionality, we added it.

> If we were to change our workflows drastically, I'd propose to
> go a way[1] similar to notedb in Gerrit, or git-series,

Gerrit is a huge, non-distributed system. Complex, too. If we change the
patch submission process, we should make things *easier*, not *harder*. So
I think Gerrit is pretty much out of the question.

Even requiring every contributor to register with GitHub would be too much
of a limitation, I would wager.

And when I said I have zero interest in tools that use the "latest and
greatest language", I was hinting at git-series. Rust may be a fine and
wonderful language. Implementing git-series in Rust, however, immediately
limited the potential engagement with developers dramatically.

Additionally, I would like to point out that defining a way to store
reviews in Git is not necessarily improving the way our code contribution
process works. If you want to record the discussions revolving around the
code, I think public-inbox already does a pretty good job at that.

I guess I have no really good idea yet, either, how to retain the ease of
access of sending mails to the list, yet somehow keep a strong tie with
the original data stored in Git.

Ciao,
Dscho
