Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE4F1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeIYDgk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:36:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33673 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeIYDgk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:36:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so138614wrs.0
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQkCOTgx8Ujif+I7O2ECMx8dLJA3WzVIfsDY68KbV6c=;
        b=qvyXSMC0qh8u/yPJvmvj2wLwnp2KP3XkMGx+QTZhF4x/ggPf6DZTlmIzs6zUIKcXYZ
         2kLIXivV4xCUIURwQGZgSNyW/PsZz+1Oz2VmeRY21F46CZeiEoQmW9acIPMrhjOmcgBp
         w9YZfQaAQRB/uEajHPPlQPdCivMcMT5PQjRhe85vGgB9Ps+hhhmrajbTTUyq0iRIESvr
         pwSstjo68VElYd4PIvkCzutOoWGrXLfAlPXGv/9MkWIAWBBMYyEASztDYimJVsCP8Lkt
         Asz+D729dZsKVPCJDYCrF/sSrNCdfNvFtdmWbM/S00aSUAmRxqBvZxruUqWDR7YjBVS5
         /CGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQkCOTgx8Ujif+I7O2ECMx8dLJA3WzVIfsDY68KbV6c=;
        b=Uyf/VNk63Q5oLVYqL/xyJ0+5SJg5ikW/Khxp/a40+lKplQCfRSMc4oa9zPLU2m/MTq
         xR2yQqMS+TB+1Onz+pTxrcPnEgNw0z4NlZPCzwc2YdNB5wkQp7T4Sz19tqKq1ms0764L
         bOZwujz7pCyfTphfx+TlpkD6Ph43VqPWWWBVTGD4vpJvljkSK+eMvXV/A58uhT6yzsgR
         +pKTfmBnKc5X0pS2zjH3MmgjSlPW8miagpPE5yMyNqlx9CcnjTeyfQVSEhEysvpXSBUJ
         B1dKpBYkNgpS1UyupxynLG0PsT8cUp2+OBYPjV7WILpTi+C1NJ03jnTUdNeHSQaraDBg
         LZWA==
X-Gm-Message-State: ABuFfoiDrrINoBAthn3r5e1QLbDC2r6+QuLVFMDBC+1LphxPsqnz8E1B
        aX+WTDnbLOUn2TZ18FPxvDRi92UP
X-Google-Smtp-Source: ACcGV613IWCGSRk/ELu2Liwwtf8KJYRz/xPkgCmtiL0s9CUvbIqzxLKZyDds+kND9P6Cy/KHAs2a8A==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr475508wrg.24.1537824746863;
        Mon, 24 Sep 2018 14:32:26 -0700 (PDT)
Received: from localhost (x4db15232.dyn.telefonica.de. [77.177.82.50])
        by smtp.gmail.com with ESMTPSA id b74-v6sm293624wma.8.2018.09.24.14.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:32:25 -0700 (PDT)
Date:   Mon, 24 Sep 2018 23:32:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, peartben@gmail.com,
        git@jeffhostetler.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
Message-ID: <20180924213223.GG27036@localhost>
References: <pull.41.git.gitgitgadget@gmail.com>
 <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The index v4 format has been available since 2012 with 9d22778
> "reach-cache.c: write prefix-compressed names in the index". Since
> the format has been stable for so long, almost all versions of Git
> in use today understand version 4, removing one barrier to upgrade
> -- that someone may want to downgrade and needs a working repo.

What about alternative implementations, like JGit, libgit2, etc.?

> Despite being stable for a long time, this index version was never
> adopted as the default. This prefix-compressed version of the format
> can get significant space savings on repos with large working
> directories (which naturally tend to have deep nesting). This version
> is set as the default for some external tools, such as VFS for Git.
> Because of this external use, the format has had a lot of "testing in
> production" and also is subject to continuous integration in these
> environments.
> 
> Previously, to test version 4 indexes, we needed to run the test
> suite with GIT_TEST_INDEX_VERSION=4 (or TEST_GIT_INDEX_VERSION=4).
> 
> One potential, but short-term, downside is that we lose coverage of
> the version 3 indexes. The trade-off is that we may want to cover
> that version using GIT_TEST_INDEX_VERSION=3.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 372588260e..af6c8f2a67 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1484,7 +1484,7 @@ struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
>   * Index File I/O
>   *****************************************************************/
>  
> -#define INDEX_FORMAT_DEFAULT 3
> +#define INDEX_FORMAT_DEFAULT 4
>  
>  static unsigned int get_index_format_default(void)
>  {
> -- 
> gitgitgadget
