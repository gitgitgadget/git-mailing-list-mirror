Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B37B1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 08:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeJZRNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 13:13:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:33129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeJZRNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 13:13:24 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1g1bcw3zxc-00KxTU; Fri, 26
 Oct 2018 10:37:11 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1g1bcw3zxc-00KxTU; Fri, 26
 Oct 2018 10:37:11 +0200
Date:   Fri, 26 Oct 2018 10:37:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
In-Reply-To: <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810261033440.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com>        <pull.31.v2.git.gitgitgadget@gmail.com> <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:idgkV8p56cieShNbASL8u39gq6896PGiOjPdKw0ayzd6kHD35l7
 fs259aiJ7R5RWqUfVyKd7dmBNyU6NkDNyddL2DXjbFQIPCHj4P69u1d7+BF0L1pcuHRRuLi
 Ebi6joHR3ZtbqyumDP1/R/DYWgFhvkyU60+qO1QXZTFpJvvbFG6ruXO6vJR5xmTYVvcTj23
 z+crQk4pq+si+xjnrQtjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MbU+hb1/BZM=:sBMQowBRZJ4o+wroppnpp8
 n+4+ghSaINFHgQJCoYsfJcBOv9baS34QltbdItX9dZYnzWOVPPUduEZ1sDK6D9Q2vqVy63KFf
 9PV5zuYkvEmJ9mgDU5GnKhkuwzaSwpK7Vdm6/a235N+7Cm6/SqZ2UfhxIyk5JbczwpAQ28EiK
 fhr9ir5oRId7PfpOrARQug15aHPRQFaP37kZ1SnLeUU26Hmob8zsgPPhJyUjzlJqamaUZ6/Z+
 NBccpORq2OFxIgLlwbRSi1VnlOOlj+2fYRcPs5gU7f28Sdh6c8f62EBkOf9zIi+DIuwcftF13
 bVLrbEPeFVfZPsOp3Lp3D7yvyyUDZO/QxRw4PR6MeZzhgnr3ubnbIMe+15xogUBggk9XY1clw
 i8j5d/bAoyJ5sjMkyAu/hXnWQs5y3kWvUruf7CyFwbk2RqxKB+lYXkNF7PoplsIoOMevxrRQk
 qpgZImiHseA9BuOmMV5nkBjSp/V+JBjYeFPsnfUgp2s1wjkoJOs4HZrMG1WXzIhcOoMI5Gnr1
 Oun0qMC0p2v672R+k+b2PtI3BiXMl7dMdYaXZ5vBgRvozvP88trnm39lZoHDnKk5DTW+GY86d
 SOTU1op0ydT7iovGcgaVAGnnaAiK4hIat7gWMdxHBId37eyk5MqA0gbqPXLKWypsIvdzu3nZs
 qHvKIjMaav8Jbny9IVws8F0B7tmHlhsKNOD7pH/FwhW9uHQ67T1/o65KAIPx6J9FHKmuXBj7x
 tNhIU4Roeo3BL79jqSzdlztxsC/bb7wC5FqXASTX8GcaLIDFR0V1lzi5WRKgcSpzD3TQxJgfQ
 cpRODQwukdatv6Qw+9YskQ4UvSzNqvxFOIvJ7MnKvMMOqBzOxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > For a long time already, we have Git's source code continuously tested via
> > Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
> > served us well, and more and more developers actually pay attention and
> > benefit from the testing this gives us.
> 
> What's the current status of this topic?  Has the "p4 daemon gets
> left behind" one resolved to everybody's satisfaction?

No. I was kind of waiting for Luke's answer, and in the alternative I
hoped to find some time to work on trying to reproduce his issues on my
system (but I failed to find said time so far).

> I think that one was the only large discussion on the series (aside from
> "do we want to keep Travis?" subthread, which does not make this series
> undesirable), modulo your "oy oy oy that is leftover debugging I need to
> remove in a reroll".
> 
> The topic was marked as "On hold, monitoring discussion" and it
> seems that discussion has quieted down, so the next step is to see
> an updated series?

I really think that I have to figure out what causes those p4d issues
before I can give you that updated. I *am* interested, to be sure, it's
just that other things seem to get in my way all the time.

One thing that keeps getting in my way, for example, is the performance
issue identified in the chain linter. And I do think that I have to take
this into consideration for another update to this here patch series, too,
by adding `--no-chain-lint` to the Windows phase. There is a similar thing
with `--with-dashes`, too.

Will keep you updated,
Dscho

> 
> Thanks.
> 
> 
> 
