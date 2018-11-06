Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3A31F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeKFLeu (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:34:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39171 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeKFLeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:34:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so11679106wrv.6
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rbQDOOkrkkLDm40Jmo6lmzvQHnStvn2qx9dY/sZ6zsk=;
        b=AUYlUjctc11xoUzw730zbImXlRWY8V/d3w85e1Pqtvj4PRvdC98U4H4Yd7hWeT2t+d
         TsDwPkRJuRvtsGX7ggwjNb7ZkDTaIkNAxtcpqgUryoSE7ZmPHKxU9ZPGYAZDm8Twr0Cy
         srU595Jtyrtt04STc9xQnRy9OUTccmgA914ycbfW49MEwodBnaEKiT9ccxO3ma3aJxSz
         a9pC6KHCmLmdBIOzKy9nqrzPEckn70BJMuJptKWEaKehUg5XPaKZN7C4J1pBi+aJM7q/
         3SgCSNNF+AQ69YPNDEInka1Jaxa65WdBm3XtZav9q2jbnSxO4N7cpckDydhkHxIlZCop
         vJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rbQDOOkrkkLDm40Jmo6lmzvQHnStvn2qx9dY/sZ6zsk=;
        b=nZqrCESpbI46DCl6vkQxhfHCNHvaJ8D1qlaJk3nacm9OqLzfVPXv8zGU5p5NScPC2d
         NuOg7aoNXDK3dnF6wdihlkaOz4sWTyELsgfPu3o36A6sYQC3J07xgK4nKPkvBvN8bpnv
         cz5rsoYPfHnLXOLxZqxvNcq56a1Tr94WQBEdpebpeyknJKKHwhaS51j83evzgPHseudH
         PqXSh9erobseDngqM3+jg3Sorljvpopp8AteS0OtspcOjnFM72ALHMcoZDKsNl/c0+7/
         xzQ8qwN/ypyu5kqZ4o7J1VfzPJm5eIB+5kZwNDZhFTFhIy7KCiCOkAwv7XMNNqc/cZ6/
         KyFA==
X-Gm-Message-State: AGRZ1gJN83BEMnJalMGZ+8brVGfcTs2I0nWG5eTAHMXVVwp2F+AI3sUQ
        UTRh431vufGpM0Msy3MCABv+/mRHE+U=
X-Google-Smtp-Source: AJdET5cnusgQ6BgRMbRGfVges+lcCpS5SzHOy3dm/TQEGtmBWWZOhu+48qbSmEzPYyBLgzVXIOmzxw==
X-Received: by 2002:a5d:6050:: with SMTP id j16-v6mr21338639wrt.301.1541470322326;
        Mon, 05 Nov 2018 18:12:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n67-v6sm411071wmd.41.2018.11.05.18.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:12:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 07/16] read-cache.c: add missing colon separators
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-8-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 11:12:00 +0900
In-Reply-To: <20181105192059.20303-8-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:50 +0100")
Message-ID: <xmqq36sfgdjj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> typechange_fmt and added_fmt should have a colon before "needs
> update". Align the statements to make it easier to read and see. Also
> drop the unnecessary ().
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  read-cache.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Sensible.  Thanks.

> diff --git a/read-cache.c b/read-cache.c
> index 858befe738..8d99ae376c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1492,11 +1492,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  						  istate->cache_nr);
>  
>  	trace_performance_enter();
> -	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
> -	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
> -	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
> -	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
> -	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
> +	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
> +	deleted_fmt    = in_porcelain ? "D\t%s\n" : "%s: needs update\n";
> +	typechange_fmt = in_porcelain ? "T\t%s\n" : "%s: needs update\n";
> +	added_fmt      = in_porcelain ? "A\t%s\n" : "%s: needs update\n";
> +	unmerged_fmt   = in_porcelain ? "U\t%s\n" : "%s: needs merge\n";
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce, *new_entry;
>  		int cache_errno = 0;
