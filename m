Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C12A1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeKFLbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:31:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKFLbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:31:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so8038734wrv.4
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qOKusqwG1mrvCx2JUTq6IB38ZZ9hjtTTMr2z69m6xL8=;
        b=RAXybQXW2djLNAIHDKRBl84OPPOS/Ti/xJXID8711XsVnPFoDokornxb58X0CgzrsU
         pgNYgeZUJuzqvhtO9U/qrIAramp0Uxs+yjnxc9h0p4xkFpcPYjyktUQZcM116Pi8rxkw
         vrTNy7i4cjtYFfJ8O8JSCJ3da33KPwE+KALDCZZCoaFEFukFs8ZvVcTwxtU6Ykm91jK0
         SD2dJBBHqroD/Wjd1ecvSfDQ0ZoSm06caeEUcE62LPIU/GJnuGeERspXpr+/8JBru9i0
         lsttqOXIE7n/d4S3/jZdwolnMSn/40oyASMtfAaUh85gmQ9ygArSnCFriaBGgE4Wq+d1
         impw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qOKusqwG1mrvCx2JUTq6IB38ZZ9hjtTTMr2z69m6xL8=;
        b=Rm2W89uYMaZ16gyVRc1g0eMDCIsW6wEiMUCW6uN9K9JgpBQPa///IGm4uT9WCqNEQ/
         vXZ3/RdYCdXZwPiTCyb47c19i+qGrabCdVU6dJp7PeyxtSCS7oR+jULkw9rwIe+1umf/
         vvcGndX4XhFH40KOlv8ugsI9h1+UkPQmddspk6bJXUcnZYt5yVk40mH1Di93Hv9o85uH
         6Q38u/2E4lz74niupEW5FWbG40SV8c2YeIspk7oeB9GOGdd0Ekbx6CcR+73F75ky7Qwy
         u6mDW5eGGVD6vsuS0JqTbTdr5b7xf1ko3kw2FKxvoCQr+MTcwfcRwkFn3wUjGuNV8c98
         /OMw==
X-Gm-Message-State: AGRZ1gIbkw0BYvRtgDgJeUhw6g/2SOlhmFjeZiHF3pLJM4LjPQL9hUkN
        qCcjrmiTlJvA97bMP075ZKAEwpyUleM=
X-Google-Smtp-Source: AJdET5edJm9nnoy1Xw+UUYSxq4iX5qzzo5GLB1iuhxa8QfX4pWYGik3wu42PCoosvi2UyhiWx2FB3Q==
X-Received: by 2002:adf:8b0a:: with SMTP id n10-v6mr20054225wra.282.1541470144977;
        Mon, 05 Nov 2018 18:09:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 143-v6sm1147441wmn.10.2018.11.05.18.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:09:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 03/16] archive.c: mark more strings for translation
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-4-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 11:09:03 +0900
In-Reply-To: <20181105192059.20303-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:46 +0100")
Message-ID: <xmqqbm73gdog.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Two messages also print extra information to be more useful
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  archive.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 9d16b7fadf..d8f6e1ce30 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -385,12 +385,12 @@ static void parse_treeish_arg(const char **argv,
>  		int refnamelen = colon - name;
>  
>  		if (!dwim_ref(name, refnamelen, &oid, &ref))
> -			die("no such ref: %.*s", refnamelen, name);
> +			die(_("no such ref: %.*s"), refnamelen, name);
>  		free(ref);
>  	}
>  
>  	if (get_oid(name, &oid))
> -		die("Not a valid object name");
> +		die(_("not a valid object name: %s"), name);

Much better than the previous one that gave the name upfront.

>  
>  	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
>  	if (commit) {
> @@ -403,7 +403,7 @@ static void parse_treeish_arg(const char **argv,
>  
>  	tree = parse_tree_indirect(&oid);
>  	if (tree == NULL)
> -		die("not a tree object");
> +		die(_("not a tree object: %s"), oid_to_hex(&oid));

Likewise; as oid_to_hex() would be quite long compared to the rest
of the message, this is a vast improvement from the previous round.

>  	if (prefix) {
>  		struct object_id tree_oid;
> @@ -413,7 +413,7 @@ static void parse_treeish_arg(const char **argv,
>  		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
>  				     &mode);
>  		if (err || !S_ISDIR(mode))
> -			die("current working directory is untracked");
> +			die(_("current working directory is untracked"));
>  
>  		tree = parse_tree_indirect(&tree_oid);
>  	}
