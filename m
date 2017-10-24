Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CCB1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 21:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbdJXVEL (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 17:04:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:58194 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbdJXVEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 17:04:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yM5Nm2TwXz5tlC;
        Tue, 24 Oct 2017 23:04:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E4D0D207B;
        Tue, 24 Oct 2017 23:04:07 +0200 (CEST)
Subject: Re: Consequences of CRLF in index?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
Date:   Tue, 24 Oct 2017 23:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 19:48 schrieb Lars Schneider:
> I've migrated a large repo (110k+ files) with a lot of history (177k commits)
> and a lot of users (200+) to Git. Unfortunately, all text files in the index
> of the repo have CRLF line endings. In general this seems not to be a problem
> as the project is developed exclusively on Windows.
> 
> However, I wonder if there are any "hidden consequences" of this setup?

I've been working on a project with CRLF in every source file for a 
decade now. It's C++ source, and it isn't even Windows-only: when 
checked out on Linux, there are CRs in the files, with no bad 
consequences so far. GCC is happy with them.

-- Hannes
