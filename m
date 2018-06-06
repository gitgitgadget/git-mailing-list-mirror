Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABAEF1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeFFNfF (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 09:35:05 -0400
Received: from avasout01.plus.net ([84.93.230.227]:52629 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeFFNfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 09:35:04 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id QYabfl62BxrERQYacfxvwM; Wed, 06 Jun 2018 14:35:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Es38UxUA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=Ab81Q3oNE8BwJf4blnsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 07/20] attr: remove an implicit dependency on the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
 <20180606073933.14755-8-pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <62c2ef14-03c4-4602-0e50-242c9edd513f@ramsayjones.plus.com>
Date:   Wed, 6 Jun 2018 14:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606073933.14755-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHsmIVL30y9ApJRyljAS5ZhZqK9y7kONuYggbtkswQcGIL3JshjWIL2tSUbOxFOIYtPvaWbVU2fqLQbRCxylRV/MsV90kX7K1wSKq/0ex/Uw2Pu6CMWP
 XVkyp0T4ag/lUVxzIwsVtBQD+OgHChrEr+08zhPC1FmHCxhvIWwhQndsC6RnOyvqvmbEpI0wXGbDEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/06/18 08:39, Nguyễn Thái Ngọc Duy wrote:
> Make the attr API take an index_state instead of assuming the_index in
> attr code. All call sites are converted blindly to keep the patch
> simple and retain current behavior. Individual call sites may receive
> further updates to use the right index instead of the_index.
> 
> There is one ugly temporary workaround added in attr.c that needs some
> more explanation.
> 
> Commit c24f3abace (apply: file commited * with CRLF should roundtrip

s/commited * with/commited with/

ATB,
Ramsay Jones

