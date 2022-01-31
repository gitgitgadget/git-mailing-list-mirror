Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C8EC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 07:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357885AbiAaHPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 02:15:46 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:63546 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242021AbiAaHPo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 02:15:44 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JnK8m6xx9z5tlD;
        Mon, 31 Jan 2022 08:15:36 +0100 (CET)
Message-ID: <38b59dec-0ae5-ebed-18f0-bec0a3aa3333@kdbg.org>
Date:   Mon, 31 Jan 2022 08:15:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        git@vger.kernel.org
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <aac3f9821c7f8927ab7cb65bd5c443f5a0174068.1643580113.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <aac3f9821c7f8927ab7cb65bd5c443f5a0174068.1643580113.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.22 um 23:01 schrieb Jean-Noël Avila via GitGitGadget:
> diff --git a/parse-options.h b/parse-options.h
> index e22846d3b7b..68f7ae9c31a 100644
> --- a/parse-options.h
> +++ b/parse-options.h

> @@ -339,4 +355,5 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
>  #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
>  #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
>  
> +
>  #endif

An unnecessary remnant from the earlier round?

Except for this, the patch looks good.

-- Hannes
