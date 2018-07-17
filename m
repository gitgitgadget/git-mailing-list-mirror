Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675861F597
	for <e@80x24.org>; Tue, 17 Jul 2018 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeGQLcu (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 07:32:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:44419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbeGQLct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 07:32:49 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt2BW-1g3x5f1qsE-012UAb; Tue, 17
 Jul 2018 13:00:41 +0200
Date:   Tue, 17 Jul 2018 13:00:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 5/5] format-patch: add --creation-weight tweak for
 --range-diff
In-Reply-To: <20180530080325.37520-6-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807171259290.71@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-6-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mud6hT+vO1Q0fQr7Zp0DRQyYN4hDoeB6KKe39pdHmGESEpNmv1b
 JexXPftec6m3IstVpbDJ4iix5aBqgiNVODcltbgSKm0AI8O6AF2nlb0xP1arkqQNLGQV2Z5
 bg8hG+IVGQTB42oQgdFLzLDxjiFDuT+s+dqtuOzY5Yk6VeZa3oyQvYCOZCuLBcaxFtVzbun
 QD0cumS6uI2F0V1Ofg+cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ThcsgSKIp8=:4HF0uFy1gFQ3zvoopKgtya
 ewVLOV1AlJQPt0wIZtaZjv48q6ZX1aMLjbHyA5YHDweC90JbP6JdhnXQ9DKNH8Ms7JYemqpIF
 reKHmT1XfZEvPDTmpzPNDvi9AsNF1WoOCRJMM3XC89V9UvD+GVWzY3E8YiwKKnmNJutDyAk8x
 GnIs9Ox9vWHaqO5AfL2+ucIJY3MoSQzHNT+O/+3Zf016SuNTSp2jRIcIc106cGIN5X8Ji7g5x
 GrbUfg9VeLfs+IfLKafPEzJO9ASLOsu0FkIo4H1oVG3hNvxze8Q/Fxc2JSqlkMbb6apQXrpvP
 l6+SI8xwhzgpQMPjQkLijakhBY7Va4DJup/tCITntlMYYwl73PNIIpFaOLV3sqQ/HE2EtYBk7
 mU4kEb5diN13qjJX35lyJKSkUSsyewPpQHD5ZtT2qI3x42eI+1hCdUXfPv0UEiOekut5ToLbW
 jt7Yr88RiKoBeiCvUwMVp+slKjbD7P1EJOOyJtmlAKFk2dKM+bBDKFn7KjhwxyxgU5YTiI/el
 MwKepmnNmHFOoqCkJ8rw8zLN/S/T7jDGM63xpaynf/URP0FXO6fWsG2sNYiXHJve6enFFj2Hi
 5zgCBMJxEfiuljnSX1qEnFsKhHXwZHdQNjxGJm66jpd72Y4wxlKm23pRn/A0CjaZ0g9k1CpTz
 OE64d/fJpR0J03JcEjDlgpsyNBvv8BN8LCi5iT8yFKrCDo1Z8imjsa7OCY7IJZlkgO/AO5Qn3
 RK8xIqIZnxTSvqI88lLbar/EhjHPpYXbEkxqlwGGtZUV4hMzaE8LwBjV9g9F1wlgwnO6WYYFq
 n+Bt7g+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 30 May 2018, Eric Sunshine wrote:

> When generating a range-diff, matching up commits between two version of
> a patch series involves heuristics, thus may give unexpected results.
> git-branch-diff allows tweaking the heuristic via --creation-weight.
> Follow suit by accepting --creation-weight in combination with
> --range-diff when generating a range-diff for a cover-letter.

Since I opted to change this to `--creation-factor`, taking an integer
between 0 and 100 (essentially), this patch will need heavy adjustment ;-=)

