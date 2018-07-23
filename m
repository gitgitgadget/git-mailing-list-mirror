Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B105F1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbeGWViA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 17:38:00 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:49038 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbeGWViA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 17:38:00 -0400
Received: by mail-yb0-f201.google.com with SMTP id v1-v6so906176ybm.15
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ORZ9l8YlzbJibW15whgExzG84zzyJnRf/doYt1lu8zo=;
        b=r2u9TXvZMSyou5mUoEShd8vZnMylwuNRRUmdFdSrO/Xj0CQrdOfHdIT90KUAnUjXT0
         RI9R4ed2XLlJT4kMSxePmGZ1iYx9wJ64+6jmbsA0HAIGABOEm6Zylf3GG0xXUKjBcIcN
         KMFz9nbFHaROAx/yj1OeUej3SaES6WfLmOgO0ALueVZWBKIqXT4e7HFwURbaIRKkeP6X
         OJVk3Zf34XXvjX2AA0j2fr+sYArn2vdJAVdZxqOMDFuAoykPfLP9JKtRhiNHqxCig/Tc
         m4dZ0wL0TNQ/hygtsDoT+05CrVB/fYkEcefo6iQh3kRrbrFBXTwGj0fiMmhcnIkgfsY5
         aZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ORZ9l8YlzbJibW15whgExzG84zzyJnRf/doYt1lu8zo=;
        b=pSui9ZyM76jQQXTyHS4eoXBYdAxCfaQqmTINTz0z1ga25uoBGReZfs73a2E/bPdhPE
         /jUyPfn9ZNq3o6G8LEce0qomfZydAYVUoMBSDRQ4l0q998P6m2DEpKBrZqRZivQjjl7H
         ETI86edvcdzJvN1eDPzabLI1KzBTJg8dV3i4TugH09/xBnOVz21ITXavuNaCmRJC8lfz
         pnK/MXVwOuWocSfbJhkSOskNGbDsvh3Qotfk/wRhcfwS2oHDW5bW+8Z9iBR7ZEg298Ej
         Cw37LKrkiaCG4+vYBXXGetFsd8hL4ZSCwGSENwHAvo7neX7iwx2GyZJIPofW83FsX2Yw
         1rCQ==
X-Gm-Message-State: AOUpUlH/5bcKmbg1+nt0nJLnLYV/YGaxI1lkDQXterbeugnWANFYf2/k
        6H9kb/FK9vXHBo3nL1cKyJ5oWIyjNW7DWp7/kWKf
X-Google-Smtp-Source: AAOMgpeXuTosxyJtwdoKZ3yGG6OSFn0hZ2kkX6xGyWbkjcxT7q1T/zYHdWxJQCKeKkdKG9c/gN7gWPIpdDhdtOtUNVlA
MIME-Version: 1.0
X-Received: by 2002:a25:37cf:: with SMTP id e198-v6mr4021314yba.14.1532378105541;
 Mon, 23 Jul 2018 13:35:05 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:35:00 -0700
In-Reply-To: <20180720163227.105950-16-dstolee@microsoft.com>
Message-Id: <20180723203500.231932-1-jonathantanmy@google.com>
References: <20180720163227.105950-16-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: Re: [PATCH v2 15/18] test-reach: test commit_contains
From:   Jonathan Tan <jonathantanmy@google.com>
To:     dstolee@microsoft.com
Cc:     git@vger.kernel.org, sbeller@google.com, stolee@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +	} else if (!strcmp(av[1], "commit_contains")) {
> +		struct ref_filter filter;
> +		struct contains_cache cache;
> +		init_contains_cache(&cache);
> +
> +		if (ac > 2 && !strcmp(av[2], "--tag"))
> +			filter.with_commit_tag_algo = 1;
> +		else
> +			filter.with_commit_tag_algo = 0;
> +
> +		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));

Should we initialize filter (with {NULL} or some equivalent)?
