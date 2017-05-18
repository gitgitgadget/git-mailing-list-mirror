Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E48201CF
	for <e@80x24.org>; Thu, 18 May 2017 15:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbdERPjF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 11:39:05 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33569 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbdERPjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 11:39:04 -0400
Received: by mail-pg0-f49.google.com with SMTP id u187so24580674pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tD/Q623fIpihqEScCOvgkdn98jKUJQ0KPPAfztv5Of0=;
        b=Nhjwrryu9oTeG7icvc6aYfaIehEF/rLIoD+hFLLzGMs5Alm8vcv1Qt7narBHnXiRho
         za6A3BbWCp+KhCE0HevWlxCiViDRaKl4vo3WZvE+0cjzp9fNumZW1T8QWk0TCXkf/D8r
         t6vws8toGXP1hnbxKRjd2XwoBTLKwLm8VjN4ErPajOgcinY5D2Hfofq+btiuZmQU87z1
         hnbCNZFf6O1sscT6KFfHXfHhHf/i6aCl9h8+k5WfUcs5lT5fjM9CqV66+ghuU20yHwcF
         Ip39GF0pceLD+vjQyM9ak1PvhPGHqMnXnIZdNZoIZ4Yr2q0BAsnIXOfd+ElL9DN1rA/b
         17rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tD/Q623fIpihqEScCOvgkdn98jKUJQ0KPPAfztv5Of0=;
        b=BqoUAQBnO23YjDAbnSHFkPM2IaIrCkJQftEqP1qeYbXNCABH5UKS6v6aVnJncG3E10
         fFQvL2g1hhWamhk5m8P2AA51ccyWm7KVfMgmezWsLZPg2tnKyjsQLvE+c7KhauGfnv3S
         4pO+5ezRiaAoD2TLWOY8DrpXVerwHyOhxNaVwkQQPKMUfO64iO88SIqaS/WlYDNDcG3U
         8o5QoGFGSoD5EfsvhNcmOBM/ax1sA/2gI8BaYWDrrS0rvqf/qPBV0kGJlu+jmhFjY2jA
         8lSMijmTGmiu9MfW1d8fo9AC1B14EKnRxvKaBHmpxIKo4hs9fIl4YiMcGClu+XcYxHS7
         p7Cw==
X-Gm-Message-State: AODbwcCUGNlIiGwo+bG5+XZ5mF4jFwcMQoc/miaibXIyUA1Ws137UCO1
        cfxIq8Ynn6RyPVS+
X-Received: by 10.84.225.130 with SMTP id u2mr5554077plj.91.1495121943176;
        Thu, 18 May 2017 08:39:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id h21sm9057889pgn.18.2017.05.18.08.39.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 08:39:02 -0700 (PDT)
Date:   Thu, 18 May 2017 08:39:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] Introduce submodule.recurse option
Message-ID: <20170518153901.GB112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com>
 <20170517213135.20988-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517213135.20988-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Stefan Beller wrote:
> Any command that understands the boolean --recurse-submodule=[true/false]
> can have its default changed to true, by setting the submodule.recurse
> option.
> 
> git-push takes a --recurse-submodule argument but it is not boolean,
> hence it is not included (yet?).

ls-files and grep could also be added.  They don't need to be added in
this patch though.

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt    |  5 +++++
>  builtin/checkout.c          |  8 +++-----
>  submodule.c                 |  7 ++++++-
>  t/lib-submodule-update.sh   | 12 ++++++++++++
>  t/t5526-fetch-submodules.sh | 10 ++++++++++
>  5 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..e367becf72 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3063,6 +3063,11 @@ submodule.active::
>  	submodule's path to determine if the submodule is of interest to git
>  	commands.
>  
> +submodule.recurse::
> +	Specifies if commands recurse into submodules by default. This
> +	applies to all commands that have a `--recurse-submodules` option.
> +	Defaults to false.
> +
>  submodule.fetchJobs::
>  	Specifies how many submodules are fetched/cloned at the same time.
>  	A positive integer allows up to that number of submodules fetched
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2787b343b1..e4bd93c9cd 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1195,6 +1195,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	opts.show_progress = -1;
>  
>  	gitmodules_config();
> +	load_submodule_config();
>  	git_config(git_checkout_config, &opts);
>  
>  	opts.track = BRANCH_TRACK_UNSPECIFIED;
> @@ -1214,11 +1215,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
>  	}
>  
> -	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
> -		load_submodule_config();
> -		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> -			set_config_update_recurse_submodules(recurse_submodules);
> -	}
> +	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> +		set_config_update_recurse_submodules(recurse_submodules);
>  
>  	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
>  		die(_("-b, -B and --orphan are mutually exclusive"));
> diff --git a/submodule.c b/submodule.c
> index 14ea405048..000060a253 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -91,7 +91,12 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
>  
>  static int submodule_config(const char *var, const char *value, void *cb)
>  {
> -	if (!strcmp(var, "submodule.fetchjobs")) {
> +	if (!strcmp(var, "submodule.recurse")) {
> +		int v = git_config_bool(var, value) ?
> +			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
> +		config_fetch_recurse_submodules = v;
> +		config_update_recurse_submodules = v;
> +	} else if (!strcmp(var, "submodule.fetchjobs")) {
>  		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
>  		parallel_jobs = git_config_int(var, value);
>  		if (parallel_jobs < 0)
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 0f70b5ec7b..b30164339e 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -990,6 +990,18 @@ test_submodule_switch_recursing () {
>  		)
>  	'
>  
> +	test_expect_success "git -c submodule.recurse=true $cmd_args --recurse-submodules: modified submodule updates submodule work tree" '
> +		prolog &&
> +		reset_work_tree_to_interested add_sub1 &&
> +		(
> +			cd submodule_update &&
> +			git branch -t modify_sub1 origin/modify_sub1 &&
> +			git -c submodule.recurse=true $cmd_args --recurse-submodules modify_sub1 &&
> +			test_superproject_content origin/modify_sub1 &&
> +			test_submodule_content sub1 origin/modify_sub1
> +		)
> +	'
> +
>  	# Updating a submodule to an invalid sha1 doesn't update the
>  	# superproject nor the submodule's work tree.
>  	test_expect_success "$command: updating to a missing submodule commit fails" '
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index f3b0a8d30a..162baf101f 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
>  	test_i18ncmp expect.err actual.err
>  '
>  
> +test_expect_success "submodule.recurse option triggers recursive fetch" '
> +	add_upstream_commit &&
> +	(
> +		cd downstream &&
> +		git -c submodule.recurse fetch >../actual.out 2>../actual.err
> +	) &&
> +	test_must_be_empty actual.out &&
> +	test_i18ncmp expect.err actual.err
> +'
> +
>  test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
>  	add_upstream_commit &&
>  	(
> -- 
> 2.13.0.18.g7d86cc8ba0
> 

-- 
Brandon Williams
