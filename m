Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7BEC388F2
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 10:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5839C223AB
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 10:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgKBKv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:51:28 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:25094 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgKBKv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 05:51:28 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kZXQs-0004dv-Fh; Mon, 02 Nov 2020 10:51:27 +0000
Subject: Re: [PATCH 19/26] diff-merges: get rid of now empty
 diff_merges_init_revs()
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201101193330.24775-20-sorganov@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7dcadc50-5705-68e9-79be-191b5c52241c@iee.email>
Date:   Mon, 2 Nov 2020 10:51:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201101193330.24775-20-sorganov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

micro-nit again:

On 01/11/2020 19:33, Sergey Organov wrote:
> After getting rid of 'ignore_meres' field, the diff_merges_init_revs()
merges
> function became empty. Get rid of it.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
--
Philip
