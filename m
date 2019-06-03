Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C64E1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFCV6V (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:58:21 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:34912 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfFCV6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:58:20 -0400
Received: from bsmtp7.bon.at (unknown [192.168.181.101])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 45Hnjh6DlGz5tp9
        for <git@vger.kernel.org>; Mon,  3 Jun 2019 23:09:12 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45Hnjh3tYlz5tlB;
        Mon,  3 Jun 2019 23:09:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 57AF920F5;
        Mon,  3 Jun 2019 23:09:11 +0200 (CEST)
Subject: Re: [PATCH] am: add --check option
To:     Drew DeVault <sir@cmpwn.com>
References: <20190603142523.3826-1-sir@cmpwn.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <34b269e6-0172-42a3-b7b0-f0c7751007a4@kdbg.org>
Date:   Mon, 3 Jun 2019 23:09:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603142523.3826-1-sir@cmpwn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.19 um 16:25 schrieb Drew DeVault:
> +--check::
> +	Instead of applying the patch(es), see if they are
> +	applicable to the current working tree and/or the index
> +	file and detects errors.

I have to wonder how --check works when 'am' applies multiple patches.

When the second patch in a patch series depends on that the first patch
is fully applied, what does --check do? Without the first patch applied,
then a naive check of the second patch will certainly fail, doesn't it?

-- Hannes
