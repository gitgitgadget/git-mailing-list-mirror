Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403161FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 12:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757034AbeAHMZS (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 07:25:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:53328 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756239AbeAHMZR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 07:25:17 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwJko-1exKnY3gpK-0184JA; Mon, 08
 Jan 2018 13:25:11 +0100
Date:   Mon, 8 Jan 2018 13:25:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
In-Reply-To: <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kg+0Rdq04scfgRSoAxpIA2F027KR0u+fil4XjuvjWaJPZIcF8P5
 aD01GsuzIAS9+ljdxKxaL0IvY5w8CC04VT9h/XWAMpafIvJkD8bzJpDveFQF9hDXG7mxcPv
 H7QphvHk0T7CoD9kB9Z/bV2ZP0kFhd/SJM9yACWNdxujcrcJmFhH7HJPMgjY5Uprkn1mjDs
 BGXSRlcg8Ir6goD4pb62g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z9JEjOj6Hzg=:S8S/uTjrA8LdCJFUHwrVOH
 RdmA/nEtjnhC1JOqqeo9Sv/YuZm52c6Y7NBYM21TK3u7ljd9nd4AIb+3G108bp6A//dL2ONuC
 L8poGvKmckZLozRnxJfpTNfDrrMMml9zKCJYnDr5CZR120H5sI6VGWTRzMCVtZkzb8eN6QrCW
 qCFQCDZnDim5/l6QmwBdwnm0nxqWIsUWWQMzYsgH7djGk3RjtM8XW3lDa6gknhXOv68BhfvAE
 MTm8lQWasYLks6V/0xVoN0smH/VkrhztEpZfHMzKHzknylbtJHO4noMasNakCr7nV6ZsRKJUN
 90HFSQvqWUGf/+eYd8DYDGNFAIblTNs6PJTdKtwQVEDtFFVqg68yXB7SLNgnvkscgGYBdpaU+
 AgOBAaNgDLjzLVubyXMEo75LuwjUIVgogEUytjkyhJWdkynGZP8bRqv9NhDC6u6QgkmVialYe
 FUt5WwoDkpBmcB4MpaS9psJvtsPTPVmLbKztH0476b7B2v3VjjPoRV1a1vkiptWIS8drB4kGH
 +R3eEpSDYZu6VSpXCpLdReJYij21SgGBhV6EaUtGBZVCKwkmkc3Z5drjGGvO9BQivAyZsOBJx
 i+EP9+KA0kyhB8KhDBFC4Uqf153mFZL370VeQaC/d0VnXiB1WSKzVBIwrSnWI+CSCrEeIJ0Yg
 03s0DS85l5nQ0l+FAkvTQN7+3p0VMRzHB73Tx8D9d07hwLfqV1dpsAtLZljFdRhWVvqScBmQV
 1OQOBqtYTEr4/nC6aQx7tCrGXtK/Ya5reStFrvdUFDiVMF+rudaSb8yGZLQdfme/1VvtYJ3EC
 sFHWz8ua7HtnYrIwe2LDyjmoUsNNsaLqjK0rPFBySC5iIiMHAh+V0OeO6MV7lgzwFqvkbIe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Sun, 7 Jan 2018, Duy Nguyen wrote:

> On Sat, Jan 6, 2018 at 7:51 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Nobody likes to run tests that take too
> > long. And look at this:
> >
> >         ...
> >         ok 1511 - ipathmatch: match 'Z' '[Z-y]'
> >         ok 1512 - ipathmatch(ls): match '[Z-y]' 'Z'
> >         # still have 84 known breakage(s)
> >         # failed 52 among remaining 1428 test(s)
> >         1..1512
> >
> >         real    5m51.432s
> >         user    0m33.986s
> >         sys     2m13.162s
> >
> > Yep. It takes *over eight minutes*.
> 
> I suppose this is because the sheer number of test cases adds a lot of
> shell overhead on Windows. I wonder if it's better to rewrite this
> test in C instead. We start to do some more unit testing here and
> there and kind of abuse the sh-based test framework for this. Having a
> proper unit test framework would be good anyway since it's sometimes
> hard to create a specific scenario with high level commands.

I agree that it would make a ton of sense to use a proper, portable test
framework written in pure, portable C.

However, this ship has long sailed, hasn't it?

Of course, we do have useful stuff in t/helper/. And we have precedent for
more sensible bulk testing that does not require sh to generate or provide
lists of test data, see e.g. the basename/dirname tests. And we could
organize t/helper/ better, including a refactoring to have a single binary
rather than tons and tons of binaries that all link to libgit.a and
take a lot of space (even with LZMA compression, the current test
artifacts take about 90 megabyte!).

If I had the time I would write this up as a valuable GSoC project. Not
that Junio cares. But I do.

Ciao,
Dscho
