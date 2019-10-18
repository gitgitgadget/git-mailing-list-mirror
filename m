Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B871F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 09:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407785AbfJRJls (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 05:41:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33308 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390553AbfJRJlr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 05:41:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so8933386wme.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+3t6GCF+jlQbw2IlrCrFtv92KhSooNIZtCCBu/VQic=;
        b=aUnRMgyuvf52CoRyGZW/wOzMBWIEroOBtnBvon3/35c/FIdHTOioj/5qHmE4hFNnhN
         55GaW+QihBptInQceFtYq70JoA6TufKHHRQs7iaV4JKo2nZTp7pE07e9ahwrQP1ucI4w
         kCgqrzI53WV9RyinxZNycH3yfM0lkQfXMBwDOrTiHs6kzTAbaAKY14qyxrmtHq7D4as3
         XrRSShDxotCYxpYEY4eIzStVJiG2eNNBUhkulOXRdpFU+3uF0FzHo1OwAyHOisFQ27BN
         NZKQ2ZVO7KTed1r+0JfXy21H8Oxh+QEFYQ5TEOKEZyjr3rHrrLUsQ1owTKneI9HzSCFN
         tlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/+3t6GCF+jlQbw2IlrCrFtv92KhSooNIZtCCBu/VQic=;
        b=ZoTGE15/Fw3lwISJtlcfm4vmiKPlGvfMKer+Fo6YYGsKIiodx0LPokseqO6rACi3Gt
         MKaLiMHIwBWglj6/5dcI45r5Z7Gx3+YmJ+aUjP4TkYt6pzWe6lFbNecaQ8cw+if/f6L2
         lvKwBsvs03HfGhWIXj54CwJ62UJctd3nnjkdZ0YnMtGYzFnzlusHDaXTY9uRW/Yh8j9N
         vWHfxHUNuQbpwZXFYEdsf3GKVIgfsvYXJHlTdHDHyMOv9dnvw1zqPeV9EVVgSJoQ4eH8
         follEZqKFyuwSa1r3Qlr7ya3voskDapbAfoOM33Wowv6ffP/PZEazGT3XI4oAe/My/MM
         MZ9Q==
X-Gm-Message-State: APjAAAUUCXk/uNv1Pwl7Gk/BDZGpcbfIQDU0uWQ9wmva6FoloszZHN/b
        tVB12sm61QHDAoPdHgkcNULzfp5C
X-Google-Smtp-Source: APXvYqyzFaXDZB0OYnhY7MI2+85/N5LdS2LFyuHbCT3mvToqXHh71oVoOUTb3jbDb+rgldoj0C0Xyg==
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr6748913wmt.75.1571391705497;
        Fri, 18 Oct 2019 02:41:45 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id r140sm5849219wme.47.2019.10.18.02.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:41:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 6/7] autostash.c: undefine
 USE_THE_INDEX_COMPATIBILITY_MACROS
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <73607c2e00a87b05da0e374734eb5c4d7d377d84.1571246693.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <836db3ce-2c2a-1d4f-a131-6005fc961f45@gmail.com>
Date:   Fri, 18 Oct 2019 10:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <73607c2e00a87b05da0e374734eb5c4d7d377d84.1571246693.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 16/10/2019 18:26, Denton Liu wrote:
> Since autostash.c was recently introduced, we should avoid
> USE_THE_INDEX_COMPATIBILITY_MACROS since we are trying to move away from
> this in the rest of the codebase. Rewrite the autostash code to not need
> it and remove its definition.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   autostash.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/autostash.c b/autostash.c
> index 722cf78b12..0a1f00d2e5 100644
> --- a/autostash.c
> +++ b/autostash.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_INDEX_COMPATIBILITY_MACROS
> -
>   #include "git-compat-util.h"
>   #include "autostash.h"
>   #include "cache-tree.h"
> @@ -46,7 +44,7 @@ int reset_head(struct object_id *oid, const char *action,
>   	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
>   		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
>   
> -	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
> +	if (!refs_only && repo_hold_locked_index(the_repository, &lock, LOCK_REPORT_ON_ERROR) < 0) {

As I understand it the reason for moving away from hold_locked_index() 
is that it relies on a global variable. While replacing it with an 
explicit reference the the_repository removes the implicit dependency on 
global state, it does not move us away from depending on a global 
variable. I think it would be nicer to change these functions to take a 
`struct repository*` before moving them.

Best Wishes

Phillip
>   		ret = -1;
>   		goto leave_reset_head;
>   	}
> @@ -157,8 +155,8 @@ void perform_autostash(const char *path)
>   	struct lock_file lock_file = LOCK_INIT;
>   	int fd;
>   
> -	fd = hold_locked_index(&lock_file, 0);
> -	refresh_cache(REFRESH_QUIET);
> +	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
> +	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
>   	if (0 <= fd)
>   		repo_update_index_if_able(the_repository, &lock_file);
>   	rollback_lock_file(&lock_file);
> 
