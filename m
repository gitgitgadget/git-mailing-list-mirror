Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2055D1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 14:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeIXUYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 16:24:09 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:44381 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeIXUYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 16:24:09 -0400
Received: by mail-qt1-f177.google.com with SMTP id k38-v6so9574685qtk.11
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gi1tti4r6U1oIxnodVQNSud9cKPHWoIhQFhN1iV88pc=;
        b=B0etahrIPIFP8Cb5WfIhTGMDLrmBEpiDjqgGqveLgfqr9PbZxDPpu8YrPG7Y+2X6tl
         CmAELYYiFCQFhu2ppGofw5uxigJcZWdpcsIdk9izoNDAO5ywaEhRe8F/UMutoqU7hn/s
         z8icPdD4y4di+er0Fqzkxj1HWD084sVswkgUaq+zoSXuTdqAKPAYk17qGXdg0N+5QxFQ
         JKr6PRQ1XtgtiY61fo3x74Ees4KZR8mwVHQ68EhplCPfeAZZLNmLOe3Ogy8TCD9xwS1w
         WDLelSeFENDv1d+AeaKmE20Jpr+RuwJETK7cznubWaPyZJHU2NoMjZC0GQogcxzt82Xr
         9wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gi1tti4r6U1oIxnodVQNSud9cKPHWoIhQFhN1iV88pc=;
        b=ZztJqV9F/h+nvnf4CWEJ4l2lAUHjPiCf7mLViaaljgng+WlPE+NpsMJYG36BLkk/gk
         9E9bur6ZkDwjcFbgMrj5Zuc8UnKYrR6mI4uypSKHgaH/qS0ozUOQYNEi0ehesQhPSkge
         5tG+HHUTWtS9cysB2M1jguU5BNIQUX+sOktnQBP1+zx9lAWUvUSWgTN7L9nvl+eTFJB4
         joMwOU6Ak+bbD7d4YRXN8iS9oWn1Lt0cV2NY7j+WNVYJpx6epRIALrmYNFroFCPgVv3S
         F8iBG8Udg3LPvDqGCeoL8i1Ok1ClEX/vOO3abC8dTGqkwsRc8t/A6d1hLQ/EA2glwzUi
         WzMw==
X-Gm-Message-State: ABuFfojABvAxMoGHtqTpEIqZi2RR0+/wSuqju0Yr2yzg6D1dSJwGnmK/
        h7j8uNz5HlNm73JIBvcYpXgKeg==
X-Google-Smtp-Source: ACcGV633hRML9oOD5ttSmVvH6cGwiV2zcVkDUdudVHF1h7/VyLyLAbddVnC+k1qw4w14dp0ba0heGA==
X-Received: by 2002:a0c:c38e:: with SMTP id o14-v6mr7749012qvi.36.1537798906098;
        Mon, 24 Sep 2018 07:21:46 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id f53-v6sm25508554qtk.40.2018.09.24.07.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 07:21:44 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:21:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] worktree: add per-worktree config files
Message-ID: <20180924142143.GD68796@syl>
References: <20180923170438.23610-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180923170438.23610-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 07:04:38PM +0200, Nguyễn Thái Ngọc Duy wrote:
> A new repo extension is added, worktreeConfig. When it is present:

I was initially scratching my head at why this should be a repository
extension, but...

>  - The special treatment for core.bare and core.worktree, to stay
>    effective only in main worktree, is gone. These config files are
>    supposed to be in config.worktree.

This seems to be sufficient justification for it. A destructive action
(such as migrating configuration from one location to another, as you
have implemented in the patch below) should be something that the user
opts into, rather than having happen automatically.

> This extension is most useful in multiple worktree setup because you
> now have an option to store per-worktree config (which is either
> .git/config.worktree for main worktree, or
> .git/worktrees/xx/config.worktree for linked ones).

This sounds quite useful for these situations.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8d85d1a324..c24abf5871 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2,8 +2,9 @@ CONFIGURATION FILE
>  ------------------
>
>  The Git configuration file contains a number of variables that affect
> -the Git commands' behavior. The `.git/config` file in each repository
> -is used to store the configuration for that repository, and
> +the Git commands' behavior. The files `.git/config` and optionally
> +`config.worktree` (see `extensions.worktreeConfig` below) are each
> +repository is used to store the configuration for that repository, and

Typo: 'are each'.

>  ENVIRONMENT
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index e2ee9fc21b..3f9112db56 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -204,6 +204,43 @@ working trees, it can be used to identify worktrees. For example if
>  you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
>  then "ghi" or "def/ghi" is enough to point to the former working tree.
>
> +CONFIGURATION FILE
> +------------------
> +By default, the repository "config" file is shared across all working
> +directories. If the config variables `core.bare` or `core.worktree`
> +are already present in the config file, they will be applied to the
> +main working directory only.
> +
> +In order to have configuration specific to working directories, you
> +can turn on "worktreeConfig" extension, e.g.:
> +
> +------------
> +$ git config extensions.worktreeConfig true
> +------------

Good, this matches my expectation from above.

> @@ -24,6 +25,7 @@ static char key_delim = ' ';
>  static char term = '\n';
>
>  static int use_global_config, use_system_config, use_local_config;
> +static int use_worktree_config;
>  static struct git_config_source given_config_source;
>  static int actions, type;
>  static char *default_value;
> @@ -123,6 +125,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
>  	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
>  	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
> +	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
>  	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
>  	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
>  	OPT_GROUP(N_("Action")),
> @@ -602,6 +605,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>
>  	if (use_global_config + use_system_config + use_local_config +
> +	    use_worktree_config +
>  	    !!given_config_source.file + !!given_config_source.blob > 1) {

I feel like we're getting into "let's extract a function" territory,
here, since this line is growing in width. Perhaps:

  static int config_files_count()
  {
    return use_global_config + use_system_config + use_local_config +
  		use_worktree_config +
  		!!given_config_source.file +
  		!!given_config_source.blob;
  }

Simplifying the call to:

> diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
> new file mode 100755
> index 0000000000..4ebdf13cf9
> --- /dev/null
> +++ b/t/t2029-worktree-config.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description="config file in multi worktree"
> +
> +. ./test-lib.sh
> +
> +cmp_config() {
> +	if [ "$1" = "-C" ]; then
> +		shift &&
> +		GD="-C $1" &&
> +		shift
> +	else
> +		GD=
> +	fi &&
> +	echo "$1" >expected &&
> +	shift &&
> +	git $GD config "$@" >actual &&
> +	test_cmp expected actual
> +}

This cmp_config seems generally useful, perhaps beyond t2029. What do
you think about putting it in t/test-lib-functions.sh instead?

Thanks,
Taylor
