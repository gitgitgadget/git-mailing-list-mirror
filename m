Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC6B20954
	for <e@80x24.org>; Wed, 22 Nov 2017 20:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdKVURc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 15:17:32 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:25120 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdKVURb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 15:17:31 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:580d:40ec:c1e:d5b3])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 7A8A2B00535;
        Wed, 22 Nov 2017 21:17:28 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Louis Bettens <louis@bettens.info>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Subject: Re: [PATCH] fix french translation
Date:   Wed, 22 Nov 2017 21:17:28 +0100
Message-ID: <3937091.4fae5A5SOV@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.13.0-1-amd64; KDE/5.37.0; x86_64; ; )
In-Reply-To: <20171122172440.15106-2-louis@bettens.info>
References: <20171122172440.15106-1-louis@bettens.info> <20171122172440.15106-2-louis@bettens.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, 22 November 2017 18:24:40 CET Louis Bettens wrote:
> Signed-off-by: Louis Bettens <louis@bettens.info>
> ---
>  po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/po/fr.po b/po/fr.po
> index 4deae3318..a12a2ae37 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -14331,7 +14331,7 @@ msgstr "git worktree add [<options>] <chemin> [<branche>]"
>  
>  #: builtin/worktree.c:17
>  msgid "git worktree list [<options>]"
> -msgstr "git worktree prune [<options>]"
> +msgstr "git worktree list [<options>]"
>  
>  #: builtin/worktree.c:18
>  msgid "git worktree lock [<options>] <path>"
> 

Good catch! I guess the segment switched directly from fuzzy to translated.

I'll queue it for the next version which we should not wait for long.

Thanks
