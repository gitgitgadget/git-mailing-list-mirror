Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616B21F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGQLCv (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 07:02:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:36461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbeGQLCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 07:02:51 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McmS9-1fNQjL3lRJ-00HwsR; Tue, 17
 Jul 2018 12:30:51 +0200
Date:   Tue, 17 Jul 2018 12:30:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/5] format-patch: add --range-diff option to embed
 diff in cover letter
In-Reply-To: <20180530080325.37520-3-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807171219480.71@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-3-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MZ9cd3o7NzEJdWE+DhsyX1+sVATKs+fIT43STly3goRhF7GTDpa
 zQzAAjoToQFu+qiqvWhkbv64Q1kjwZ8e7amKgd+xhry2o4jPXAMWzGaIhAjEoD2BokR+W4I
 YsE8VWqFo4xfbsVjVjbBgc7WWs+gr/QvKk0NYE5/WNx5HsFpOGTKD+tPHHvpTpwfW4NM61V
 TxLcmVUts6FH3lRiu935A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:238cY0ZrxPY=:005DoA0nY2GZxTVncMCq0F
 9r1CB9gCdEYqnurUBNqo2VbqpTOoeStVOubgkMp4tE260I3F72xoNOF+tvGWyq2sNwep9erzg
 ehXTtYhfefqxOkExsVB/LyVGum801U0YPr9bgqP5By5CJgqY760OxQtuYT7mkR3b1dw/7N3SO
 BEn5AWDJeSnVPYlRPf6x6ux5KKa6BOjy80yzzq2t2AgG0jounOFduPznmul/eABEd8HgMXVLg
 /ANan6Cz0Xoc+Y8USqJlGzaafpTGH+ufGNoSPm2UspzM9QB+f6lk7bz5ydu0mdwDMT/s55wTX
 dmJ8+d5x/H3j2JZW7gN7a1300S6KViHU0xExrxuLizYDqhA/iV1fPJfUpO2RTQJUkpbV9ng0V
 HQwTyMW5tp0Zhe8PEux0SApw9jsW1rypy3m7PrlBeMlLT/vkM/DDE8Jd7d0egAWWN3uVGhbPU
 ++E/55LzgYF7C0FrBrCtslzQEX29FKySDFbDiBEySycKLcPZ9TGHron0mWmyJ/AstWVq98hsi
 NbFsS6B6GSmL8029iOEBwVZBlPFys/sIszmMP8cGHHqF60n+VfIf7B4t4nTyxcKFMu46ZLLwE
 S45WWMCLXzbrM7j7+n6DJlIlzoOnpsWyt/DJwh3hJOuhdNYmnmbeL5weZZ8g9rHFJOUkV9ksL
 ZtH9LdDG2nv/6VTp0BjZcgaKvPsVG1pKS/G2rzBlVOLgPn/98dgTS2SgY9YM98UGwS3PaMQv9
 IxcecGw2wOTr2BJJ2X8Algp+QDmKs13DgN+x/Xvwfgjv42UR+DntdY3rhpeVJrMBjlMUUi+Ao
 aBq3e1J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 30 May 2018, Eric Sunshine wrote:

> diff --git a/builtin/log.c b/builtin/log.c
> index e01a256c11..460c31a293 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -28,6 +28,7 @@
>  #include "mailmap.h"
>  #include "gpg-interface.h"
>  #include "progress.h"
> +#include "run-command.h"
>  
>  #define MAIL_DEFAULT_WRAP 72
>  
> @@ -992,6 +993,25 @@ static char *find_branch_name(struct rev_info *rev)
>  	return branch;
>  }
>  
> +static void infer_diff_ranges(struct argv_array *args,
> +			      const char *prev,
> +			      struct commit *head)
> +{
> +	argv_array_pushf(args, "%s...%s", prev,
> +			 oid_to_hex(&head->object.oid));
> +}
> +
> +static int get_range_diff(struct strbuf *sb,

If you rename `sb` to `out`, it makes it more obvious to the casual reader
that this strbuf will receive the output.

> +			  const struct argv_array *ranges)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "branch-diff", "--no-color", NULL);

Obviously, this needs to be "range-diff" now.

> +	argv_array_pushv(&cp.args, ranges->argv);

As there must be exactly two ranges, it would make more sense to pass them
explicitly. And then you can use one single call to `argv_array_pushl()`
instead.

