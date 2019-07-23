Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00041F4B6
	for <e@80x24.org>; Tue, 23 Jul 2019 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfGWPUf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 11:20:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:40303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfGWPUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 11:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563895219;
        bh=GPuUjlXFsGFwG3211aGL4cuJIPVpNtSbbRZvJyh2yYQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MFVr+uzqWuhjVv8YOpUawJ09QVD7Rf6YBhS0GK1b0X2ZozRp+eYIqXJLT36sdlkmd
         x1IiYXJ53Oey6+gwc6A7aQt5zUGTvsFI9QgJFJmvElBhjsMWcpynEi8IvL41wwbsUW
         Iqn+zCTggSbRH5zHpD4Ph5jXcHS26caow5ihU5yM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1ibjwe15ql-00wGQq; Tue, 23
 Jul 2019 17:20:19 +0200
Date:   Tue, 23 Jul 2019 17:20:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] repo-settings: create feature.experimental setting
In-Reply-To: <da7685936f44a32121ec0568df2a9f23e4003506.1563818059.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907231708280.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <da7685936f44a32121ec0568df2a9f23e4003506.1563818059.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:54o10kAnUmaJP1t/Uk9rWJFELclt9Paj63YhGOCbmZnKqNIuuoq
 itOaAxpocZbtkD6wS/yAk/jNQ/YBHnRBPXcRP05A1W4MdXSt/rCNLWrP1zkRdGoS7gMjHwL
 /KqsJkMNYFMsp7lRS/qOx8VXucbbuHCpUt9rwaD8t2oI2aMHROk6AMVCmDgofXuArY7U5SA
 420qzHvD+ErUMcVglxk7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3G8gCReRZrs=:EGIIY5XPbmt4bjdL4NJMFy
 94QBLSSLlypmMh1AmdcNU0mrUJ4x4R7P5Cmh8HxPQfsKYgKcqiwfa2auMxT4pYtZg+ERlaJAf
 vWxoX2DkSH62rESO4WPICSYe7ojV/QfdjtzjX51YLZlAykciOk+lYvaCEF5MUzejEG4KPUdGi
 agjqXHi+G06xiw+D8WbHEj3OSh6pXI6SBshX6TrEKOx2BCtgfqm0CV0NIZXJYqdkOyKxusH7v
 xMDdn1ej1lTSgDCj5r/f8hykcd5nTpWmpEUmbjKQrKwB0WV0adZHWdMfq486LEJSn/HtswnFH
 s2VhG2MlYX5zhgWsOwiSQYex1YNXgHvTVuxie6vOFCkKvpOoyhLCGzdhYaAJTpn6VjW6dvKGD
 u2ieyj53rcFnl6RdLcu6oGTslcx8ZE+4yJ5shMenG7UOJL3ISQH9Ris53NpJftQWhTqBiSfBj
 clB8r6Hwq064u80i6OknpOmYDzt/0pxQ4uX32CXmd+v+CENwwLhwHZhO/gQWww+OEjt1bnpsU
 YWhoYczf6pTOD8GQIkKZPEuvIgHxHvY6lv7faT9EXSbe/jMGVFnLOFCbyhEdz6nZK6CKAh/Et
 SxgIUjeGBVrq48K/yfCqcpr60JnTVHgFAz8ao02oO2PJS7Lz7v3wdxHAjaneumGS4Ndnq0aiz
 4dQ8rWwW2txX93UbLtvvw3orNjm1KrbqARDIiQ7i06b107XRoyH1le1vhsOjktA9DDxXehlhN
 rDqfoVvnL7x9U1FRDqrUFdD3QyUyl6LzxLkCMckPp80pOP0EiLgsFjBQFN+VShyPmjf/MUIQJ
 KhYnMCDpN0ZS3e9a/eGa5h1kSO6vvowxvFbItni+dTT0j6lSRC6o3y97bcSeRNj5pqLKxMO1H
 h3asLqRuOm075qwCedH2bGFgdGyTxADeY/Ty11iX8yfaIt7yZjRnZPS2mN0K9b8BKTJhXRXnO
 EYOnJp6qnF7N4q8tnSa/T/lyg58NsC6zHTEXrn3FXx0sxLTIAE01ZXuU4n+Ny1MBrueRnj0PA
 R9E33y58Sd5Pz0/PCea2/c5T/9Z6cYbQvTUd4mELaik0ZHmL6zoaCy9jCnYy8Q/FAhRuvumF9
 BQXFCkZ9qcy31EiI8qVUDJMafOKCymMOg2M
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'feature.experimental' setting includes config options that are
> not committed to become defaults, but could use additional testing.
>
> Update the following config settings to take new defaults, and to
> use the repo_settings struct if not already using them:
>
> * 'pack.useSparse=3Dtrue'
>
> * 'merge.directoryRenames=3Dtrue'
>
> * 'fetch.negotiationAlgorithm=3Dskipping'
>
> In the case of fetch.negotiationAlgorithm, the existing logic
> would load the config option only when about to use the setting,
> so had a die() statement on an unknown string value. This is
> removed as now the config is parsed under prepare_repo_settings().
> In general, this die() is probably misplaced and not valuable.
> A test was removed that checked this die() statement executed.

