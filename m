Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B8ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiIASE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiIASE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 14:04:26 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB49672EC1
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 11:04:25 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0855FCA124E;
        Thu,  1 Sep 2022 14:04:25 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:392b:419c:9e3f:5ae7:8840])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A9853CC840E;
        Thu,  1 Sep 2022 14:04:24 -0400 (EDT)
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options, allowRemote
 and socketDir
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3a095822-8bf3-4bd0-a308-cdf4ac373428@jeffhostetler.com>
Date:   Thu, 1 Sep 2022 14:04:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/31/22 12:09 PM, Eric DeCosta via GitGitGadget wrote:
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> Introduce two new configuration options
> 
>     fsmonitor.allowRemote - setting this to true overrides fsmonitor's
>     default behavior of erroring out when enountering network file
>     systems. Additionly, when true, the Unix domain socket (UDS) file
>     used for IPC is located in $HOME rather than in the .git directory.
> 
>     fsmonitor.socketDir - allows for the UDS file to be located
>     anywhere the user chooses rather $HOME.

If we add these config settings, we should update the docs
to describe them.

Jeff
