Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A99C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6124560F14
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhHDP6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:58:32 -0400
Received: from avasout04.plus.net ([212.159.14.19]:43886 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbhHDP6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 11:58:31 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2021 11:58:31 EDT
Received: from [10.0.2.15] ([147.147.167.4])
        by smtp with ESMTPA
        id BJAJmz3h1OQhvBJAKmSZD9; Wed, 04 Aug 2021 16:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1628092245; bh=bq3rXPWqdSnLhMyX4JLnLAJDUkrVCf6LcdA3CG87Hv0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YV0K8d5DeYTb38svy/G2Y26pzz2vETyZGTQR6or/BzBqVNgno/eYknywqlxkzeibx
         X082GaqudcYJs9zGcC0/PTLs65aV6dgiEAuRkWEhXG277OcSkxf9aYPBzgPicLjH18
         ROo3yDu3e2D4qH17dGvnZTCSN9sFCfxzOrG50s1AKFGCQ6ezMCFFgPesHE8LqRFjnJ
         T5XrEnvoIj7FdVm5uAfHDapDZ8aYdcF0XtQuM03L3XDliqGQPM9Ssmx7F3He6DdUmX
         5ouiEMJxLF2V+veon815eh6xV4aFcFyrYwYUE/94syUXyk7AB8DnFGdAjLZtGApslY
         URA5xGwq3vZ8w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=ClpcMUpIpdFe3QrT4g3KPA==:117 a=ClpcMUpIpdFe3QrT4g3KPA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=YA1mVlVNuHaAdAA47UUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 08/10] git-rebase.txt: correct out-of-date and
 misleading text about renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
 <8978132397e95accee5676309d81832724aebba5.1628054936.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <eff818fc-9f4d-35db-a4df-8b05408d7d6c@ramsayjones.plus.com>
Date:   Wed, 4 Aug 2021 16:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8978132397e95accee5676309d81832724aebba5.1628054936.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOnlnuOKpMa05qFkP86Q7z6J6pRKdZNfSqgQ7tNNoAWCqwwNpigd4LvslRYjMX12glrHP1r25QBlyilXXR8k7fn6G03rgp0vNaAgRBgfy8aJjnVjBmiP
 6ExIcBpsBkRiD7/68vagCi531NU6pFSNgm123KrURidkDncNq0ES7FeA82qeBed3Uke5D7yyTXUNhw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 04/08/2021 06:28, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Commit 58634dbff8 ("rebase: Allow merge strategies to be used when
> rebasing", 2006-06-21) added the --merge option to git-rebase so that
> renames could be detected (at least when using the `recursive` merge
> backend).  However, git-am -3 gained that same ability in commit
> 579c9bb198 ("Use merge-recursive in git-am -3.", 2006-12-28).  As such,
> the comment about being able to detect renames is not particularly
> noteworthy.  Remove it.  While tweaking this description, add a quick
> comment about when --merge became the default.

The last sentence of the commit message does not seem to apply to
this patch (any more ...?).

[Awesome work on 'merge -sort', by the way!]

ATB,
Ramsay Jones

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index cecdcfff47a..73d49ec8d91 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -340,9 +340,7 @@ See also INCOMPATIBLE OPTIONS below.
>  
>  -m::
>  --merge::
> -	Use merging strategies to rebase.  When the recursive (default) merge
> -	strategy is used, this allows rebase to be aware of renames on the
> -	upstream side.  This is the default.
> +	Using merging strategies to rebase (default).
>  +
>  Note that a rebase merge works by replaying each commit from the working
>  branch on top of the <upstream> branch.  Because of this, when a merge
> 
