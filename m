Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925CF1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbeGSTDT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:03:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbeGSTDT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:03:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so8980316wrt.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=x7jGqSrmZZC4vggckmTHipnRBa+UMrRuwWDp21lIgPE=;
        b=ZQOOnXJ501trydFaB15zi6zJgzSKZxu2AWaX8ADB7mYb+zSNV/y8Q/v+BiYhnFKioJ
         +gjvVzxOyjfrG+xBcmAv829QDSDcEmoUMGt8KSuPROIZoTWZfMHWPxOFNIFRvwbdyvNH
         mk+YHgMFcTuIreHzewqinIlRpOvNSWZHEDY61C9hdf+et0s2289u+qV0uzO1pAuybxJ2
         q0JyawP0nTSaG75q2UPnVN+EnnjO0ccPwqOzaAOT51/IgoqJ6bFkJ06Ch/wyHaP8EXKX
         zALsPf368YftS1ohoBOV2ofj8bIfafLiKevv9gyQVqAYu/rXJY7i9EvoKMl67wajfw4g
         wJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=x7jGqSrmZZC4vggckmTHipnRBa+UMrRuwWDp21lIgPE=;
        b=AEAnsWvWY1QEnkTQXDLJAWEcI40YXXYL2MtrjS+5EoC5d+TZYZaY3/TdsNiPiNiWJb
         GFGjKBuqWP9E6l6L5CUq5jDQew01GfgYC1Muqs3Ldd7SHuyDeyjoGBiv1eRpCDjlN1eR
         LqBTpVLSyNd6UqWBJN1fB3O1SHrCpPADXL1o51pKL8Qi6hcrBF0zYVbUqK3UvNXJuxVN
         Vs9e+NnYh5K8OZ2QMRDsZH3OFh/GcxxAw7Rz48RO4I8yHRvEsO6YnqwfDEt+NYMyZgzM
         KsixZ0BYKIB8CG7KtFBRzG9vhcp1vIIHNSjxptMc50T/hIP1qyxg4LoQncfgJqCYRUwV
         9yjQ==
X-Gm-Message-State: AOUpUlHqJh8HqkxUI3T1XrfD48sUk0ANRa2SfvkiNbQkq3NgUBWD9Hap
        WTDqr6BKr91Thp2Bmd4tf9s=
X-Google-Smtp-Source: AAOMgpdU61guehXSeHXPwN7IKVfcu2beo5mdAVmY+OBO7suaQXXIplqpE/SZv4Br/VZdIlhsGypdmg==
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr7919797wrc.135.1532024337395;
        Thu, 19 Jul 2018 11:18:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm10439764wrs.91.2018.07.19.11.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:18:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/23] Update messages in preparation for i18n
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-2-pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 11:18:55 -0700
In-Reply-To: <20180718161101.19765-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 18 Jul 2018 18:10:39 +0200")
Message-ID: <xmqqr2jzf5rk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  static void check_argc(int argc, int min, int max) {
>  	if (argc >= min && argc <= max)
>  		return;
> -	error("wrong number of arguments");
> +	if (min == max)
> +		error("wrong number of arguments, should be %d", min);
> +	else
> +		error("wrong number of arguments, should be from %d to %d",
> +		      min, max);
>  	usage_with_options(builtin_config_usage, builtin_config_options);
>  }

Good. This was the only instance of

> - some messages are improved to give more information

I spotted.

> @@ -622,7 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  			 * location; error out even if XDG_CONFIG_HOME
>  			 * is set and points at a sane location.
>  			 */
> -			die("$HOME not set");
> +			die("$HOME is not set");

Meh.  There are many verb-less messages e.g. "only one X at a time"
that are not given a new verb in this patch.

> @@ -819,7 +823,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 0)
> -			die("No such section!");
> +			die("no such section: %s", argv[0]);
>  	}
>  	else if (actions == ACTION_REMOVE_SECTION) {
>  		int ret;
> @@ -830,7 +834,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 0)
> -			die("No such section!");
> +			die("no such section: %s", argv[0]);
>  	}

There are check_argc() calls before these two hunks to ensure that
access to argv[0] is safe, so these are good.

> @@ -2638,7 +2638,7 @@ static void read_object_list_from_stdin(void)
>  			if (feof(stdin))
>  				break;
>  			if (!ferror(stdin))
> -				die("fgets returned NULL, not EOF, not error!");
> +				die("BUG: fgets returned NULL, not EOF, not error!");

This is not BUG("...") because it is not *our* bug but a bug in platform's stdio?

> @@ -456,10 +456,10 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
>  		return -1;
>  	}
>  
> -	if (remove_signature(&buf)) {
> -		warning(_("the original commit '%s' has a gpg signature."), old_ref);
> -		warning(_("the signature will be removed in the replacement commit!"));
> -	}
> +	if (remove_signature(&buf))
> +		warning(_("the original commit '%s' has a gpg signature.\n"
> +			  "The signature will be removed in the replacement commit!"),
> +			old_ref);

Unlike a compound sentence, for which translators may appreciate
that they can reorder the parts of it to suit their language, I do
not see why these two independent sentences should be placed in a
single warning().

Or is this primarily about avoiding repeated appearance of
"warning:" labels, i.e.

	warning: sentence one
	warning: sentence two

I am not sure if these belong to this "simple mechanical conversion
or otherwise uncontrovercial improvement" series.

> diff --git a/config.c b/config.c
> index f4a208a166..6ba07989f1 100644
> --- a/config.c
> +++ b/config.c
> @@ -461,7 +461,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>  	envw = xstrdup(env);
>  
>  	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> -		ret = error("bogus format in " CONFIG_DATA_ENVIRONMENT);
> +		ret = error("bogus format in %s", CONFIG_DATA_ENVIRONMENT);
>  		goto out;
>  	}
>  

Good job spotting that the original wanted to say, but failed to
say, that CONFIG_DATA_ENVIRONMENT as the source of broken data we
detected.  But I am not sure CONFIG_DATA_ENVIRONMENT is what we want
to report as the source of bad data to the end users.  One-shot
configuration we get form "git -c VAR=VAL" are placed in the
environment as an internal implementation detail, so from their
point of view, the place we saw broken data coming from is their
command line "git -c VAR=VAL" one-shot configuration.

> @@ -1409,11 +1409,11 @@ static int git_default_push_config(const char *var, const char *value)
>  			push_default = PUSH_DEFAULT_UPSTREAM;
>  		else if (!strcmp(value, "current"))
>  			push_default = PUSH_DEFAULT_CURRENT;
> -		else {
> -			error("malformed value for %s: %s", var, value);
> -			return error("Must be one of nothing, matching, simple, "
> -				     "upstream or current.");
> -		}
> +		else
> +			return error("malformed value for %s: %s\n"
> +				     "Must be one of nothing, matching, simple, "
> +				     "upstream or current.",
> +				     var, value);

The same comment as an earlier warning().

> -	if (flags & CONNECT_VERBOSE)
> -		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
> +	if (flags & CONNECT_VERBOSE) {
> +		fprintf_ln(stderr, "done.");
> +		fprintf(stderr, "Connecting to %s (port %s) ... ", host, port);
> +	}

It was not immediately obvious why this is a good change, but with
this patch, we have many instances of "done." that can share the
same translation, I guess.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh

It is surprising that the fallout from the conversions in the rest
of the patch is this small ;-)

Whew.  This was a rather sizeable patch.  The parts I did not quote
and comment all looked good.

Thanks.


