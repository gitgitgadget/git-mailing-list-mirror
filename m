Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA0E1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeICRoR (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 13:44:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:41897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeICRoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 13:44:17 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWCKz-1gPANQ31hZ-00XKB2; Mon, 03
 Sep 2018 15:24:05 +0200
Date:   Mon, 3 Sep 2018 15:24:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 13/20] stash: convert store to builtin
In-Reply-To: <5466d911db63333c21317714e15b5bff827008a6.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809031512470.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <5466d911db63333c21317714e15b5bff827008a6.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WClK0PUSjMAmo2I5lK1sSKso2BFe3E629rFkCUJGlo9zNJsw9st
 O75KwcLsUWQTpnrw/TyIppQedr0/gkB613E9Vf/1os8/RlAw5aTjgJe8+T8Sya2X6y69K/G
 GU0Ll4jP4X8zF4ks3q5PFETde3fXxwOLlEDmqIeZ1AfNq7fMNOexNxPpb7wPR/i7Q6Q/9SD
 +D4p2pdagfaMZGOq8Dmdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVDcboAhE04=:l6wdHzy2Q7ST7cn6rFcLxo
 0KfqaC0oHlIHincDGfHONKtyr6FK7CpdG86C4EaQawwfcxKfKQojtVafmOC1X0WoJDu+GgXnp
 Bct7N8piH4+U5Htwd6EjRTg8/qTAHelRfqt7jwVQbfRMuDSyjVouv1eIThSkWyPs3sDezOeq/
 85eak1mSdPjtlGDHkThOE+df3wV/euNujtPYcG1cxnXDxeuhrmePZp7QOP9bV/fgRw9j1yatB
 pla7jPWbv8FROI1CRcMvcLN3t4EmIbRGDBP7JVGOV/toWHW3lvg6LIgUeqfOLcroDGY7ipkrK
 T4TbhjpFztYQjgH8sf9XotVUuL3WRfXl6kpEhlP76haUVIFRwjFndL7tMsvPh7Zoia6Xhtvjf
 biUaNO4GweHR7SpQucEid9+gNH/Rg1mfMPbOYYxWK2FHSt/S25U7GEYwMX8agutxsRkVkBAWp
 Yp7fLeu/cW05MGEzMR6Y+itt5+9N3W6vxGIVy7qgz5Ia3SjUo7CYN5sFUfvwZFfKdtZK9bGE2
 iljglcuA22gMpBvxyBl/RTajNZgBXmRhYfKOjAYFaboKRSN3Mca1O0VVbyirsiQjxzm2iJiy9
 3aPe+/OtIT895ss/FjtKUtKAao1LkeoPVAV87lqw0KFp0JcS1TUnAdEKfJO/i6C/j+ykzGSHV
 5IZgGqB3MTc6yrH0Xu/li0tuNeqP5rpERYDOQGQCpXBKUD213KdQN7g6YUUVQnwpNquXalDVR
 hA7Ez7acARmT002/VBs80INegl8jJGmz4iiQv5zCjDpecbBnxpsuAdTsqkHYsZcStjlkWBXng
 QhWYo5B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 02b593e0cd..87568b0f34 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -723,6 +728,54 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  	return diff_result_code(&rev.diffopt, 0);