Thanks,
Dscho

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-format-patch.txt |  8 +++++++-
>  builtin/log.c                      | 19 +++++++++++++++----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 25026ae26e..7ed9ec9dae 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -23,7 +23,7 @@ SYNOPSIS
>  		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
> -		   [--range-diff=<previous>]
> +		   [--range-diff=<previous> [--creation-weight=<factor>]]
>  		   [--progress]
>  		   [<common diff options>]
>  		   [ <since> | <revision range> ]
> @@ -240,6 +240,12 @@ feeding the result to `git send-email`.
>  	disjoint (for example `git format-patch --cover-letter
>  	--range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
>  
> +--creation-weight=<factor>::
> +	Used with `--range-diff`, tweak the heuristic which matches up commits
> +	between the previous and current series of patches by adjusting the
> +	creation/deletion cost fudge factor. See linkgit:git-branch-diff[1])
> +	for details.
> +
>  --notes[=<ref>]::
>  	Append the notes (see linkgit:git-notes[1]) for the commit
>  	after the three-dash line.
> diff --git a/builtin/log.c b/builtin/log.c
> index 3089d3a50a..2c49011b51 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1012,12 +1012,16 @@ static void infer_diff_ranges(struct argv_array *args,
>  }
>  
>  static int get_range_diff(struct strbuf *sb,
> -			  const struct argv_array *ranges)
> +			  const struct argv_array *ranges,
> +			  const char *creation_weight)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  
>  	cp.git_cmd = 1;
>  	argv_array_pushl(&cp.args, "branch-diff", "--no-color", NULL);
> +	if (creation_weight)
> +		argv_array_pushf(&cp.args,
> +				 "--creation-weight=%s", creation_weight);
>  	argv_array_pushv(&cp.args, ranges->argv);
>  	return capture_command(&cp, sb, 0);
>  }
> @@ -1047,7 +1051,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      int nr, struct commit **list,
>  			      const char *branch_name,
>  			      int quiet,
> -			      const char *range_diff)
> +			      const char *range_diff,
> +			      const char *creation_weight)
>  {
>  	const char *committer;
>  	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
> @@ -1070,7 +1075,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (range_diff) {
>  		struct argv_array ranges = ARGV_ARRAY_INIT;
>  		infer_diff_ranges(&ranges, range_diff, origin, head);
> -		if (get_range_diff(&diff, &ranges))
> +		if (get_range_diff(&diff, &ranges, creation_weight))
>  			die(_("failed to generate range-diff"));
>  		argv_array_clear(&ranges);
>  	}
> @@ -1495,6 +1500,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	int show_progress = 0;
>  	struct progress *progress = NULL;
>  	const char *range_diff = NULL;
> +	const char *creation_weight = NULL;
>  
>  	const struct option builtin_format_patch_options[] = {
>  		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
> @@ -1570,6 +1576,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			 N_("show progress while generating patches")),
>  		OPT_STRING(0, "range-diff", &range_diff, N_("rev-range"),
>  			   N_("show changes against <rev-range> in cover letter")),
> +		OPT_STRING(0, "creation-weight", &creation_weight, N_("factor"),
> +			   N_("fudge factor by which creation is weighted")),
>  		OPT_END()
>  	};
>  
> @@ -1664,6 +1672,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		die (_("--subject-prefix/--rfc and -k are mutually exclusive."));
>  	rev.preserve_subject = keep_subject;
>  
> +	if (creation_weight && !range_diff)
> +		die(_("--creation-weight requires --range-diff"));
> +
>  	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
>  	if (argc > 1)
>  		die (_("unrecognized argument: %s"), argv[1]);
> @@ -1827,7 +1838,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			gen_message_id(&rev, "cover");
>  		make_cover_letter(&rev, use_stdout,
>  				  origin, nr, list, branch_name, quiet,
> -				  range_diff);
> +				  range_diff, creation_weight);
>  		print_bases(&bases, rev.diffopt.file);
>  		print_signature(rev.diffopt.file);
>  		total++;
> -- 
> 2.17.1.1235.ge295dfb56e
> 
> 
