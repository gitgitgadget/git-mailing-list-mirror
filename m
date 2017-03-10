Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1305D1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934213AbdCJWFG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 17:05:06 -0500
Received: from mout.web.de ([212.227.15.14]:50520 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932724AbdCJWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 17:05:05 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVLoc-1cksBk3lWQ-00YhUi; Fri, 10
 Mar 2017 23:04:47 +0100
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
 <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
 <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
 <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c93a61a4-05d9-8e49-9734-12c81289517b@web.de>
Date:   Fri, 10 Mar 2017 23:04:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:x6+kag5tcqNiTuGodbOgJL8gDLE/uhRk2yVw5azhYEIgXctjLNm
 7LOJsyGYz4+ARg2uYsOkxAIpZQMCr+Yc0ql3rWHuqY9BXt0YQ41wgIoA10MCPJMf0fuvdRm
 OsnK94Tx6/hUNlfBanp4/xfGDvHgkYHOhNC+PtoQ1vhlac8Cps415PZ5ob7P1t6oNiwroHq
 WfK2ahgReSHmSYhHI2Zjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:auOcH4XTD28=:PkdCR45kS0vLDOeuqlTlUk
 k6JWSQgwS0AZ41uA4bLL8jO0VyzIMGJRxQw8aFw715izIuY8IQ+QmeQ1kGjHVMoP+gcOKEoo6
 GjgqvuP9B4PNP4yAfg0rzMz3qE9CSKeF3DZQ4RggJFQ2fFTkJLYdmlXH5lxC7lmbnEx0BVI/D
 DzyAVh31iye+BIMD7qH5Gghjgfazj37d+AZlm6WxKGbVOQeOuhtSnOB5P5i/n8BsOn1bIlzMe
 my6VqlHozP2zFbNKziY6F3I3pvNUIS3QolaZ9zbIWU8iwgTuvYMyGzArFNk2kx8xkq1uobQhN
 ApTSgZZ7wHRIHxhdBrsMLZjCl3GhNafy8D7QPQ98AzgS3AwYbqM7XI2LMHMF9WdtUtCfObhUf
 +Vt7bwZr8zl5BYWuSatTeiOHyQ92ovgFLPjAO6zwCOVic+nOZTGo5V05fQLH5zX//ulOnI8Fv
 e8hJIeLUkSH5SQvMpNpajTAR57W6yLW/syueef/Dkwfn47Fo7PWuA3huJjI8/3JtClPIG0Jg/
 SlrO155derInGQvT30GNRTJxDAqSpHVTQZTXzGW0JYamS94+tEwGRJEe12GQDDUP2VqHVE2Hg
 a/7qAjxfRNi8rgK5WyPtkLp5olr/lyy6guLU8KJKiLNpjpQYV6k6L/luUoqS8EPLnjTyVL2C1
 05j6xOqGYmpyalLor/UYrDEpj0MZJu/FApIntrm5vcsS9KYcx1bl8+X8uWXNaK6Q6kwcf+uU6
 7DBSTLs0cIoaqCR8TT5c0Iqvy96YXAtLjt/lmugyaflN4D+MREYmRGfpGgDpAH9LRsdQy8pcl
 gj1yRr+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.2017 um 21:13 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>
>>> I think this misses the other two cases: (*dst, src) and (*dst, *src).
>>
>> ... and that's why I left them out.  You can't get dst vs. *dst wrong
>> with structs (at least not without the compiler complaining); only
>> safe transformations are included in this round.
>
> I haven't followed this discussion to the end, but the omission of 2
> out of obvious 4 did pique my curiosity when I saw it, too, and made
> me wonder if the omission was deliberate.  If so, it would be nice
> to state why in the log message (or in copy.cocci file itself as a
> comment).
>
> It also made me wonder if we would be helped with a further
> combinatorial explosion from "T **dstp, **srcp" and somesuch (in
> other words, I am wondering why a rule for 'T *src' that uses '*src'
> need to be spelled out separately when there already is a good rule
> for 'T src' that uses 'src'---is that an inherent restriction of the
> tool?).

There are redundancies. This semantic patch here:

	@@
	type T;
	T dst;
	T *src;
	@@
	- memcpy(&dst, src, sizeof(dst));
	+ dst = *src;

would match e.g. this (from convert.c):

	memcpy(&new_stats, &stats, sizeof(new_stats));

and transform it to:

	new_stats = *&stats;

We'd need just one more rule to remove the "*&" part and could then get 
rid of two of the "T src" variants, to arrive at something like this:

	@@
	type T;
	T dst, src;
	@@
	- memcpy(&dst, &src, sizeof(src));
	+ dst = src;

	@ r @
	type T;
	T dst;
	T *src;
	@@
	(
	- memcpy(&dst, src, sizeof(dst));
	+ dst = *src;
	|
	- memcpy(&dst, src, sizeof(*src));
	+ dst = *src;
	|
	- memcpy(&dst, src, sizeof(T));
	+ dst = *src;
	)

	@ depends on r @
	expression E;
	@@
	- *&
	  E

René