>  }
>  
> +static int do_store_stash(const char *w_commit, const char *stash_msg,
> +			  int quiet)
> +{
> +	int ret = 0;
> +	int need_to_free = 0;

Not worth sending another iteration, but if you end up doing so, I found
an alternative paradigm more useful: instead of having a Boolean to
indicate whether you need to free, have a `char *to_free` that is
initialized to `NULL`, then unconditionally release that:

	char *to_free = NULL;

	if (!stash_msg)
		stash_msg = to_free = xstrdup("Created via \"git stash store\".");

	[...]

	free(to_free);
	return ret;

This works because `free(NULL)` is defined as a no-op.

> +	struct object_id obj;
> +
> +	if (!stash_msg) {
> +		need_to_free = 1;
> +		stash_msg  = xstrdup("Created via \"git stash store\".");
> +	}
> +
> +	ret = get_oid(w_commit, &obj);

Is `get_oid()` non-quiet? If so, we might need to shut it up when the
`quiet` variable is non-zero. If it is quiet, we should probably mention
something here when `quiet` is zero and `ret` indicates an error with
`get_oid()`.

> +	if (!ret) {
> +		ret = update_ref(stash_msg, ref_stash, &obj, NULL,
> +				 REF_FORCE_CREATE_REFLOG,
> +				 quiet ? UPDATE_REFS_QUIET_ON_ERR :
> +				 UPDATE_REFS_MSG_ON_ERR);
> +	}
> +	if (ret && !quiet)
> +		fprintf_ln(stderr, _("Cannot update %s with %s"),
> +			   ref_stash, w_commit);
> +	if (need_to_free)
> +		free((char *) stash_msg);

Okay, so all we need `stash_msg` for is the `update_ref()` call? And the
fall-back message is constant. So how about

	if (!stash_msg)
		stash_msg = "Created via \"git stash store\".";

? No need to allocate/release memory at all...

> +	return ret;
> +}
> +
> +static int store_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *stash_msg = NULL;
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_STRING('m', "message", &stash_msg, "message", N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_store_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (argc != 1) {
> +		fprintf_ln(stderr, _("\"git stash store\" requires one <commit> argument"));
> +		return -1;
> +	}
> +
> +	return do_store_stash(argv[0], stash_msg, quiet);
> +}

I guess `store_stash()` and `do_store_stash()` are separate functions to
discern between the higher-level function that parses the command-line,
and the lower-level function that is already libified?

If so:

1. I like it. Your code is already so much better prepared to serve as a proper
   internal API than even some Git old-timers'.

2. It might make sense to move the `get_oid()` call to `store_stash()`, as
   it is also parsing: it is parsing the plain-text representation of the
   revision into the internal representation (object ID).

Neither of these suggestions are blockers, though.

Thanks,
Dscho

>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -757,6 +810,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!list_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "show"))
>  		return !!show_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "store"))
> +		return !!store_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 0d05cbc1e5..5739c51527 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -191,45 +191,6 @@ create_stash () {
>  	die "$(gettext "Cannot record working tree state")"
>  }
>  
> -store_stash () {
> -	while test $# != 0
> -	do
> -		case "$1" in
> -		-m|--message)
> -			shift
> -			stash_msg="$1"
> -			;;
> -		-m*)
> -			stash_msg=${1#-m}
> -			;;
> -		--message=*)
> -			stash_msg=${1#--message=}
> -			;;
> -		-q|--quiet)
> -			quiet=t
> -			;;
> -		*)
> -			break
> -			;;
> -		esac
> -		shift
> -	done
> -	test $# = 1 ||
> -	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
> -
> -	w_commit="$1"
> -	if test -z "$stash_msg"
> -	then
> -		stash_msg="Created via \"git stash store\"."
> -	fi
> -
> -	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
> -	ret=$?
> -	test $ret != 0 && test -z "$quiet" &&
> -	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
> -	return $ret
> -}
> -
>  push_stash () {
>  	keep_index=
>  	patch_mode=
> @@ -308,7 +269,7 @@ push_stash () {
>  		clear_stash || die "$(gettext "Cannot initialize stash")"
>  
>  	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
> -	store_stash -m "$stash_msg" -q $w_commit ||
> +	git stash--helper store -m "$stash_msg" -q $w_commit ||
>  	die "$(gettext "Cannot save the current status")"
>  	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
>  
> @@ -468,7 +429,7 @@ create)
>  	;;
>  store)
>  	shift
> -	store_stash "$@"
> +	git stash--helper store "$@"
>  	;;
>  drop)
>  	shift
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
