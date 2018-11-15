Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39251F97E
	for <e@80x24.org>; Thu, 15 Nov 2018 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeKPE3H (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 23:29:07 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:53015 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPE3G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 23:29:06 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42wqQz6071z5tmw;
        Thu, 15 Nov 2018 19:20:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0A4391D1A;
        Thu, 15 Nov 2018 19:20:11 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: replace an obsolete link with the superseding
 one
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.81.git.gitgitgadget@gmail.com>
 <c78e1b73f0d23657a0723cfcade916097d6abda0.1542280956.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ba9362ee-cac2-4c6f-0e3b-57951eb5aa1d@kdbg.org>
Date:   Thu, 15 Nov 2018 19:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <c78e1b73f0d23657a0723cfcade916097d6abda0.1542280956.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.11.18 um 12:22 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The MSDN documentation has been superseded by Microsoft Docs (which is
> backed by a repository on GitHub containing many, many files in Markdown
> format).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/mingw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index d2f4fabb44..9e42b0ee26 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1028,8 +1028,8 @@ char *mingw_getcwd(char *pointer, int len)
>   }
>   
>   /*
> - * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
> - * (Parsing C++ Command-Line Arguments)
> + * See "Parsing C++ Command-Line Arguments" at Microsoft's Docs:
> + * https://docs.microsoft.com/en-us/cpp/cpp/parsing-cpp-command-line-arguments
>    */
>   static const char *quote_arg(const char *arg)
>   {
> 

Thank you! That's much better than the original obfuscated page name.

-- Hannes
