Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D816C83F12
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 16:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbjH2Q6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbjH2Q5z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 12:57:55 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CBBE
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:57:52 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3A42ACA1294;
        Tue, 29 Aug 2023 12:57:52 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:b47d:7e31:21b3:e66c] (unknown [IPv6:2600:1700:840:e768:b47d:7e31:21b3:e66c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 100A7CC839A;
        Tue, 29 Aug 2023 12:57:52 -0400 (EDT)
Message-ID: <03464c34-2f83-ba26-69be-d3502ed2ed38@jeffhostetler.com>
Date:   Tue, 29 Aug 2023 12:57:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Strange diff-index with fsmonitor, submodules
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20230829005606.136615-1-jonathantanmy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20230829005606.136615-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/23 8:56 PM, Jonathan Tan wrote:
> There is a strange interaction where diff-index not only produces
> different results when run with and without fsmonitor, but produces
> different results for 2 entries that as far as I can tell, should behave
> identically (sibling files in the same directory - file_11 and file_12,
> and both of these filenames are only mentioned once each in the entire
> test).
> 
> You can see this with this patch:

Jonathan, what platform are you seeing this on?

Jeff

