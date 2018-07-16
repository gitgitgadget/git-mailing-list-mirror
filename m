Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7551F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeGPXiA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:38:00 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:38194 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPXh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:37:59 -0400
Received: by mail-yw0-f201.google.com with SMTP id q141-v6so23897877ywg.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Z/LCP27G5gWL4nstl7l51etGbmLW+nlNzUZas2YIl+I=;
        b=CiVYUY6XedOgDMGPC59o07l/WYCyO8A0FX7JKXcLuSQrGY6311ndM5dCdfHzdORCgw
         pjVmmOhB5m7grgg9FY17L91MjCeLzTgoh5ZwoRN52gPrcgZ9Mj6cKSZ4OZHXpTtUNqW3
         j0CYHb2r4l4Lq6QvJQhP9FvRAVcQ4ic4OFdN7LZILaQjGN9OZN6T7S5B2vhRghDiIJqk
         /80pXKCthv2qKxHjmgT5rw/QJnYEP3AEWhERSfOUQnmJfHT6mcnodBXQ1JxKOX71pY9i
         zV4sewvtBo0fBbq3xq8usnU1kkv8YK5Lj0Li3Pj1st5DsJL0aCPCLXkcQAfgk5V9pnMa
         jCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Z/LCP27G5gWL4nstl7l51etGbmLW+nlNzUZas2YIl+I=;
        b=Fw7SI4TDOp9wAIrd2kRi2LVs724nc20RarVWObzkhilM2fgvb9mqXzbL0+lkw6OIEg
         XXpef4FZOQ7K2/CjagnIetdsZDWMZQDy+SBeJmDvj0sPjNj3SStCDCdaedevE38TRZF4
         xQqu0okkNUEKBCwORJb5ACjWPW29ZvGSMOAcxK5an3JmN9l9McTu421LOR3Cl4UdDXoe
         Er2bEkEnHM+Yj6B16d4lfV7+f+PvxDKZrOARkwnJwvkbT5dSoxrwtASkOdV0wKdmPrWA
         Sv3kC2szUoS1BI6PaL6wajCiRn5GzHR7SkKRhRy+gYd8LQJWycM4DJBBD63+M7ZV0tU7
         YLpQ==
X-Gm-Message-State: AOUpUlEnQ2gzXGz4g+R/TMf5Rp40/beHzQItOJvp2iO0F8+tS7cc0UE9
        2rgJ4wolZjhOuRhtiZvLKgGgATVZ894F+jQZ5xuR
X-Google-Smtp-Source: AAOMgpeG9Cziy31/OxLmNKAIl3cMEdxefX79L0Oxv7YKn5SAjb7o2+2Ng8Sqq3yA2gL0p4GGCvOagEfjekeVWTKvAl3V
MIME-Version: 1.0
X-Received: by 2002:a0d:c883:: with SMTP id k125-v6mr5782824ywd.158.1531782503502;
 Mon, 16 Jul 2018 16:08:23 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:08:19 -0700
In-Reply-To: <7a3e3815c585dd3972e9bea6798a7664232157a3.1531746012.git.gitgitgadget@gmail.com>
Message-Id: <20180716230819.259097-1-jonathantanmy@google.com>
References: <7a3e3815c585dd3972e9bea6798a7664232157a3.1531746012.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.18.0.13.g5a7731b13
Subject: Re: [PATCH 11/16] test-reach: test get_merge_bases_many
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -71,6 +78,14 @@ int cmd__reach(int ac, const char **av)
>  		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
>  	else if (!strcmp(av[1], "is_descendant_of"))
>  		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
> +	else if (!strcmp(av[1], "get_merge_bases_many")) {
> +		struct commit_list *list = get_merge_bases_many(A, X_nr, X_array);
> +		printf("%s(A,X):\n", av[1]);
> +		while (list) {
> +			printf("%s\n", oid_to_hex(&list->item->object.oid));
> +			list = list->next;
> +		}

I don't think get_merge_bases_many defines a sort order on its output?
It might be better to sort the resulting commit list here, so that the
output is more well-defined. (And omit the informational printf so that
it's slightly easier to generate the "expect" file.)
