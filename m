Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09AD20282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFTSW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:22:29 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33809 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFTSW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:22:28 -0400
Received: by mail-pf0-f181.google.com with SMTP id s66so73001146pfs.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gMNrlwuLbwWEjNmyxVH0vyNfsjE0JjqxS+oV0BtTKFM=;
        b=LfAxdEsUZ2a2hVuLH56ljlI764oeqi/oLDDQk06CP4+bwnwk10MEwOnHiwUhCZp7Jq
         c2cb76f40skD9RmT1OTxpRjoix2Dn1yjSQIHOf34P9xSkqHLkufcPOi4xr1BNi1GiiV1
         dzVCKIsCgRyRFWPoewvnEhWui+aaAUZB3NAcio0hggE+2Xh56SM5fm2Ae1y/9N1jkTZ+
         2z/7jDkkvb922oEqAtHTG48bupiA06EmA2r5td02YkNUmCogyRRPqXoNHwNu5LCAh/7/
         VWHR56OTxTUiU1bAX2iVm7M4zW9atnTRUNYVvH0ZGTaAUEwVzRSOfDzo37owWKWXH3jb
         Ih8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMNrlwuLbwWEjNmyxVH0vyNfsjE0JjqxS+oV0BtTKFM=;
        b=lvrtoH1pPj85sq4keDknmIxHRFUrS6bnSze/SV7rQmjqvl/hvwHMd700kx9BhZdiP8
         IjmPACkHejYC64RWVpbScpwzDuLEEXGwUbpDmJL4YAhqSV3C1yluIXhVeoeGegK+YGfp
         eliFGG2QSEl973BxHT82KlG90Fy8ZudDaJd7LRCTz6exB7TzVTwZLiFb/nwURx+DhgyT
         PZldUYxjyqwN9JL4D+FpvpIpV5BcvweH1MygFJ6lGjlKvOvA5PznrEsoZZlrOv/XErR+
         JDmrMALynEiEM6vsr32DW3u8QHrs1QQHq2SxUwrUZo8E/epFmLYC0V0I+FaNmY396I84
         mHBg==
X-Gm-Message-State: AKS2vOzHO/6thtVFaE7uFCwSAUnYY9ag6qVW9BnEJ3aVIPgDuq1m2tKD
        Y+yp6HjxxvE0xxQ1
X-Received: by 10.98.15.67 with SMTP id x64mr3748536pfi.216.1497982947172;
        Tue, 20 Jun 2017 11:22:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:292c:ffc6:f991:bee9])
        by smtp.gmail.com with ESMTPSA id k9sm33367495pga.40.2017.06.20.11.22.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 11:22:26 -0700 (PDT)
Date:   Tue, 20 Jun 2017 11:22:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 2/6] submodule--helper: introduce
 get_submodule_displaypath and for_each_submodule_list
Message-ID: <20170620182225.GA60134@google.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
 <20170619215025.10086-2-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170619215025.10086-2-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Prathamesh Chavan wrote:
> Functions get_submodule_displaypath and for_each_submodule_list
> for using them in the later patches, related to porting submodule
> subcommands from shell to C.
> These new functions are also used in ported submodule subcommand
> init

I didn't see anything wrong with these patches, but one small nit is
that this one patch is changing two different things, adding
'get_submodule_displaypath' and 'for_each_submodule_list'.  Logically
you could break this patch into two different parts, first introducing
one and then the other.

I'm not saying you need to re-do this patch though (I don't have a super
strong opinion though others might) just wanted to point it out for the
future.

> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 69 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 8cc648d85..f7adca95b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,9 @@
>  #include "refs.h"
>  #include "connect.h"
>  
> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
> +				      void *cb_data);
> +
>  static char *get_default_remote(void)
>  {
>  	char *dest = NULL, *ret;
> @@ -219,6 +222,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +	const char *super_prefix = get_super_prefix();
> +
> +	if (prefix && super_prefix) {
> +		BUG("cannot have prefix '%s' and superprefix '%s'",
> +		    prefix, super_prefix);
> +	} else if (prefix) {
> +		struct strbuf sb = STRBUF_INIT;
> +		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +		strbuf_release(&sb);
> +		return displaypath;
> +	} else if (super_prefix) {
> +		int len = strlen(super_prefix);
> +		const char *format = is_dir_sep(super_prefix[len-1]) ? "%s%s" : "%s/%s";
> +		return xstrfmt(format, super_prefix, path);
> +	} else {
> +		return xstrdup(path);
> +	}
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -330,26 +354,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static void init_submodule(const char *path, const char *prefix, int quiet)
> +static void for_each_submodule_list(const struct module_list list,
> +				    submodule_list_func_t fn, void *cb_data)
>  {
> +	int i;
> +	for (i = 0; i < list.nr; i++)
> +		fn(list.entries[i], cb_data);
> +}
> +
> +struct init_cb {
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +};
> +#define INIT_CB_INIT { NULL, 0 }
> +
> +static void init_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +	struct init_cb *info = cb_data;
>  	const struct submodule *sub;
>  	struct strbuf sb = STRBUF_INIT;
>  	char *upd = NULL, *url = NULL, *displaypath;
>  
> -	/* Only loads from .gitmodules, no overlay with .git/config */
> -	gitmodules_config();
> -
> -	if (prefix && get_super_prefix())
> -		die("BUG: cannot have prefix and superprefix");
> -	else if (prefix)
> -		displaypath = xstrdup(relative_path(path, prefix, &sb));
> -	else if (get_super_prefix()) {
> -		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
> -		displaypath = strbuf_detach(&sb, NULL);
> -	} else
> -		displaypath = xstrdup(path);
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
>  
> -	sub = submodule_from_path(null_sha1, path);
> +	sub = submodule_from_path(null_sha1, list_item->name);
>  
>  	if (!sub)
>  		die(_("No url found for submodule path '%s' in .gitmodules"),
> @@ -361,7 +389,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	 *
>  	 * Set active flag for the submodule being initialized
>  	 */
> -	if (!is_submodule_initialized(path)) {
> +	if (!is_submodule_initialized(list_item->name)) {
>  		strbuf_reset(&sb);
>  		strbuf_addf(&sb, "submodule.%s.active", sub->name);
>  		git_config_set_gently(sb.buf, "true");
> @@ -404,7 +432,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  		if (git_config_set_gently(sb.buf, url))
>  			die(_("Failed to register url for submodule path '%s'"),
>  			    displaypath);
> -		if (!quiet)
> +		if (!info->quiet)
>  			fprintf(stderr,
>  				_("Submodule '%s' (%s) registered for path '%s'\n"),
>  				sub->name, url, displaypath);
> @@ -433,10 +461,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  
>  static int module_init(int argc, const char **argv, const char *prefix)
>  {
> +	struct init_cb info = INIT_CB_INIT;
>  	struct pathspec pathspec;
>  	struct module_list list = MODULE_LIST_INIT;
>  	int quiet = 0;
> -	int i;
>  
>  	struct option module_init_options[] = {
>  		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
> @@ -461,8 +489,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  	if (!argc && git_config_get_value_multi("submodule.active"))
>  		module_list_active(&list);
>  
> -	for (i = 0; i < list.nr; i++)
> -		init_submodule(list.entries[i]->name, prefix, quiet);
> +	info.prefix = prefix;
> +	info.quiet = !!quiet;
> +
> +	gitmodules_config();
> +	for_each_submodule_list(list, init_submodule, &info);
>  
>  	return 0;
>  }
> -- 
> 2.13.0
> 

-- 
Brandon Williams
