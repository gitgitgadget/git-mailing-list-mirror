Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D039207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041882AbdDVFsw (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:48:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59828 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932681AbdDVFsu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 01:48:50 -0400
X-AuditID: 1207440f-701ff700000004e5-dd-58faeebfb603
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.C5.01253.FBEEAF85; Sat, 22 Apr 2017 01:48:49 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M5mhlf031347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 01:48:44 -0400
Subject: Re: [PATCH v3 09/12] revision.c: --all adds HEAD from all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-10-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b0bd826e-8394-08f7-131e-8dfa44d0f647@alum.mit.edu>
Date:   Sat, 22 Apr 2017 07:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-10-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1D347leEwa5GGYuuK91MFg29V5gt
        +pd3sVl0T3nLaDHzqrXF5s3tLA5sHjtn3WX3+PAxzmPBplKPi5eUPfYv3cbm8XmTXABbFJdN
        SmpOZllqkb5dAlfGnq97WAr2K1ccPD6VqYHxh3QXIyeHhICJxKxFC1m7GLk4hAR2MEmsPrGD
        EcK5wCRxZ+sS9i5GDg5hAR+Jn+u0QRpEBNIkFk9+zwxiCwkkSWx62s0GUs8ssItR4szzO2AJ
        NgFdiUU9zUwgNq+AvcSMmW1sIDaLgKrEqrOHWUFsUYEQiTkLHzBC1AhKnJz5hAXE5hQwl+hZ
        vBosziygLvFn3iVmCFteonnrbOYJjPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJ
        iXl5qUW6Jnq5mSV6qSmlmxghgc0P9PJ6mUOMAhyMSjy8K1h+RQixJpYVV+YeYpTkYFIS5Q35
        /TNCiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv+tdA5bwpiZVVqUX5MClpDhYlcV71Jep+QgLp
        iSWp2ampBalFMFkZDg4lCd5gYAQLCRalpqdWpGXmlCCkmTg4QYbzAA2//RZkeHFBYm5xZjpE
        /hSjopQ4bxFIQgAkkVGaB9cLSzyvGMWBXhHmXQRSxQNMWnDdr4AGMwENPuv3A2RwSSJCSqqB
        sa3uu2+k+8GUGA7/+AvhSWot78I53N5fYHug0VtvOP3OVo5/xjulV31centqeUz7Lbdv90zm
        KHWdjV11/m5V87/fkXeO68X/OBzxMCdnAq/O2lSrrfv8KlP8WGQV9/YXN8qf1+BhzGY94N/G
        8shw+7pjtqE/Vhk0tz7icYtqnZxgv/PblJdJSizFGYmGWsxFxYkAf8++BhcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> Unless single_worktree is set, --all now adds HEAD from all worktrees.
> 
> Since reachable.c code does not use setup_revisions(), we need to call
> other_head_refs_submodule() explicitly there to have the same effect on
> "git prune", so that we won't accidentally delete objects needed by some
> other HEADs.
> 
> A new FIXME is added because we would need something like
> 
>     int refs_other_head_refs(struct ref_store *, each_ref_fn, cb_data);
> 
> in addition to other_head_refs() to handle it, which might require
> 
>     int get_submodule_worktrees(const char *submodule, int flags);
> 
> It could be a separate topic to reduce the scope of this one.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  reachable.c      |  1 +
>  refs.c           | 22 ++++++++++++++++++++++
>  refs.h           |  1 +
>  revision.c       | 13 +++++++++++++
>  submodule.c      |  2 ++
>  t/t5304-prune.sh | 12 ++++++++++++
>  6 files changed, 51 insertions(+)
> 
> diff --git a/reachable.c b/reachable.c
> index a8a979bd4f..a3b938b46c 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -177,6 +177,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
>  
>  	/* detached HEAD is not included in the list above */
>  	head_ref(add_one_ref, revs);
> +	other_head_refs(add_one_ref, revs);
>  
>  	/* Add all reflog info */
>  	if (mark_reflog)
> diff --git a/refs.c b/refs.c
> index 537052f7ba..23e3607674 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1780,3 +1780,25 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
>  {
>  	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
>  }
> +
> +int other_head_refs(each_ref_fn fn, void *cb_data)
> +{
> +	struct worktree **worktrees, **p;
> +	int ret = 0;
> +
> +	worktrees = get_worktrees(0);
> +	for (p = worktrees; *p; p++) {
> +		struct worktree *wt = *p;
> +		struct ref_store *refs;
> +
> +		if (wt->is_current)
> +			continue;
> +
> +		refs = get_worktree_ref_store(wt);
> +		ret = refs_head_ref(refs, fn, cb_data);
> +		if (ret)
> +			break;
> +	}
> +	free_worktrees(worktrees);
> +	return ret;
> +}

This function is mainly about iterating through all worktrees. Therefore
it feels out of place in the refs module. But I don't have a strong
feeling about it.

> diff --git a/refs.h b/refs.h
> index e06db37118..cc71b6c7a0 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -247,6 +247,7 @@ int refs_for_each_remote_ref(struct ref_store *refs,
>  			     each_ref_fn fn, void *cb_data);
>  
>  int head_ref(each_ref_fn fn, void *cb_data);
> +int other_head_refs(each_ref_fn fn, void *cb_data);
>  int for_each_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
>  int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
> diff --git a/revision.c b/revision.c
> index c329070c89..040a0064f6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2105,6 +2105,13 @@ static int handle_revision_pseudo_opt(const char *submodule,
>  	int argcount;
>  
>  	if (submodule) {
> +		/*
> +		 * We need some something like get_submodule_worktrees()
> +		 * before we can go through all worktrees of a submodule,
> +		 * .e.g with adding all HEADs from --all, which is not
> +		 * supported right now, so stick to single worktree.
> +		 */
> +		assert(revs->single_worktree != 0);

You don't need `!= 0` above.

We usually don't use `assert(foo)` but rather `if (!foo)
die("BUG:...")`, which gives a better error message and isn't switched
off if a distribution compiles with NDEBUG.

But here I'm confused about whether this check failing really indicates
a bug within git, or whether it could indicate a situation that the user
has set up that git just can't handle right now. For example, maybe the
user will set up a submodule that itself uses worktrees (even if that's
not possible now, maybe they will have done it with some future version
of git or with another tool). If the problem is only that this version
of git is too stupid to handle pruning safely in that situation, it
would be more appropriate to use something more like

	if (!refs->single_worktree)
		die("error: git is currently unable to handle submodules that use
linked worktrees");

>  		refs = get_submodule_ref_store(submodule);
>  	} else
>  		refs = get_main_ref_store();
> [...]

Michael

