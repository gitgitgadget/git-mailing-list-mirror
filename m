Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EB8E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbjJHQfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHQfN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 12:35:13 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Oct 2023 09:35:12 PDT
Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004B9F
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 09:35:12 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.17])
        by smtp with ESMTPA
        id pWhLqz089kR9vpWhMqWmPh; Sun, 08 Oct 2023 17:32:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1696782728; bh=k4QyV2UutylSWIcHVWLgqYtYGCqMm2ihHfJiYLvQuxE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lJjT76B9o2k3AZGHKXyxnfiByjO5wezeciOtCC2gU3g0olyrVR5ot6pRwrZB8JVe4
         4ldo3pjOE4g873WLe/Ckbpt+QvAnlls2256aqfGnKbp9WmTPRHHVHRBAUXw4kDWAyt
         hvUBIGIMKwo6r/jkZihLU+qEB6BVnmHKqDEzRpp8/OcvUpzPl1FN6yWwWBwlzab42E
         ZZ56B9tKMt/0taBeSntYL2Xdi6VXFW+3s+E322BPK1o9YVfZc30l+fmpTCmw5CzGBg
         O55uW3zAij58VRey6lAzXKgv/FlZyT4MLaBSmT37lK16OAq8/+xtOzjCetEtyxH/CM
         T+N7aXLtvx5FA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=bOYFndyZ c=1 sm=1 tr=0 ts=6522d988
 a=EVFDtNLPcRUqOc5TlIybJA==:117 a=EVFDtNLPcRUqOc5TlIybJA==:17
 a=IkcTkHD0fZMA:10 a=ZYoz54wrcD9UFsw4g2kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <92beac82-f0fd-452b-858f-453cdf21b71f@ramsayjones.plus.com>
Date:   Sun, 8 Oct 2023 17:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/25] documentation: fix typos
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
 <fffcf580b29153a3c4c7ead3abfb2b621d3a0d46.1696747529.git.gitgitgadget@gmail.com>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <fffcf580b29153a3c4c7ead3abfb2b621d3a0d46.1696747529.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfB9usjEEZl6t4iOaWNG3nbAM0LzzeVkGPeIpENGSQZHxePG08FITpzoEjfAGY3w2lUpDFo0gMb5gb8f8nF8oivZADiTlC/D7+tZ1f6PmovnC8BFKXew1
 LkZLoXCNkr53lNIP9G++ssNl8uzUjlCFcu4yDAe9/9AGvYkOb7tvZtXsqcOT39FnjTbJSNzQ9yMnDo0VSjLa/gYBfp4FUqbmIuY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/10/2023 07:45, Elijah Newren via GitGitGadget wrote:
[snip]
> diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
> index 870e00f2982..42afb953e8c 100644
> --- a/Documentation/gitformat-pack.txt
> +++ b/Documentation/gitformat-pack.txt
> @@ -17,8 +17,8 @@ $GIT_DIR/objects/pack/multi-pack-index
>  DESCRIPTION
>  -----------
>  
> -The Git pack format is now Git stores most of its primary repository
> -data. Over the lietime af a repository loose objects (if any) and
> +The Git pack format is how Git stores most of its primary repository
> +data. Over the lietime of a repository loose objects (if any) and

Hmm, this tyop jumped out at me while this patch
floated past... (at least I assume it is a typo!):

  s/lietime/lifetime/

ATB,
Ramsay Jones

