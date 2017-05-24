Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDE620281
	for <e@80x24.org>; Wed, 24 May 2017 05:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938316AbdEXFpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:45:46 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:29458 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938289AbdEXFpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:45:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wXhFg3nn7z5tlL;
        Wed, 24 May 2017 07:45:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C29264336;
        Wed, 24 May 2017 07:45:42 +0200 (CEST)
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
References: <cover.1495261020.git.j6t@kdbg.org>
 <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
 <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
 <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
 <alpine.DEB.2.21.1.1705231245300.3610@virtualbox>
 <xmqqinkrjkfb.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c36ae9af-b566-5bb3-ad70-ee7f0051ca9a@kdbg.org>
Date:   Wed, 24 May 2017 07:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqinkrjkfb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.05.2017 um 00:08 schrieb Junio C Hamano:
> So in short:
> 
>   (1) Hannes's patches are good, but they solve a problem that is
>       different from what their log messages say; the log message
>       needs to be updated;
> 
>   (2) In nd/fopen-errors topic, we need a new patch that deals with
>       EINVAL on Windows.

Will reroll the patches. Good analysis, BTW. (It was a late discovery of 
mine that nd/fopen-errors is actually the source of the warnings.)

-- Hannes
