Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9D72095D
	for <e@80x24.org>; Mon, 20 Mar 2017 07:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbdCTHB7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 03:01:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45900 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752770AbdCTHB5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 03:01:57 -0400
X-AuditID: 1207440d-029ff70000003721-d3-58cf7dd4d07f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.A9.14113.4DD7FC85; Mon, 20 Mar 2017 02:59:33 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2K6xUN3014878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 02:59:31 -0400
Subject: Re: [PATCH v3 2/4] refs: introduce get_worktree_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170216120302.5302-1-pclouds@gmail.com>
 <20170318100206.5980-1-pclouds@gmail.com>
 <20170318100206.5980-3-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b841a674-7b2b-420d-7faa-e5b836fb534e@alum.mit.edu>
Date:   Mon, 20 Mar 2017 07:59:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318100206.5980-3-pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqHu19nyEwZ71LBZdV7qZLBp6rzBb
        dE95y2ixeXM7iwOLx85Zd9k9Fmwq9bh4Sdnj8ya5AJYoLpuU1JzMstQifbsErozVkzuYCw6L
        Vsxe+52pgXGKYBcjJ4eEgInEsdNtzF2MXBxCAjuYJPrXTGSBcC4wSbTd+8sEUiUs4CKxb8N1
        FhBbRCBNYvHk98wgtpBAL6PE4y98XYwcHMwCXhLzPpaDhNkEdCUW9TSDtfIK2EvMmTybFcRm
        EVCV+LDhFNgYUYEQiTkLHzBC1AhKnJz5BCzOKWAmsXH+MRaIkeoS6+cJgYSZBeQlmrfOZp7A
        yD8LSccshKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJV94d
        jP/XyRxiFOBgVOLhvXHpXIQQa2JZcWXuIUZJDiYlUV5Nn/MRQnxJ+SmVGYnFGfFFpTmpxYcY
        JTiYlUR4dyQA5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxWNUCN
        gkWp6akVaZk5JQhpJg5OkOE8QMP7QGp4iwsSc4sz0yHypxgVpcR5L4IkBEASGaV5cL2wdPKK
        URzoFWHe2SBVPMBUBNf9CmgwE9DgZTfOgAwuSURISTUwmluIHVzw2qtT5arm5j+KRi22Btaz
        CxXWC9uX+VSf1f8s3Nu2YMmnrj+8EpmPgxdpTO6puCGXs14z+6Gy2l3OraxO+0xWXt8rtHUe
        679+ha3nK2tOf/iQohDz3S3vbfh+LbEap95J/38dtD+8Tvpzs7vdon26iwOdtu/ONzr6eF/n
        oxYvt3OxSizFGYmGWsxFxYkA5qWTcwIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 11:02 AM, Nguyễn Thái Ngọc Duy wrote:
> files-backend at this point is still aware of the per-repo/worktree
> separation in refs, so it can handle a linked worktree.
> 
> Some refs operations are known not working when current files-backend is
> used in a linked worktree (e.g. reflog). Tests will be written when
> refs_* functions start to be called with worktree backend to verify that
> they work as expected.
> 
> Note: accessing a worktree of a submodule remains unaddressed. Perhaps
> after get_worktrees() can access submodule (or rather a new function
> get_submodule_worktrees(), that lists worktrees of a submodule), we can
> update this function to work with submodules as well.
> ---
>  refs.c | 32 ++++++++++++++++++++++++++++++++
>  refs.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 77a39f8b17..6695140cfe 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -10,6 +10,7 @@
>  #include "object.h"
>  #include "tag.h"
>  #include "submodule.h"
> +#include "worktree.h"
>  
>  /*
>   * List of all available backends
> @@ -1593,6 +1594,37 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  	return refs;
>  }
>  
> +struct ref_store *get_worktree_ref_store(const struct worktree *wt)
> +{
> +	struct ref_store *refs;
> +	unsigned int refs_all_capabilities =
> +		REF_STORE_READ | REF_STORE_WRITE |
> +		REF_STORE_ODB | REF_STORE_MAIN;
> +
> +	if (wt->is_current)
> +		return get_main_ref_store();
> +
> +	/*
> +	 * We share the same hash map with submodules for
> +	 * now. submodule paths are always relative (to topdir) while
> +	 * worktree paths are always absolute. No chance of conflict.
> +	 */
> +	refs = lookup_submodule_ref_store(wt->path);
> +	if (refs)
> +		return refs;
> +
> +	if (wt->id)
> +		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
> +				      refs_all_capabilities);
> +	else
> +		refs = ref_store_init(get_git_common_dir(),
> +				      refs_all_capabilities);
> +
> +	if (refs)
> +		register_submodule_ref_store(refs, wt->path);
> +	return refs;
> +}
> +

I guess I can hold my nose and accept storing worktree and submodule
`ref_store`s together in a single hashmap, but not if the code continues
to use "submodule" in the names, because that will be a continuing
source of confusion to readers. For example,

* lookup_submodule_ref_store()
* register_submodule_ref_store()
* submodule_hash_entry
* submodule_hash_cmp()
* alloc_submodule_hash_entry()
* submodule_ref_stores

Any docstrings would also have to be updated.

As a new naming scheme, maybe use s/submodule/other/, for example
`lookup_other_ref_store()` etc.

> [...]

Michael

