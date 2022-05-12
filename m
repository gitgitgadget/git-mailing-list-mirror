Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E9C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 12:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353572AbiELMLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiELMLS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 08:11:18 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99431218
        for <git@vger.kernel.org>; Thu, 12 May 2022 05:11:14 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1np7ey-00066G-Bg;
        Thu, 12 May 2022 13:11:12 +0100
Message-ID: <a901e47d-79cd-8d23-8c6c-de6299716eca@iee.email>
Date:   Thu, 12 May 2022 13:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
Content-Language: en-US
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05/2022 02:47, Philippe Blain via GitGitGadget wrote:
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 63a2ef54493..22848f84bec 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -710,13 +710,61 @@ dependencies. `prove` also makes the output nicer.
>   Go ahead and commit this change, as well.
>   
>   [[ready-to-share]]
> -== Getting Ready to Share
> +== Getting Ready to Share: Anatomy of a Patch Series
Shouldn't the title also include the magic word 'Contribution'? 
Otherwise the change below may look inconsistent.

>   You may have noticed already that the Git project performs its code reviews via
>   emailed patches, which are then applied by the maintainer when they are ready
> -and approved by the community. The Git project does not accept patches from
> +and approved by the community. The Git project does not accept contributions from
--
Philip
