Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DAC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjC0Osi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjC0Osf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 10:48:35 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F946B8
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 07:48:33 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1009ECA1253;
        Mon, 27 Mar 2023 10:48:33 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:948:2c:9be7:96af] (unknown [IPv6:2600:1700:840:e768:948:2c:9be7:96af])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CD742CC8319;
        Mon, 27 Mar 2023 10:48:32 -0400 (EDT)
Message-ID: <42b9b692-88a2-5ff7-e857-20bd1f9bb0f2@jeffhostetler.com>
Date:   Mon, 27 Mar 2023 10:48:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/4] Fix a few split-index bugs
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
 <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/23 6:45 PM, Johannes Schindelin via GitGitGadget wrote:
> I received an internal bug report that after upgrading from v2.39.2 to
> v2.40.0, some users ran into the following error message:
> 
...

Very nice. I like the new bit mask and getting rid of the double
negative strip/write logic.


Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>

Thanks!
Jeff

