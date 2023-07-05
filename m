Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33034EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 20:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGEUCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 16:02:38 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA612A
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 13:02:37 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Qx9Yl6WcFz5tlB;
        Wed,  5 Jul 2023 22:02:35 +0200 (CEST)
Message-ID: <87390f51-aa8d-4a25-4d73-0fee04a58f7a@kdbg.org>
Date:   Wed, 5 Jul 2023 22:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 08/10] gitk: add keyboard bind for create branch
 command
Content-Language: en-US
To:     Jens Lidestrom <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <bd498f5b3267a1c61e436447a1d81f693c9abc9d.1688409958.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <bd498f5b3267a1c61e436447a1d81f693c9abc9d.1688409958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.23 um 20:45 schrieb Jens Lidestrom via GitGitGadget:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 351b88f10c0..f559e279b7a 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -9582,13 +9582,13 @@ proc wrcomcan {} {
>      unset wrcomtop
>  }
>  
> -proc mkbranch {} {
> -    global NS rowmenuid
> +proc mkbranch {id} {
> +    global NS
>  
>      set top .branchdialog
>  
>      set val(name) ""
> -    set val(id) $rowmenuid
> +    set val(id) $id
>      set val(command) [list mkbrgo $top]
>  
>      set ui(title) [mc "Create branch"]

Clearly, the lines from the 'remove branch' commit belong here.

