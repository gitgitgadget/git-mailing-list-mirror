Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1DD207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 04:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1038267AbdDVEwl (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 00:52:41 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59519 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034482AbdDVEwk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 00:52:40 -0400
X-AuditID: 1207440f-719ff700000004e5-00-58fae1952bed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C0.75.01253.591EAF85; Sat, 22 Apr 2017 00:52:38 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M4qYWA028894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 00:52:36 -0400
Subject: Re: [PATCH v4 3/5] refs: introduce get_worktree_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
 <20170404102123.25315-4-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <75cc95f4-d3e9-d483-ce9a-74cc1a356477@alum.mit.edu>
Date:   Sat, 22 Apr 2017 06:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170404102123.25315-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqDvt4a8Ig6vP+C26rnQzWTT0XmG2
        6J7yltFi8+Z2FgcWj52z7rJ7LNhU6nHxkrLH501yASxRXDYpqTmZZalF+nYJXBlH3k9jKpgk
        VPH9VANjA+NBvi5GTg4JAROJdU/2M3YxcnEICexgkrh26yEzhHOBSeLVqdPsIFXCAi4Sh9dv
        ZgaxRQTSJBZPfg9V1M8osf5/J5DDwcEs4CUx72M5SA2bgK7Eop5mJhCbV8Be4sf2C4wgJSwC
        qhLbVweChEUFQiTmLHzACFEiKHFy5hMWEJtTwFzi+axrYHFmAXWJP/MuMUPY8hLNW2czT2Dk
        n4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAlZ/h2M
        XetlDjEKcDAq8fCuYPkVIcSaWFZcmXuIUZKDSUmUN+T3zwghvqT8lMqMxOKM+KLSnNTiQ4wS
        HMxKIrxVd4HKeVMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvHEPgBoF
        i1LTUyvSMnNKENJMHJwgw3mAhiuD1PAWFyTmFmemQ+RPMSpKifOeuA+UEABJZJTmwfXCUsor
        RnGgV4R5z4C08wDTEVz3K6DBTECDz/r9ABlckoiQkmpg5GX5f4YnwyRPuOyrPZOnhSHn5Y+/
        PRccefx3j+lvseDgxmLtL0eXRLSsrdohOOXPnONTFtxYVZ8zzWThL+MfXumaF54e0p3zvEig
        JOXrTu5djVeM7B+HWu69llarxBbevr6PP2ZOS3DiYYml+zQuHb3DcXb6R+XwM//cZa3js28r
        vGoyflfCosRSnJFoqMVcVJwIANgpwZEEAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/04/2017 12:21 PM, Nguyễn Thái Ngọc Duy wrote:
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
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 31 +++++++++++++++++++++++++++++++
>  refs.h |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 875e30a0b8..a4083caf6a 100644
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
> @@ -1486,6 +1487,9 @@ static struct ref_store *main_ref_store;
>  /* A hashmap of ref_stores, stored by submodule name: */
>  static struct hashmap submodule_ref_stores;
>  
> +/* A hashmap of ref_stores, stored by worktree id: */
> +static struct hashmap worktree_ref_stores;
> +
>  /*
>   * Look up a ref store by name. If that ref_store hasn't been
>   * registered yet, return NULL.
> @@ -1590,6 +1594,33 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  	return refs;
>  }
>  
> +struct ref_store *get_worktree_ref_store(const struct worktree *wt)
> +{
> +	struct ref_store *refs;
> +	unsigned int refs_all_capabilities =
> +		REF_STORE_READ | REF_STORE_WRITE |
> +		REF_STORE_ODB | REF_STORE_MAIN;

This constant appears another place, too. It might make sense to define
a constant `REF_STORE_ALL_CAPABILITIES` in `refs-internal.h` alongside
the individual bit values.

If you prefer not to, please at least declare this variable `const` to
spare the reader the trouble of looking to see whether it is modified
before it is used.

Otherwise, looks fine to me.

> [...]

Michael

