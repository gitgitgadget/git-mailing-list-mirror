Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DDE1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfJHVNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 17:13:08 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10041 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbfJHVNI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 17:13:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46nqnZ2x2bz5tl9;
        Tue,  8 Oct 2019 23:13:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 04A1016C6;
        Tue,  8 Oct 2019 23:13:06 +0200 (CEST)
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned
 types
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
 <pull.288.v2.git.gitgitgadget@gmail.com>
 <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
 <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
 <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org>
 <nycvar.QRO.7.76.6.1910042319190.46@tvgsbejvaqbjf.bet>
 <xmqqr23q68rg.fsf@gitster-ct.c.googlers.com>
 <ff6896de-ba12-6669-d6e0-980ed0fcd1e4@kdbg.org>
 <nycvar.QRO.7.76.6.1910081404310.46@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <584bdc31-f4d7-8bf5-3233-a2695b706e21@kdbg.org>
Date:   Tue, 8 Oct 2019 23:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910081404310.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.19 um 14:04 schrieb Johannes Schindelin:
> So you got what you wished for:
> https://public-inbox.org/git/pull.378.git.gitgitgadget@gmail.com

After having seen the result I do not wish for it anymore. (Not that I
had "wished" for it in the first place...) It does not make the result
any more readable than the original.

I do wish you had rejected Junio's suggestion to introduce
index_pos_to_insert_pos(). It doesn't make the code a lot more readable,
either, in my eyes.

-- Hannes