> +	return capture_command(&cp, sb, 0);
> +}
> +
>  static void emit_diffstat(struct rev_info *rev,
>  			  struct commit *origin, struct commit *head)
>  {
> @@ -1016,7 +1036,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
>  			      const char *branch_name,
> -			      int quiet)
> +			      int quiet,
> +			      const char *range_diff)
>  {
>  	const char *committer;
>  	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
> @@ -1028,15 +1049,25 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	int need_8bit_cte = 0;
>  	struct pretty_print_context pp = {0};
>  	struct commit *head = list[0];
> +	struct strbuf diff = STRBUF_INIT;

I guess you want to call it `diff` instead of `range_diff` because a
future change will reuse this for the interdiff instead? And then also to
avoid a naming conflict with the parameter.

Dunno. I would still call it `range_diff` until the day comes (if ever)
when `--interdiff` is implemented. And I would call the `range_diff`
parameter `range_diff_opt` instead, or some such.

Or maybe use `extra_footer` instead of `diff`.

>  	if (!cmit_fmt_is_mail(rev->commit_format))
>  		die(_("Cover letter needs email format"));
>  
>  	committer = git_committer_info(0);
>  
> +	/* might die from bad user input so try before creating cover letter */
> +	if (range_diff) {
> +		struct argv_array ranges = ARGV_ARRAY_INIT;
> +		infer_diff_ranges(&ranges, range_diff, head);
> +		if (get_range_diff(&diff, &ranges))
> +			die(_("failed to generate range-diff"));

BTW I like to have an extra space in front of all the range-diff lines, to
make it easier to discern them from the rest.

> +		argv_array_clear(&ranges);
> +	}
> +
>  	if (!use_stdout &&
>  	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
> -		return;
> +		goto done;

Hmm. If you think you will add more `goto done`s in the future, I guess
this is okay. Otherwise, it would probably make sense to go ahead and
simply `strbuf_release(&diff)` before `return`ing.

>  	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte);
>  
> @@ -1077,6 +1108,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	/* We can only do diffstat with a unique reference point */
>  	if (origin)
>  		emit_diffstat(rev, origin, head);
> +
> +	if (diff.len) {
> +		FILE *fp = rev->diffopt.file;
> +		fputs(_("Changes since previous version:"), fp);
> +		fputs("\n\n", fp);
> +		fputs(diff.buf, fp);
> +		fputc('\n', fp);
> +	}
> +
> +done:
> +	strbuf_release(&diff);
>  }
>  
>  static const char *clean_message_id(const char *msg_id)
> @@ -1438,6 +1480,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	struct base_tree_info bases;
>  	int show_progress = 0;
>  	struct progress *progress = NULL;
> +	const char *range_diff = NULL;

Maybe `range_diff_opt`? It's not exactly the range diff that is contained
in this variable.

>  	const struct option builtin_format_patch_options[] = {
>  		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
> @@ -1511,6 +1554,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
>  		OPT_BOOL(0, "progress", &show_progress,
>  			 N_("show progress while generating patches")),
> +		OPT_STRING(0, "range-diff", &range_diff, N_("rev-range"),
> +			   N_("show changes against <rev-range> in cover letter")),
>  		OPT_END()
>  	};
>  
> @@ -1733,6 +1778,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	if (numbered)
>  		rev.total = total + start_number - 1;
>  
> +	if (range_diff && !cover_letter)
> +		die(_("--range-diff requires --cover-letter"));

I guess this will be changed in a future patch, allowing a single patch to
ship with a range diff, too?

> +
>  	if (!signature) {
>  		; /* --no-signature inhibits all signatures */
>  	} else if (signature && signature != git_version_string) {
> @@ -1764,7 +1812,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		if (thread)
>  			gen_message_id(&rev, "cover");
>  		make_cover_letter(&rev, use_stdout,
> -				  origin, nr, list, branch_name, quiet);
> +				  origin, nr, list, branch_name, quiet,
> +				  range_diff);
>  		print_bases(&bases, rev.diffopt.file);
>  		print_signature(rev.diffopt.file);
>  		total++;
> diff --git a/t/t7910-branch-diff.sh b/t/t7910-branch-diff.sh
> index a7fece8804..edbd69b6f8 100755
> --- a/t/t7910-branch-diff.sh
> +++ b/t/t7910-branch-diff.sh
> @@ -141,4 +141,19 @@ test_expect_success 'changed message' '
>  	test_cmp expected actual
>  '
>  
> +format_patch () {
> +	title=$1 &&
> +	range=$2 &&
> +	test_expect_success "format-patch --range-diff ($title)" '
> +		git format-patch --stdout --cover-letter --range-diff=$range \
> +			master..unmodified >actual &&
> +		grep "= 1: .* s/5/A" actual &&
> +		grep "= 2: .* s/4/A" actual &&
> +		grep "= 3: .* s/11/B" actual &&
> +		grep "= 4: .* s/12/B" actual

I guess this might make sense if `format_patch` was not a function, but it
is specifically marked as a function... so... shouldn't these `grep`s also
be using function parameters?

> +	'
> +}
> +
> +format_patch 'B...C' topic
> +
>  test_done
> -- 
> 2.17.1.1235.ge295dfb56e

Thanks,
Dscho
