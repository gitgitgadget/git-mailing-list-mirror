Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D3C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 10:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E0A2223C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 10:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgKBKsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:48:14 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:9187 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgKBKsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 05:48:14 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kZXNk-000AQ9-AR; Mon, 02 Nov 2020 10:48:12 +0000
Subject: Re: [PATCH 17/26] diff-merges: split 'ignore_merges' field
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201101193330.24775-18-sorganov@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a1afac59-35c2-18cc-0d11-38d0b9479bf9@iee.email>
Date:   Mon, 2 Nov 2020 10:48:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201101193330.24775-18-sorganov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

micro-nit while browsing..

On 01/11/2020 19:33, Sergey Organov wrote:
> 'ignore_meres' was 3-way field that served two distinct purposes that
ignore_merges (missing 'g')
> we now assign to 2 new independent flags: 'separate_merges', and
> 'explicit_diff_merges'.
--
Philip
