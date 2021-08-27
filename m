Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8983BC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEEA60F45
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbhH0Lsk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 27 Aug 2021 07:48:40 -0400
Received: from shark2.2a.pl ([213.77.90.2]:52578 "EHLO shark.2a.pl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233376AbhH0Lsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 07:48:39 -0400
Received: from wrasse.2a.pl (wrasse.2a.pl [213.77.90.7])
        by shark.2a.pl (Postfix) with ESMTP id 943471750881;
        Fri, 27 Aug 2021 13:47:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 2a.pl
Received: from shark.2a.pl ([213.77.90.2])
        by wrasse.2a.pl (wrasse.2a.pl [213.77.90.7]) (amavisd-new, port 10024)
        with ESMTP id Aom6yK-24BGq; Fri, 27 Aug 2021 13:47:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.1.26])
        by shark.2a.pl (Postfix) with ESMTPSA id C06C11750887;
        Fri, 27 Aug 2021 13:47:44 +0200 (CEST)
From:   Krzysztof =?utf-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
To:     Christopher Yeleighton via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christopher Yeleighton <ne01026@shark.2a.pl>
Subject: Re: [PATCH] pretty-options.txt: describe supported encoding
Date:   Fri, 27 Aug 2021 13:47:44 +0200
Message-ID: <2623327.rHeH4EdoKx@localhost.localdomain>
In-Reply-To: <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
References: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com> <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dnia piątek, 27 sierpnia 2021 12:46:22 CEST Bagas Sanjaya pisze:
> I think POSIX character maps and encoding are the same, what are their
> differences? Reading iconv(1p) [1] doesn't give definition of the former.
> 
> [1]: https://man7.org/linux/man-pages/man1/iconv.1p.html

System encoding providers are code, POSIX character maps are data.

Chris



