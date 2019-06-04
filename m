Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64621F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfFDOnf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:43:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:59367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfFDOne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559659408;
        bh=R1iJa+WKPV5nfa7Kj8tDrISkgpgzYdJQzWrLD+QcLvQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fUCpVrF2awqk7A8ZeKG7xoqqDa6L985DGW0DeqpXMDeKDlZgJlDbESn2a+1k6eIY2
         J1uwPSDpc95nuTRHbUeSt0ZWO8CDwipm2UHV/lsftchzbMAZw9AdcdpYqP8sRnjAgr
         F0zlSGnMe/Z2h+tnvgKS8FZf8UpvCl0WSYy38at0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1hFGcy3ZSB-00Jees; Tue, 04
 Jun 2019 16:43:27 +0200
Date:   Tue, 4 Jun 2019 16:43:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update
 config defaults
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906041641280.1775@tvgsbejvaqbjf.bet>
References: <pull.254.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5zZjoR6j/NeZdApN2DbYIzES7wv3n9/zBgqUoEVWfNCHcQjrgY0
 06vEWPMEPK7Veyrgs0YQPHVrCjkir/xBVBq+Bu1Og+pALAX/9Mrqs9fu+E2OkzxwOi459ze
 ZK1qwLHh2IuDBQLDuR75aCiG/RWuzknYIled1q/jqGs5mQlRZSWFAxfIuiiA3jRgcjkVg/p
 HSQsHS8esxJyvz8uthyUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Sx4/JorsPo=:Vo66+U+RxVuo/fDYLsDK16
 4vefWyUtY2Q0BAGn5cP4zJ4EMb4+7We9jrEZ01qT38L+2F3elUyFHvFLB639xvX77l16dcpBJ
 AxjEkf3D5YuBKJ3h+LsV+n7kBksou+qyJeSnRSjuNfxf+4oa7OYJTlf1JY1sCHWLr0v+HnQ/X
 4VKNyhRJAYRMWBS1GU/ey9PjP4BKrNcbkQhhDWZ0lnlVZNUjP/NL2FIQNmMgQK87DSnRBu9o/
 TS0izEWK/h4vNO9kKXTcJ91bgyeOvRZtn11nL9QdvAfjuqEX5cH/RZwJJae1sv3J0HqPyfNVK
 N07xcCTQu3ounEiKMcrfouDa8hxm3/5WmN14Unbz8K2YjpDDAkqVQM5AxBJLSV02zBlJKkucG
 uWUCh2qx5X328ii6+gmwvV1tkbM1jHFpsEp+B71jgHWDfP9XsKA3unT4jdi5s+J7t5F9MX/nw
 1ege5m+POZuqJfb20yJmKx/9xzPoZHq7djp+gKWAchr9RTUA1q7u53Ql/MxNz39yr7Dd5XjGn
 7Xi2bOVT2O9UF6Y/1zANIKarWfaOaCbGEK1KpZ60Y/vrGMWOyf9vbal1jSgkvd2NJ1X+Ccnpr
 n9R0Knx3SCyIGW9yuq2fnh/HiqsrSGLrLZs3rhZYbvCAAbi5qyOdqpTYNiqyWn+aEoeqTbXW5
 wZrm+HXu4dXmIT29WrnwYfjfUlJzF4o9M41aDXCl2da5OGKJCzRkTALtDsLn5GXabEsX+e6rJ
 myAxhGvXUIR/vbag50nnyENYKCLghlxLoXlT63p5uGsS1nD7jgSt9AaKfX+tPMl5a1hRwyncM
 DaXFEZDhpUkVLzHfomjSxlzBsH/oekEvgnF7g960JJ0Z/P0xtkmKb42Ch0OzgZflCRqFzospu
 T60JoNPSfqT0HAO8hqZRaBGRdFnzrIS8J/SkH5BtMIQSWCmmQgeV9GQW4WSq7r/MN2qZwZ054
 4ieCgV80Vau2Sl1/9xBwYxLkzZ9SX+7POfPSr+FsN67ww1PuRPPVB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 3 Jun 2019, Derrick Stolee via GitGitGadget wrote:

>  1. (Patches 1-3) Introduce a new 'core.size' config setting that takes
>     'large' as a value. This enables several config values that are
>     beneficial for large repos.

I find `core.size` a bit non-descriptive. Maybe `repository.size` instead?

Ciao,
Dscho
