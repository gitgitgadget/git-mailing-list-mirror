Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732F920248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfCKRsQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:48:16 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:40941 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfCKRsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:48:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44J5DY1zNyz5tlJ;
        Mon, 11 Mar 2019 18:48:13 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3FAB720FF;
        Mon, 11 Mar 2019 18:48:12 +0100 (CET)
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
To:     Anthony Sottile <asottile@umich.edu>
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org>
Date:   Mon, 11 Mar 2019 18:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.19 um 23:41 schrieb Anthony Sottile:
> git init longname-repo
> cd longname-repo
> touch f
> git add ..\longna~1\f
> 
...
> 
> C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>git
> add ..\longna~1\f
> fatal: ..\longna~1\f: '..\longna~1\f' is outside repository

This has nothing to do with long vs. short path names. It would report
the same error when you say

  git add ..\longname-repo\f

-- Hannes
