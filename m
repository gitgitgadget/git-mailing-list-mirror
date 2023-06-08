Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237BC7EE29
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjFHTxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFHTxD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:53:03 -0400
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 12:53:00 PDT
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7512733
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:53:00 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id 7Lgnqq8LXqd5l7LgoqmjnY; Thu, 08 Jun 2023 20:52:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1686253979; bh=ajuheu7LtKwZ2HCBQ8TCYSoExDIZiGNJVbw2wLdomJY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=llyj7Cjo1z8SrBc+2y6suzh9M8LK4x14Q1HAJ64TbJCUEDJx2xMpsu5vxsrA5dgJv
         CgCbSKaALtyeD11YoiZ923ukexbJiglWuCXpHQLZ8OKb1muJ0IIB8OqVb5keev4s2I
         /22Sl3wjjikUGhA4kq/yHNy++ZeqxpHpa7jFh+VASqBOUebnxSm/T47o9lf5JEC3Yd
         GYAiFOPm1RjkzPWYY7IC4CX+3sdKkVdaeAIK8nd9yOFLfgALn8/fUAB10NuP1Bt5wK
         fscueTZ4n01x0SyJ7qG2JTp6Qz0lu+7mQBRAo3Nha1RMc+gXrTJb/aNu/knCAmKtwg
         +SN7mvX1OiUsA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UpJwis8B c=1 sm=1 tr=0 ts=6482319b
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=8pif782wAAAA:8 a=UVq9kkz1AAAA:8
 a=Fk9MtFMfzEVvCX5-jb0A:9 a=QEXdDO2ut3YA:10 a=cj1MdrFz4QqTewr_IyK1:22
X-AUTH: ramsayjones@:2500
Message-ID: <1d31a8a6-1e45-bc42-2485-ff39f3cea24b@ramsayjones.plus.com>
Date:   Thu, 8 Jun 2023 20:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] gitformat-commit-graph: describe version 2 of BDAT
Content-Language: en-GB
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686251688.git.jonathantanmy@google.com>
 <d4b63945f6d52e68a4760393f787acde0fccc312.1686251688.git.jonathantanmy@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <d4b63945f6d52e68a4760393f787acde0fccc312.1686251688.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFPNcwwoD+snmIvSxKLLvAwuv9x2ZOFXJAe2DJo0t3pPB2wpol4WpXqEeE60Z47Q1akGAEOwzOVKPJeezMVa+/V/F/hy4gazdWBSQlZHx5kVTs3lc3AF
 fv/uGdKaxEfLM/GTrqqp2OmFdCt/ymkMQzjteImjM6xOV6XxF2KJ6+KySen98DbS7wjNOfYdhz1i1P88TSyKrY7sJwRUQzu8YYY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/06/2023 20:21, Jonathan Tan wrote:
> The code change to Git to support version 2 will be done in subsequent
> commits.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/gitformat-commit-graph.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
> index 31cad585e2..9dab222830 100644
> --- a/Documentation/gitformat-commit-graph.txt
> +++ b/Documentation/gitformat-commit-graph.txt
> @@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
>  
>  ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
>      * It starts with header consisting of three unsigned 32-bit integers:
> -      - Version of the hash algorithm being used. We currently only support
> -	value 1 which corresponds to the 32-bit version of the murmur3 hash
> +      - Version of the hash algorithm being used. We currently support
> +	value 2 which corresponds to the 32-bit version of the murmur3 hash
>  	implemented exactly as described in
>  	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
>  	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
>  	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
> -	in Probabilistic Verification"
> +	in Probabilistic Verification". Version 1 bloom filters have a bug that appears
> +	when int is signed and the repository has path names that have characters >=

s/int is signed/char is signed/ ?

ATB,
Ramsay Jones

> +	0x80; Git supports reading and writing them, but this ability will be removed
> +	in a future version of Git.
>        - The number of times a path is hashed and hence the number of bit positions
>  	      that cumulatively determine whether a file is present in the commit.
>        - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