Good.

> [...]
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 12300131fc..162d5a4753 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -28,6 +28,7 @@
>  #include "submodule.h"
>  #include "revision.h"
>  #include "commit-reach.h"
> +#include "repo-settings.h"
>
>  struct path_hashmap_entry {
>  	struct hashmap_entry e;
> @@ -1375,10 +1376,14 @@ static int handle_rename_via_dir(struct merge_op=
tions *opt,
>  	 * there is no content merge to do; just move the file into the
>  	 * desired final location.
>  	 */
> +	struct repository *r =3D the_repository;
>  	const struct rename *ren =3D ci->ren1;
>  	const struct diff_filespec *dest =3D ren->pair->two;
>  	char *file_path =3D dest->path;
> -	int mark_conflicted =3D (opt->detect_directory_renames =3D=3D 1);

I actually don't think that we want to do that; the `opt` parameter is
passed to the merge recursive algorithm specifically so that it can be
overridden by the caller.

Instead, what we should do, I think, is to change `init_merge_options()`
(which already gets a parameter of type `struct repository *`) so that
it does not hard-code the `detect_directory_renames` value to `1` but to
query the repo settings instead.

> +	int mark_conflicted;
> +
> +	prepare_repo_settings(r);
> +	mark_conflicted =3D (r->settings->merge_directory_renames =3D=3D MERGE=
_DIRECTORY_RENAMES_CONFLICT);
>  	assert(ren->dir_rename_original_dest);
>
>  	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
> @@ -2850,6 +2855,7 @@ static int detect_and_process_renames(struct merge=
_options *opt,
>  				      struct string_list *entries,
>  				      struct rename_info *ri)
>  {
> +	struct repository *r =3D the_repository;
>  	struct diff_queue_struct *head_pairs, *merge_pairs;
>  	struct hashmap *dir_re_head, *dir_re_merge;
>  	int clean =3D 1;
> @@ -2863,7 +2869,8 @@ static int detect_and_process_renames(struct merge=
_options *opt,
>  	head_pairs =3D get_diffpairs(opt, common, head);
>  	merge_pairs =3D get_diffpairs(opt, common, merge);
>
> -	if (opt->detect_directory_renames) {
> +	prepare_repo_settings(r);
> +	if (r->settings->merge_directory_renames) {
>  		dir_re_head =3D get_directory_renames(head_pairs);
>  		dir_re_merge =3D get_directory_renames(merge_pairs);
>
> @@ -3112,6 +3119,7 @@ static int handle_rename_normal(struct merge_optio=
ns *opt,
>  				const struct diff_filespec *b,
>  				struct rename_conflict_info *ci)
>  {
> +	struct repository *r =3D the_repository;
>  	struct rename *ren =3D ci->ren1;
>  	struct merge_file_info mfi;
>  	int clean;
> @@ -3121,7 +3129,9 @@ static int handle_rename_normal(struct merge_optio=
ns *opt,
>  	clean =3D handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
>  				     o, a, b, ci);
>
> -	if (clean && opt->detect_directory_renames =3D=3D 1 &&
> +	prepare_repo_settings(r);
> +	if (clean &&
> +	    r->settings->merge_directory_renames =3D=3D MERGE_DIRECTORY_RENAME=
S_CONFLICT &&
>  	    ren->dir_rename_original_dest) {
>  		if (update_stages(opt, path,
>  				  NULL,
> @@ -3155,6 +3165,7 @@ static void dir_rename_warning(const char *msg,
>  static int warn_about_dir_renamed_entries(struct merge_options *opt,
>  					  struct rename *ren)
>  {
> +	struct repository *r =3D the_repository;
>  	const char *msg;
>  	int clean =3D 1, is_add;
>
> @@ -3166,12 +3177,13 @@ static int warn_about_dir_renamed_entries(struct=
 merge_options *opt,
>  		return clean;
>
>  	/* Sanity checks */
> -	assert(opt->detect_directory_renames > 0);
> +	prepare_repo_settings(r);
> +	assert(r->settings->merge_directory_renames > 0);
>  	assert(ren->dir_rename_original_type =3D=3D 'A' ||
>  	       ren->dir_rename_original_type =3D=3D 'R');
>
>  	/* Check whether to treat directory renames as a conflict */
> -	clean =3D (opt->detect_directory_renames =3D=3D 2);
> +	clean =3D (r->settings->merge_directory_renames =3D=3D MERGE_DIRECTORY=
_RENAMES_TRUE);
>
>  	is_add =3D (ren->dir_rename_original_type =3D=3D 'A');
>  	if (ren->dir_rename_original_type =3D=3D 'A' && clean) {
> @@ -3662,15 +3674,6 @@ static void merge_recursive_config(struct merge_o=
ptions *opt)
>  		opt->merge_detect_rename =3D git_config_rename("merge.renames", value=
);
>  		free(value);
>  	}
> -	if (!git_config_get_string("merge.directoryrenames", &value)) {
> -		int boolval =3D git_parse_maybe_bool(value);
> -		if (0 <=3D boolval) {
> -			opt->detect_directory_renames =3D boolval ? 2 : 0;
> -		} else if (!strcasecmp(value, "conflict")) {
> -			opt->detect_directory_renames =3D 1;
> -		} /* avoid erroring on values from future versions of git */
> -		free(value);
> -	}
>  	git_config(git_xmerge_config, NULL);
>  }
>
> @@ -3687,7 +3690,6 @@ void init_merge_options(struct merge_options *opt,
>  	opt->renormalize =3D 0;
>  	opt->diff_detect_rename =3D -1;
>  	opt->merge_detect_rename =3D -1;
> -	opt->detect_directory_renames =3D 1;

In other words: here.

>  	merge_recursive_config(opt);
>  	merge_verbosity =3D getenv("GIT_MERGE_VERBOSITY");
>  	if (merge_verbosity)
> diff --git a/merge-recursive.h b/merge-recursive.h
> index c2b7bb65c6..b8eba244ee 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -22,7 +22,6 @@ struct merge_options {
>  	unsigned renormalize : 1;
>  	long xdl_opts;
>  	int verbosity;
> -	int detect_directory_renames;
>  	int diff_detect_rename;
>  	int merge_detect_rename;
>  	int diff_rename_limit;
> diff --git a/repo-settings.c b/repo-settings.c
> index 9e4b8e6268..5e9249c437 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -9,6 +9,12 @@ static int git_repo_config(const char *key, const char =
*value, void *cb)
>  {
>  	struct repo_settings *rs =3D (struct repo_settings *)cb;
>
> +	if (!strcmp(key, "feature.experimental")) {
> +		UPDATE_DEFAULT(rs->pack_use_sparse, 1);
> +		UPDATE_DEFAULT(rs->merge_directory_renames, MERGE_DIRECTORY_RENAMES_T=
RUE);
> +		UPDATE_DEFAULT(rs->fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKI=
PPING);
> +		return 0;
> +	}
>  	if (!strcmp(key, "feature.manycommits")) {
>  		UPDATE_DEFAULT(rs->core_commit_graph, 1);
>  		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
> @@ -50,6 +56,23 @@ static int git_repo_config(const char *key, const cha=
r *value, void *cb)
>  				"using 'keep' default value"), value);
>  		return 0;
>  	}
> +	if (!strcmp(key, "merge.directoryrenames")) {
> +		int bool_value =3D git_parse_maybe_bool(value);
> +		if (0 <=3D bool_value) {
> +			rs->merge_directory_renames =3D bool_value ? MERGE_DIRECTORY_RENAMES=
_TRUE : 0;
> +		} else if (!strcasecmp(value, "conflict")) {
> +			rs->merge_directory_renames =3D MERGE_DIRECTORY_RENAMES_CONFLICT;
> +		}
> +		return 0;
> +	}
> +	if (!strcmp(key, "fetch.negotiationalgorithm"))	{
> +		if (!strcasecmp(value, "skipping")) {
> +			rs->fetch_negotiation_algorithm =3D FETCH_NEGOTIATION_SKIPPING;
> +		} else {
> +			rs->fetch_negotiation_algorithm =3D FETCH_NEGOTIATION_DEFAULT;
> +		}
> +		return 0;
> +	}
>
>  	return 1;
>  }
> @@ -64,10 +87,14 @@ void prepare_repo_settings(struct repository *r)
>  	/* Defaults */
>  	r->settings->core_commit_graph =3D -1;
>  	r->settings->gc_write_commit_graph =3D -1;
> -	r->settings->pack_use_sparse =3D -1;
> +
>  	r->settings->index_version =3D -1;
>  	r->settings->core_untracked_cache =3D -1;
>
> +	r->settings->pack_use_sparse =3D -1;

This reordering at this stage in the patch series is a bit confusing.
Maybe add it at the location where you want it to end up to begin with?

Or use `memset(..., -1, ...)`.

> +	r->settings->merge_directory_renames =3D -1;
> +	r->settings->fetch_negotiation_algorithm =3D -1;
> +
>  	repo_config(r, git_repo_config, r->settings);
>
>  	/* Hack for test programs like test-dump-untracked-cache */
> @@ -75,4 +102,7 @@ void prepare_repo_settings(struct repository *r)
>  		r->settings->core_untracked_cache =3D CORE_UNTRACKED_CACHE_KEEP;
>  	else
>  		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACH=
E_KEEP);
> +
> +	UPDATE_DEFAULT(r->settings->merge_directory_renames, MERGE_DIRECTORY_R=
ENAMES_CONFLICT);
> +	UPDATE_DEFAULT(r->settings->fetch_negotiation_algorithm, FETCH_NEGOTIA=
TION_DEFAULT);
>  }
> diff --git a/repo-settings.h b/repo-settings.h
> index bac9b87d49..cecf7d0028 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -4,12 +4,22 @@
>  #define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
>  #define CORE_UNTRACKED_CACHE_KEEP (1 << 1)
>
> +#define MERGE_DIRECTORY_RENAMES_CONFLICT 1
> +#define MERGE_DIRECTORY_RENAMES_TRUE 2
> +
> +#define FETCH_NEGOTIATION_DEFAULT 1
> +#define FETCH_NEGOTIATION_SKIPPING 2
> +

Again, I'd prefer enums.

The rest looks pretty fine to me (I have to admit that I only glanced
over the tests, though).

Thanks!
Dscho

>  struct repo_settings {
>  	int core_commit_graph;
>  	int gc_write_commit_graph;
> -	int pack_use_sparse;
> +
>  	int index_version;
>  	int core_untracked_cache;
> +
> +	int pack_use_sparse;
> +	int merge_directory_renames;
> +	int fetch_negotiation_algorithm;
>  };
>
>  struct repository;
> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fet=
ch-negotiator.sh
> index 8a14be51a1..f70cbcc9ca 100755
> --- a/t/t5552-skipping-fetch-negotiator.sh
> +++ b/t/t5552-skipping-fetch-negotiator.sh
> @@ -60,29 +60,6 @@ test_expect_success 'commits with no parents are sent=
 regardless of skip distanc
>  	have_not_sent c6 c4 c3
>  '
>
> -test_expect_success 'unknown fetch.negotiationAlgorithm values error ou=
t' '
> -	rm -rf server client trace &&
> -	git init server &&
> -	test_commit -C server to_fetch &&
> -
> -	git init client &&
> -	test_commit -C client on_client &&
> -	git -C client checkout on_client &&
> -
> -	test_config -C client fetch.negotiationAlgorithm invalid &&
> -	test_must_fail git -C client fetch "$(pwd)/server" 2>err &&
> -	test_i18ngrep "unknown fetch negotiation algorithm" err &&
> -
> -	# Explicit "default" value
> -	test_config -C client fetch.negotiationAlgorithm default &&
> -	git -C client -c fetch.negotiationAlgorithm=3Ddefault fetch "$(pwd)/se=
rver" &&
> -
> -	# Implementation detail: If there is nothing to fetch, we will not err=
or out
> -	test_config -C client fetch.negotiationAlgorithm invalid &&
> -	git -C client fetch "$(pwd)/server" 2>err &&
> -	test_i18ngrep ! "unknown fetch negotiation algorithm" err
> -'
> -
>  test_expect_success 'when two skips collide, favor the larger one' '
>  	rm -rf server client trace &&
>  	git init server &&
> --
> gitgitgadget
>
