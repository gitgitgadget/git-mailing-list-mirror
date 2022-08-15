Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C08C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiHOQCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiHOQB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:01:58 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B95B7E9
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:01:57 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D0C423F4090;
        Mon, 15 Aug 2022 12:01:56 -0400 (EDT)
Received: from jeffhost-mbp.local (2.sub-97-44-2.myvzw.com [97.44.2.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC4AF3F47F4;
        Mon, 15 Aug 2022 12:01:54 -0400 (EDT)
Subject: Re: [PATCH v4] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
 <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <47e86c2f-ab13-e8e6-8f69-0a79c3f4c343@jeffhostetler.com>
Date:   Mon, 15 Aug 2022 12:01:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/11/22 7:57 PM, Eric DeCosta via GitGitGadget wrote:
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> Though perhaps not common, there are uses cases where users have large,
> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
> 
> Most modern Samba-based filers have the necessary support to enable
> fsmonitor on network-mounted repos. As a first step towards enabling
> fsmonitor to work against network-mounted repos, introduce a
> configuration option, 'fsmonitor.allowRemote'. Setting this option to
> true will override the default behavior (erroring-out) when a
> network-mounted repo is detected by fsmonitor.

V4 LGTM.  Thanks for your persistence and attention to detail here.

Jeff

