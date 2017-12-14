Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C001F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbdLNX0F (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:26:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:63905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754147AbdLNX0E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:26:04 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEo4s-1eE7e32pUw-00G14E; Fri, 15
 Dec 2017 00:25:57 +0100
Date:   Fri, 15 Dec 2017 00:25:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] version --build-options: report commit, too, if
 possible
In-Reply-To: <20171208172733.GC14261@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712150020400.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de> <908989103a06291e38c8551c447bc73eb781fb26.1512752468.git.johannes.schindelin@gmx.de> <20171208172733.GC14261@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Cekf69zLrM3Tql+ZfBJZCnTmAryseKON/t5YoaowJdGHJRPSI8a
 oJ8ejYwn7SXBljcGZHsQGhqSDnXrg1aWmFbPdrFDzJ2pjhfoaXsg9xymnKZ7OfUYHPCz0AJ
 zJhha6C8PN0icImMcg953KOZnvtZPlhPBiAwy1BJ/uKG8MUzPj5/FuRWSBc9qzyFaBw3rFc
 9+4kkLHqv6Fzw7CeFUvBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YAzDe0ka+4o=:krwyMMoOtdwBZoeTWVFoo6
 AlcuicXeFy1S9rfrztC7v/sc0PG0LTJZUVPl0GoIZHn0TXa60ooE0j3vI4xzXCnAcpycFEkSd
 Y66+l+qiH4BPJSjNd5VbcE0jMuivvYsg14UAYo/5QMyXFMcIEnEzgiqpBsMse5kdmFZ7/lCPW
 NYkuw+OhSVTstSTP5d3nqpldZTNVhJhThIbHkBmxkKvALqMDj2+0SdfMZL6Y8P1R3vnoEeINC
 Vo16OzC2h2iVWkfG+7mt8nIUHgY0wtX1ePCDYSb0D1LZMGZsyTZynvd6l39YI7SCJXHhuXqFA
 fCB2WouTSwsqu360bSZfn/MH/a23lQJQXOaYy6NTPaRF3XIVSItsjjHus/hZ4pEcQk63yEFrS
 DJjjgMOjH5WfKKNL4+OfvIoi9tw5NovRsuYIFUhEtvjdOXPlsw3jgy+ad2g3jNp/Lug6e2Ufw
 WDQeE40a4xdsvC/oqwQNTnT7gGhqIEHW0ryymK+8qNDgAxkmFKiw0H3WlfUeAS2dx/s3LNxqo
 kgv/5o8PB4IhQ3Y7E9200gm5eYdTbBrD7ycP8hQqJi/W7p6chZnjxhvQWxRRx9+PazECddLEA
 qYaGDXQYXuhsuD4K1/p2i3Jis+FZL8NfzQXPjXpZxJnQl0FJqoH8guklbH7B116UOnRII/MXg
 8CCY8Hi7E42tXWVKPeHa/ZCZj1ij5vDS28OKEwxk+HGuBXFrfCd7sgwiKVTv1B7yNBhRBSRbo
 ON/HSCXfRZYIVviHHdKRQNouH1+s/pXJp92ipv8z3GFMxSBHJszPakshOETq3S01VFzw2gXT2
 cWyhT6/lIYhBsCdLNqWpscClxGBAOBCx0FOjA1x+dJiaCqAO8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 8 Dec 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > In particular when local tags are used (or tags that are pushed to some
> > fork) to build Git, it is very hard to figure out from which particular
> > revision a particular Git executable was built.
> 
> Hm, can you say more about how this comes up in practice?

I recently saw a version string on this here list (in a generated patch)
that looked something like "git v2.14.0.chrome".

I sometimes build custom Git for Windows snapshots from commits that I
keep in my own fork. I would expect other people to do the same.

With this patch, at least I can verify very easily whether I have access
to the corresponding commit or not.

> I wonder if we should always augment the version string with the commit
> hash.

That would probably be more confusing than helpful to the end-users.

> E.g. I am running
> 
> 	git version 2.15.1.424.g9478a66081

which is currently good enough, but in the future may clash with another
object, maybe even a commit. Unabbreviated commit names are what I am
after.

> > We need to be careful, though, to report when the current commit cannot be
> > determined, e.g. when building from a tarball without any associated Git
> > repository.
> 
> This means that on Debian, it would always print
> 
> 	built from commit: (unknown)
> 
> Maybe I shouldn't care, but I wonder if there's a way to improve on
> that. E.g. should there be a makefile knob to allow Debian to specify
> what to put there?

I changed the text to "no commit associated with this build". Does that
suffice? If not, what "UI" would you suggest (most likely a new Makefile
variable? What name would you prefer?).

Ciao,
Dscho
