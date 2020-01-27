Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568FC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 06:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43075214AF
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 06:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA0G3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:29:03 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:45100 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgA0G3D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 01:29:03 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 485fwD3197z5tl9;
        Mon, 27 Jan 2020 07:29:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 266D64184;
        Mon, 27 Jan 2020 07:28:59 +0100 (CET)
Subject: Re: [PATCH v2] git: update documentation for --git-dir
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
 <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
To:     Heba Waly <heba.waly@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b494114d-02ef-599f-4fa0-d7614974a130@kdbg.org>
Date:   Mon, 27 Jan 2020 07:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.01.20 um 03:24 schrieb Heba Waly via GitGitGadget:
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index b1597ac002..cf73f501b6 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -110,9 +110,23 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>  	Do not pipe Git output into a pager.
>  
>  --git-dir=<path>::
> -	Set the path to the repository. This can also be controlled by
> -	setting the `GIT_DIR` environment variable. It can be an absolute
> -	path or relative path to current working directory.
> +	Set the path to the repository (".git" directory). This can also be
> +	controlled by setting the `GIT_DIR` environment variable. It can be
> +	an absolute path or relative path to current working directory.
> +
> +	Specifying the location of the ".git" directory using this
> +	option (or GIT_DIR environment variable) turns off the
> +	repository discovery that tries to find a directory with
> +	".git" subdirectory (which is how the repository and the
> +	top-level of the working tree are discovered), and tells Git
> +	that you are at the top level of the working tree.  If you
> +	are not at the top-level directory of the working tree, you
> +	should tell Git where the top-level of the working tree is,
> +	with the --work-tree=<path> option (or GIT_WORK_TREE
> +	environment variable)
> +
> +	If you just want to run git as if it was started in <path> then use
> +	git -C.

Does this render well? Judging by the precedent set by the descriptions
of -C and -c options earlier in this file, continuation paragraphs
should not be indented and separated by a line with just a plus sign
instead of an empty line.

-- Hannes
