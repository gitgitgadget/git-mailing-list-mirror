Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C8F1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 23:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeCUXvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 19:51:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:52139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbeCUXvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 19:51:19 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP0LT-1evETC3gdL-006Kaj; Thu, 22
 Mar 2018 00:51:17 +0100
Date:   Thu, 22 Mar 2018 00:51:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC][GSoC] Project proposal: convert interactive rebase to C
In-Reply-To: <46112353.MVnaADNoVi@andromeda>
Message-ID: <nycvar.QRO.7.76.6.1803220043180.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <2564070.6kGkNsz7Qa@andromeda> <nycvar.QRO.7.76.6.1803201720090.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <46112353.MVnaADNoVi@andromeda>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-930568946-1521676277=:77"
X-Provags-ID: V03:K0:jIRZucGNPvBdNVq2zh1n0irLCrqb5e65dKLs32Q6QLsl55Dr1+f
 cjoL/b1fGPIQURyyakF8hOKVFgbGvHkQbq6qjhZ9u5T4oncSA2scrjkSNPypsUsa03wKOi3
 ezEBHKzBfkdMLHzVxxob+sQ5Kj2BZVugcPKe6VGoBEcANR1x5lRxoqLHAyqu19qXE0TgbNP
 NI8mnzRTgJBv8rZqup/bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ESsgFW7XIag=:tD9wBRCVECdxdwtdYOR/31
 WdAwkcx8EYXFLi2BmRtK0DKFBe8Fab7hzehnBppBts+3n5W6TCHoaFduy0gAwsnwEqxcvm2Ue
 LFIZGVhQi3QDiXeEC/P0SsJ8vb/mXmIskKjTOzS8RX1OW8e29SMidRt6s1RsV7gsJsTKNSSxK
 QZIM88udxGPY9JwrfBs7a8nCQtMrwNy4KOywqn2tgxWHt7cnuAmEnMfon+MPeIKPqmA3T1L9B
 M445/dePHMFi4JDK0B9GfH1a/a2E9GnXvjY1LynZzQtQSdh+eMOYbic476K2e3balKaUeFP5v
 4JFXusBg+r9K3wjYIaQgc7ZMt1GNgYR5Y6SqogcKKcH+1g7+wwqE+5DNNQXurYOcf8EA/Za+/
 7rD36PExCxhhAPj7jjHraEt4Zv/LW9nD3JKvOv7JgBlnEzZ+tYB9oVFLc5GZJd7FE1xWDjvLq
 Iwr/1d6/gR6T1VOHYydSQc5SIyVKPqnUY/nJKIcNGVMxSGx4Oee27e9UGpNPaHRM5O9228OJp
 Dor8hpGaa2PSXpGqirh7RQ8EvxQwnKJMSdvBPvGrfk7vt2VUCpPhKmhsQsL564y+PZ0JEuMan
 VDSRIgr2HOMRw0ZvllEWz3Rd6RQ5IkcT3YGxtGjLJGFaVsaIW1aKVMt5uTvQUMz0r5sjaUq5p
 4ytqd5HzOocdqQZQD4148OOo7KRvgr6TQ331SdBuJvXUN0GrNACnwksw5KO5ELP+Yqw+zNr12
 O0Dg95yjNpbsODZpm9p1lyJ3PGtxJozA7r4couoJJV9M8XCCXQf6T9H3YNfN6LQBACnkwWiBQ
 yQzGyV/+vGUyOgZYQFZDOKXrJwDA/HjBhMNoe/FoykRfqwLwsM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-930568946-1521676277=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Alban,

On Wed, 21 Mar 2018, Alban Gruin wrote:

> Le mardi 20 mars 2018 17:29:28 CET, vous avez =C3=A9crit :
>=20
> > Also, I have a hunch that there is actually almost nothing left to
> > rewrite after my sequencer improvements that made it into Git v2.13.0,
> > together with the upcoming changes (which are on top of the
> > --recreate-merges patch series, hence I did not send them to the
> > mailing list yet) in
> > https://github.com/dscho/git/commit/c261f17a4a3e
>=20
> One year ago, you said[2] that converting this script "will fill up 3
> month, very easily". Is this not accurate anymore?

Let me read that mail ;-)

*goes and reads*

Well, I was talking about two different aspects to Ivan and to you. I
should have been clearer. So let me try again:

To convert `git-rebase--interactive.sh`, I think the most important part
is to factor out the preserve-merges code into its own script. After that,
there is little I can think of (apart from support for --root, which a
not-yet-contributed patch in my sequencer-shears branch on
https://github.com/dscho/git addresses) that still needs to be converted.
For somebody familiar with Git's source code, I would estimate one week
(and therefore 3 weeks would be a realistic estimate :-)).

Come to think of it, a better approach might be to leave the
preserve-merges stuff in, and teach `git-rebase.sh` to call the sequencer
directly for --interactive without --preserve-merges, then rename the
script to git-rebase--preserve.sh

The other aspect, the one I thought would take up to 3 months, easily, was
to convert the entirety of rebase -i into C. That would entail also the
option parsing, for which you would have to convert also git-rebase.sh
(and if you do not convert git-rebase--am.sh and git-rebase--merge.sh
first, you would then have to teach builtin/rebase.c to populate the
environment variables expected by those shell scripts while spawning
them).

I still think that the latter is too big a task for a single GSoC.

> I=E2=80=99ll send a new draft as soon as possible (hopefully this afterno=
on).

I look forward to reading it!

Ciao,
Johannes
--8323329-930568946-1521676277=:77--
