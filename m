Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683401F404
	for <e@80x24.org>; Wed, 15 Aug 2018 22:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbeHPBaU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 21:30:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34721 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeHPBaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 21:30:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so14069074wme.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZkMkG2AcDjHPzolQiz25+CKNmUu6utxhtTRRkUKWrXg=;
        b=kmEcqAaaMcRYTtimG9Bs+fAaFZFb2evYJTd/SPRaueW/JoHzb+jFMl/bM8/FpWV+fu
         hEL1k7Uk1VjxKOLVnyDVYWuSAOthfJvQfERPfTl9SUxl2iCp7EI8eu3mILOQJjwMqr+s
         ++iugx50Aw67peXhkU2qsEbFt86tq/gCjt3L6ELdqgvKhABel3FV/cE7IaBjX8l8qJv4
         +7PMedGTHrxqgunRvjRnRLoreDMQIBL+igSBhqKRh61+SqnfuxtlugWoUdzob7kwjOzS
         dzMV8TiS7zb3sKBK+D28XdXL7tUVG3Xz3RWaEWuVsQ2UzjmdE+3+RB9EkxgPCw6ELwC7
         g40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZkMkG2AcDjHPzolQiz25+CKNmUu6utxhtTRRkUKWrXg=;
        b=UbIqA+MfJC2HJcBLeTIwwI1UX4/ZlPPFX6/uUr3FeTzl7T+M1QxtXAIfYavb1UpUZy
         0pfrmX70spkD61iBAA7wp/v1nxffSOYAKRNopGtWEPZKdQOqk+JkIpEbbzojTGkRWgl1
         ywZ5HOWd5BS+lqLkUCwN+UhJ56KI2FZPJeePSZVp6NupZG2tusn/ho4+TigxXs+xg5Vo
         +dK31K4tKHTKgzbonNYmRdFzta6s8ah/jJkn0tzNeE+BaCrmvn9ObuYwckAE+Kc/hIpG
         p4TMlLgWvS4EsskTjXfAQNnI/4IgNBxVAI7aoEHREVaAjwhUmfuB2omRnjjyk7nRgQM6
         oQGA==
X-Gm-Message-State: AOUpUlHJlQXHE6lZxLHXRlPbocsP/PXtWjNebpkXSeDx1W9oS6Ka67Ol
        Xzixdpg9SFxzdUUaE3K7bocXKQa9
X-Google-Smtp-Source: AA+uWPzuP0owzeYvawkMMSwtvCDGgc2l1M1obJE2Zdus+fcp/OrhmeL6/TyS3uIfZyPg5uVGkiU3HA==
X-Received: by 2002:a1c:c685:: with SMTP id w127-v6mr15101010wmf.133.1534372567013;
        Wed, 15 Aug 2018 15:36:07 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 187-v6sm5986354wmr.40.2018.08.15.15.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:36:06 -0700 (PDT)
Date:   Wed, 15 Aug 2018 23:36:05 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, karen@codesynthesis.com
Subject: Re: [PATCH v2] worktree: add --quiet option
Message-ID: <20180815223605.GA11326@hank.intra.tgummerer.com>
References: <20180815205630.32876-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180815205630.32876-1-gitter.spiros@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/15, Elia Pinto wrote:
> Add the '--quiet' option to git worktree,
> as for the other git commands. 'add' is the
> only command affected by it since all other
> commands, except 'list', are currently
> silent by default.
> 
> Helped-by: Martin Ågren <martin.agren@gmail.com>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the second version of the patch.
> 
> Changes from the first version
> (https://public-inbox.org/git/CACsJy8A=zp7nFBuWyfeP4UFf3KSsiaor3m0mtgVnhcEYHSw4HA@mail.gmail.com/T/):
> 
> - deleted garbage in git-worktree.c and deleted
> superfluous blank line in git-worktree.txt.
> - when giving "--quiet" to 'add', call git symbolic-ref also with
> "--quiet".
> - changed the commit message to be more general, but
> specifying why the "--quiet" option is meaningful only for
> the 'add' command of git-worktree.
> - in git-worktree.txt the option
> "--quiet" is described near the "--verbose" option.
> 
>  Documentation/git-worktree.txt |  4 ++++
>  builtin/worktree.c             | 16 +++++++++++++---
>  t/t2025-worktree-add.sh        |  5 +++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 9c26be40f..29a5b7e25 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -173,6 +173,10 @@ This can also be set up as the default behaviour by using the
>  	This format will remain stable across Git versions and regardless of user
>  	configuration.  See below for details.
>  
> +-q::
> +--quiet::
> +	With 'add', suppress feedback messages.

Very minor nit here, we seem to use backticks everywhere else in this
document, maybe we sould do that here as well?  Not sure it's worth
another iteration though.

The rest of the patch looks good to me, thanks!

>  -v::
>  --verbose::
>  	With `prune`, report all removals.
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index a763dbdcc..41e771439 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -27,6 +27,7 @@ static const char * const worktree_usage[] = {
>  struct add_opts {
>  	int force;
>  	int detach;
> +	int quiet;
>  	int checkout;
>  	int keep_locked;
>  };
> @@ -303,9 +304,13 @@ static int add_worktree(const char *path, const char *refname,
>  	if (!is_branch)
>  		argv_array_pushl(&cp.args, "update-ref", "HEAD",
>  				 oid_to_hex(&commit->object.oid), NULL);
> -	else
> +	else {
>  		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
>  				 symref.buf, NULL);
> +		if (opts->quiet)
> +			argv_array_push(&cp.args, "--quiet");
> +	}
> +
>  	cp.env = child_env.argv;
>  	ret = run_command(&cp);
>  	if (ret)
> @@ -315,6 +320,8 @@ static int add_worktree(const char *path, const char *refname,
>  		cp.argv = NULL;
>  		argv_array_clear(&cp.args);
>  		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +		if (opts->quiet)
> +			argv_array_push(&cp.args, "--quiet");
>  		cp.env = child_env.argv;
>  		ret = run_command(&cp);
>  		if (ret)
> @@ -437,6 +444,7 @@ static int add(int ac, const char **av, const char *prefix)
>  		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
>  		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
>  		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
> +		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
>  		OPT_PASSTHRU(0, "track", &opt_track, NULL,
>  			     N_("set up tracking mode (see git-branch(1))"),
>  			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
> @@ -491,8 +499,8 @@ static int add(int ac, const char **av, const char *prefix)
>  			}
>  		}
>  	}
> -
> -	print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
> +	if (!opts.quiet)
> +		print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
>  
>  	if (new_branch) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> @@ -500,6 +508,8 @@ static int add(int ac, const char **av, const char *prefix)
>  		argv_array_push(&cp.args, "branch");
>  		if (new_branch_force)
>  			argv_array_push(&cp.args, "--force");
> +		if (opts.quiet)
> +			argv_array_push(&cp.args, "--quiet");
>  		argv_array_push(&cp.args, new_branch);
>  		argv_array_push(&cp.args, branch);
>  		if (opt_track)
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index be6e09314..658647d83 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -252,6 +252,11 @@ test_expect_success 'add -B' '
>  	test_cmp_rev master^ poodle
>  '
>  
> +test_expect_success 'add --quiet' '
> +	git worktree add --quiet ../foo master >expected 2>&1 &&
> +	test_must_be_empty expected
> +'
> +
>  test_expect_success 'local clone from linked checkout' '
>  	git clone --local here here-clone &&
>  	( cd here-clone && git fsck )
> -- 
> 2.18.0.723.g64e6cc43e.dirty
> 
