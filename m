Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D18F201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdB1SFD (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:05:03 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58606 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751686AbdB1SFC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 13:05:02 -0500
X-AuditID: 12074411-4bfff700000005a9-23-58b5bb84cc5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.ED.01449.48BB5B85; Tue, 28 Feb 2017 13:03:49 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SI3j80017261
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 13:03:46 -0500
Subject: Re: [PATCH v5 12/24] refs.c: kill register_ref_store(), add
 register_submodule_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-13-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <92ff53b6-8a85-9be8-e14f-18eb1fcaf732@alum.mit.edu>
Date:   Tue, 28 Feb 2017 19:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-13-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqDtx99YIgymbtS26rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLWZetbbYvLmdxYHdY+esu+weHz7GeSzYVOrR1X6EzePiJWWP/Uu3
        sXl83iQXwB7FZZOSmpNZllqkb5fAlXH7+32mgrvSFecPvWVsYJwi1sXIySEhYCLxZP1Lli5G
        Lg4hgR1MErc27GOEcM4ySWx/2McOUiUskCpx5vVnJhBbRCBNYvHk98wQRRMYJc7uOQfmMAvc
        YJS4NPEjWBWbgK7Eop5mMJtXwF5i3SKQIk4OFgFViTvt99hAbFGBEIk5Cx8wQtQISpyc+YQF
        xOYUsJC4sGgNWD2zgLrEn3mXoGx5ieats5knMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbm
        FKcm6xYnJ+blpRbpmurlZpbopaaUbmKEBLzgDsYZJ+UOMQpwMCrx8GZ0bo0QYk0sK67MPcQo
        ycGkJMobNAMoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3RzFQjjclsbIqtSgfJiXNwaIkzsu3
        RN1PSCA9sSQ1OzW1ILUIJivDwaEkwSu6C6hRsCg1PbUiLTOnBCHNxMEJMpwHaHgQSA1vcUFi
        bnFmOkT+FKOilDhv1k6ghABIIqM0D64XlpBeMYoDvSLMWwvSzgNMZnDdr4AGMwENfqECNrgk
        ESEl1cBoa6P5kImlwPVwvsZSp7OK6lYhM8021PWpxkxqW2kRsIzHfcZppvTFFbcr5hq9v7vX
        7v3fqsV8hovMV0o8Wtl2PbKzO3sVq3Xsur5+pv75+x7dP/BmNkepr9/FiiVx9+akr0mw1Z7x
        1fz2sj1vZjRYrvPceMK/0Hr+ftPNVy1OnDzo1B111XC3EktxRqKhFnNRcSIA8fH3tCMDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> This is the last function in this code (besides public API) that takes
> submodule argument and handles both main/submodule cases. Break it down,
> move main store registration in get_main_ref_store() and keep the rest
> in register_submodule_ref_store().
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 50 ++++++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index c284cb4f4..6adc38e42 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1412,29 +1412,6 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
>  }
>  
>  /*
> - * Register the specified ref_store to be the one that should be used
> - * for submodule (or the main repository if submodule is NULL). It is
> - * a fatal error to call this function twice for the same submodule.
> - */
> -static void register_ref_store(struct ref_store *refs, const char *submodule)
> -{
> -	if (!submodule) {
> -		if (main_ref_store)
> -			die("BUG: main_ref_store initialized twice");
> -
> -		main_ref_store = refs;
> -	} else {
> -		if (!submodule_ref_stores.tablesize)
> -			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
> -
> -		if (hashmap_put(&submodule_ref_stores,
> -				alloc_submodule_hash_entry(submodule, refs)))
> -			die("BUG: ref_store for submodule '%s' initialized twice",
> -			    submodule);
> -	}
> -}
> -
> -/*
>   * Create, record, and return a ref_store instance for the specified
>   * submodule (or the main repository if submodule is NULL).
>   */
> @@ -1448,7 +1425,6 @@ static struct ref_store *ref_store_init(const char *submodule)
>  		die("BUG: reference backend %s is unknown", be_name);
>  
>  	refs = be->init(submodule);
> -	register_ref_store(refs, submodule);
>  	return refs;
>  }
>  
> @@ -1460,9 +1436,32 @@ static struct ref_store *get_main_ref_store(void)
>  		return main_ref_store;
>  
>  	refs = ref_store_init(NULL);
> +	if (refs) {
> +		if (main_ref_store)
> +			die("BUG: main_ref_store initialized twice");
> +
> +		main_ref_store = refs;
> +	}
>  	return refs;

Superfluous test: I don't think `ref_store_init()` ever returns NULL.
This also implies that you could check `main_ref_store` before calling
`ref_store_init()`, and eliminate a temporary.

>  }
>  
> +/*
> + * Register the specified ref_store to be the one that should be used
> + * for submodule. It is a fatal error to call this function twice for
> + * the same submodule.
> + */
> +static void register_submodule_ref_store(struct ref_store *refs,
> +					 const char *submodule)
> +{
> +	if (!submodule_ref_stores.tablesize)
> +		hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
> +
> +	if (hashmap_put(&submodule_ref_stores,
> +			alloc_submodule_hash_entry(submodule, refs)))
> +		die("BUG: ref_store for submodule '%s' initialized twice",
> +		    submodule);
> +}
> +
>  struct ref_store *get_ref_store(const char *submodule)
>  {
>  	struct strbuf submodule_sb = STRBUF_INIT;
> @@ -1480,6 +1479,9 @@ struct ref_store *get_ref_store(const char *submodule)
>  	if (is_nonbare_repository_dir(&submodule_sb))
>  		refs = ref_store_init(submodule);
>  	strbuf_release(&submodule_sb);
> +
> +	if (refs)

I think `refs` should always be non-NULL here for the same reason.

> +		register_submodule_ref_store(refs, submodule);
>  	return refs;
>  }

Michael

