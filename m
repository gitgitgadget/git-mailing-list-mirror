Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A681FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 14:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932765AbcLIOfZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 09:35:25 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:51079 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932594AbcLIOfY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 09:35:24 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tZvsQ0VQWz5tlY;
        Fri,  9 Dec 2016 15:35:22 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A033D1CFD;
        Fri,  9 Dec 2016 15:35:21 +0100 (CET)
Subject: Re: [PATCH v2 3/4] real_path: create real_pathdup
To:     Brandon Williams <bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481241494-6861-4-git-send-email-bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6deba49f-52f7-7fb5-2f93-24aa411a7710@kdbg.org>
Date:   Fri, 9 Dec 2016 15:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1481241494-6861-4-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.12.2016 um 00:58 schrieb Brandon Williams:
> +char *real_pathdup(const char *path)
> +{
> +	struct strbuf realpath = STRBUF_INIT;
> +	char *retval = NULL;
> +
> +	if(strbuf_realpath(&realpath, path, 0))

Style nit: blank after if is missing.

-- Hannes

