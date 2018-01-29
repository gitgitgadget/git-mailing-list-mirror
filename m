Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3615C1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeA2Umt (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:42:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:49874 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751773AbeA2Umr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:42:47 -0500
Received: from [192.168.0.129] ([37.201.193.1]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnTjW-1fFtKm3kb8-00hec6; Mon, 29
 Jan 2018 21:42:43 +0100
Date:   Mon, 29 Jan 2018 21:42:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] rebase -i: introduce
 --recreate-merges=no-rebase-cousins
In-Reply-To: <5FC5C1765B7648F7A166363BED3AFFA3@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1801292134580.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <e3c3c703f8eae723c4fbbd08d2c329d81179dbee.1516225925.git.johannes.schindelin@gmx.de> <5FC5C1765B7648F7A166363BED3AFFA3@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zVA5YaXYpG7wgvwvFX0hwOXy6zVX9oQfBmeVTimcvizDxnSYKgl
 42kENNLGlewn7jCK1tQUZ+IPkgRfGhk/8n7yCEOz848LnAdLKgkBu/6yZ9i3DV5TZJfDAnJ
 OMSMcezgoZwY8SfR5ar8aWt0FAKWZvviYJ4IsyYcRISqV5faOzTDvrT8kVGYqP4GFMax+Nr
 UMyWvQLHecIrab49cNOBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7q8kePJSRPg=:/Ngg2PhfQl4+y78g/J9HEk
 jmakzfDXJhzsBK5GROUVQJF/We1brVJZErgKvEQXLAIQwK809LTH7kUNOCO9JlfEJSlu2oXfk
 1A0XfAJKGBXwtV5VO89yJbIMRgPSaGo+A78PhqlpnGJRxoY9zmD//KVWIZSNahzS+57+6pLah
 /qtgaPRgRuYc3ERXneZexPuM27otHYEg4KYSktHydC+U5vXDjl5QM0ZtlU40JrQOJ9MEsn64H
 dpnpyvuPJ5kK0c4dkeshqich6Dj3Rs3AnLvFcaFe3ibWMQQqAO/ZIfETXqry//r2+Jbu+nuFE
 OtXqbdsV0mpPh78sIdDQB2Vrk3/wu8Bw7BG+OQwK2ldsGumxauYOVIEtYvDNeC+qqF7XsVE1q
 JzGcNevONjInmTjBlhO95od/zB7VDvALEOgTpdRdKdAbVRVWH1/v0+IxhDQd7Eyc+cqVax7N7
 isV6ufsausmKTKXxWJqMTfUJpNgNzteemyvvnYnpOwcsYEG+Ca9mgP1oFDH0rUG8dIWKviyE5
 pk2A0BECYjaNFclUoPshct7DMIOj+DbWWaMOV48Tfk3s8547EtbuZRLiqUuyH97wwJwhkKGmG
 Zrz4YQH+M04uQn8CsOG5vAA125oQo8N67rn+A9q/hQSNL/4dyteVsScidtp8s9nGYWeaYYJv7
 dAJQodntUcDHKV0RFGXFPwhp2HGkHnV7JJNYo9eLnzv8yfbdaLeA5AKFwbRvB/NkXKouD6bj+
 UpiRrJYOTnxXw5IyZQ1KNGPlYsAQsdzBGLhca5swsSkuW7waAYJnYnKDUIijqEz04c1rvrk09
 I4pcQaAlom1dDut3PaITnpL+AT8m3KLxen81pxZiumYUrPZmXXJl4RuQIUdsOpioYDWaPau
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, 18 Jan 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > This one is a bit tricky to explain, so let's try with a diagram:
> >
> >        C
> >      /   \
> > A - B - E - F
> >  \   /
> >    D
> >
> > To illustrate what this new mode is all about, let's consider what
> > happens upon `git rebase -i --recreate-merges B`, in particular to
> > the commit `D`. In the default mode, the new branch structure is:
> >
> >      --- C' --
> >      /         \
> > A - B ------ E' - F'
> >      \    /
> >        D'
> >
> > This is not really preserving the branch topology from before! The
> > reason is that the commit `D` does not have `B` as ancestor, and
> > therefore it gets rebased onto `B`.
> >
> > However, when recreating branch structure, there are legitimate use
> > cases where one might want to preserve the branch points of commits that
> > do not descend from the <upstream> commit that was passed to the rebase
> > command, e.g. when a branch from core Git's `next` was merged into Git
> > for Windows' master we will not want to rebase those commits on top of a
> > Windows-specific commit. In the example above, the desired outcome would
> > look like this:
> >
> >      --- C' --
> >      /         \
> > A - B ------ E' - F'
> >  \        /
> >   -- D' --
> 
> I'm not understanding this. I see that D properly starts from A, but
> don't see why it is now D'. Surely it's unchanged.

It is not necessarily unchanged, because this is an *interactive* rebase.
If you mark `D` for `reword`, for example, it may be changed.

I use the label D' in the mathematical sense, to indicate that D' is
derived from D. It may even be identical to D, but the point is that it is
in the todo list of the interactive rebase, so it can be changed. As
opposed to, say, A and B. Those cannot be changed in this interactive
rebase.

> Maybe it's the arc/node confusion. Maybe even spell out that the rebased
> commits from the command are B..HEAD, but that includes D, which may not
> be what folk had expected. (not even sure if the reflog comes into
> determining merge-bases here..)
> 
> I do think an exact definition is needed (e.g. via --ancestry-path or
> its equivalent?).

I don't find "ancestry path" any more intuitive a term than the
mathematically correct "uncomparable".

If you have a better way to explain this (without devolving into
mathematical terminology), please let's hear it.

Don't get me wrong, as a mathematician I am comfortable with very precise
descriptions involving plenty of Greek symbols.

But this documentation, and these commit messages do not target myself. I
know perfectly well what I am talking about here. The target audience are
software developers who may not have a background in mathematics, who do
not even want to fully understand what the heck constitutes a Directed
Acyclic Graph.

So what we need here is plain English. And I had thought that the analogy
with the family tree would be intuitive enough for even math haters to
understand easily and quickly...

Ciao,
Dscho
