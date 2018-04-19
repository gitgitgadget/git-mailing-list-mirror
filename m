Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBB31F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDSIRd (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:17:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:49601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeDSIRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:17:30 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1eJjBg2fPZ-00sPyA; Thu, 19
 Apr 2018 10:17:25 +0200
Date:   Thu, 19 Apr 2018 10:17:09 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/7] Deprecate .git/info/grafts
In-Reply-To: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VwsyR07ghPIPnrRUCWy2xDOYa3UY8Ufkk+Vwi/AtRgU6BqYsK1w
 zbXAgwMF0GSosj5c4xHJ5egVinBmUl4nl8Kbocc3mESkxFXMmvUhP0WGQhIqvJSiqTWArA/
 1kIqd/a6OUKvdm19v1opSvD3c6MAY5JyES7PQwtTOrZcDLbXtPKB83D1DuFZjET+r/2kYue
 0YfcZU6MDwHJ4PCnAu7bA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9hVf+3dUkFs=:rX0T27R7MDsqWEZiPeyoee
 S0A4Gh110wVhtIPeeTWl4Gi7CxUNSkFqsdGLH/ab/rQf+WlHy9x8+Oy5CsVLLmMSJpkdOihpO
 xML7FTlSc5RpBah9A/J6J++dLtUQ11VtXyHNwwZBkddF9ELS+SKXU8wXtYoTWTKRTZtsa/PXL
 9H+8QisKgOQKMkPaB/JjKfvyF4k8UrTPKZWIyq00ISo373e4MqEAdSoA9l7ZFwW0mubrJEWAj
 VzkGWB+M7NEk9aeK+W0hxuA1puuM/hRwq4VILM5Y3owy6YvoBaIUUwly5rytxgHBtTKkpDAzf
 YcV2voNu+UgzgLCyYwjbdyUwyRO5jeHZJWRr5iZmNuKpLDk2tzsXVXOtbGgi0KQ03rtETCszD
 YLhqhMBQgXL4edfwggEzgADzQbapcFTnK8pWh5kHJFUUTuJ86B71xp1mCjaT3ma/TIs6XjqHn
 muN3AlY5zhXzBJVLIa/LEzrPXLJXRfdazrL0G4G9ibhkUcsSK2SI++y6d3uSm4jurMi5/bYmz
 kZuY/1YgcyUBuSB5p/wQuNfIKISZHtIpvlaS5CkQAoUpypBnn3K/itrYLgp67IMbi4gEv1g6v
 4IaJASfQeW30t+URoD2LJ2HmDhntiE3ppoB1zjd4mhnU+dsyKpmoCNXdXAyKVCk0gBmuYowCv
 lcOnz+bUErpKA6uFfT09E5zBs2qoaSG5FYA/XZ8a5jr1pIp81So7P75zjV5lP2N87H6ZCYi2a
 7UMUF5n8rqRZiD7M5ScProp0xLqxObgo93lfpM6LRi+TGBuOnxiOFpkzbCxXD78grNKk3Fuqp
 UfbGN9E3n1lob6WphQClw+PI0B5LWVflY5IYm2ybc2ethn3RpM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is fragile, as there is no way for the revision machinery to say "but
now I want to traverse the graph ignoring the graft file" e.g. when
pushing commits to a remote repository (which, as a consequence, can
miss commits).

And we already have a better solution with `git replace --graft <comit>
[<parent>...]`.

Changes since v1:

- Fixed typo (stich -> stitch).

- Added reference in the commit message to the patch where `git replace`
  reached feature parity with the graft file.

- Added the --convert-graft-file option to `git replace` (with tests).

- Adjusted the advice to suggest --convert-graft-file instead.

- Adjusted the documentation of filter-branch and technical/shallow to
  reflect the fact that grafts are deprecated.


Johannes Schindelin (7):
  replace: "libify" create_graft()
  replace: introduce --convert-graft-file
  Add a test for `git replace --convert-graft-file`
  Deprecate support for .git/info/grafts
  filter-branch: stop suggesting to use grafts
  technical/shallow: describe the relationship with replace refs
  technical/shallow: describe why shallow cannot use replace refs

 Documentation/git-filter-branch.txt |  2 +-
 Documentation/git-replace.txt       | 11 +++--
 Documentation/technical/shallow.txt | 24 +++++++----
 advice.c                            |  2 +
 advice.h                            |  1 +
 builtin/replace.c                   | 63 ++++++++++++++++++++++++++++-
 commit.c                            | 10 +++++
 t/t6001-rev-list-graft.sh           |  9 +++++
 t/t6050-replace.sh                  | 20 +++++++++
 9 files changed, 129 insertions(+), 13 deletions(-)


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v2
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v2

Interdiff vs v1:
 diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
 index b634043183b..1d4d2f86045 100644
 --- a/Documentation/git-filter-branch.txt
 +++ b/Documentation/git-filter-branch.txt
 @@ -288,7 +288,7 @@ git filter-branch --parent-filter \
  or even simpler:
  
  -----------------------------------------------
 -echo "$commit-id $graft-id" >> .git/info/grafts
 +git replace --graft $commit-id $graft-id
  git filter-branch $graft-id..HEAD
  -----------------------------------------------
  
 diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
 index e5c57ae6ef4..4dc0686f7d6 100644
 --- a/Documentation/git-replace.txt
 +++ b/Documentation/git-replace.txt
 @@ -11,6 +11,7 @@ SYNOPSIS
  'git replace' [-f] <object> <replacement>
  'git replace' [-f] --edit <object>
  'git replace' [-f] --graft <commit> [<parent>...]
 +'git replace' [-f] --convert-graft-file
  'git replace' -d <object>...
  'git replace' [--format=<format>] [-l [<pattern>]]
  
 @@ -87,9 +88,13 @@ OPTIONS
  	content as <commit> except that its parents will be
  	[<parent>...] instead of <commit>'s parents. A replacement ref
  	is then created to replace <commit> with the newly created
 -	commit. See contrib/convert-grafts-to-replace-refs.sh for an
 -	example script based on this option that can convert grafts to
 -	replace refs.
 +	commit. Use `--convert-graft-file` to convert a
 +	`$GIT_DIR/info/grafts` file use replace refs instead.
 +
 +--convert-graft-file::
 +	Creates graft commits for all entries in `$GIT_DIR/info/grafts`
 +	and deletes that file upon success. The purpose is to help users
 +	with transitioning off of the now-deprecated graft file.
  
  -l <pattern>::
  --list <pattern>::
 diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
 index 5183b154229..cb79181c2bb 100644
 --- a/Documentation/technical/shallow.txt
 +++ b/Documentation/technical/shallow.txt
 @@ -9,19 +9,29 @@ these commits have no parents.
  *********************************************************
  
  The basic idea is to write the SHA-1s of shallow commits into
 -$GIT_DIR/shallow, and handle its contents like the contents
 -of $GIT_DIR/info/grafts (with the difference that shallow
 -cannot contain parent information).
 +$GIT_DIR/shallow, and handle its contents similar to replace
 +refs (with the difference that shallow does not actually
 +create those replace refs) and very much like the deprecated
 +graft file (with the difference that shallow commits will
 +always have their parents grafted away, not replaced by
 +different parents).
  
 -This information is stored in a new file instead of grafts, or
 -even the config, since the user should not touch that file
 -at all (even throughout development of the shallow clone, it
 -was never manually edited!).
 +This information is stored in a special-purpose file because the
 +user should not touch that file at all (even throughout
 +development of the shallow clone, it was never manually
 +edited!).
  
  Each line contains exactly one SHA-1. When read, a commit_graft
  will be constructed, which has nr_parent < 0 to make it easier
  to discern from user provided grafts.
  
 +Note that the shallow feature could not be changed easily to
 +use replace refs: a commit containing a `mergetag` is not allowed
 +to be replaced, not even by a root commit. Such a commit can be
 +made shallow, though. Also, having a `shallow` file explicitly
 +listing all the commits made shallow makes it a *lot* easier to
 +do shallow-specific things such as to deepen the history.
 +
  Since fsck-objects relies on the library to read the objects,
  it honours shallow commits automatically.
  
 diff --git a/builtin/replace.c b/builtin/replace.c
 index 935647be6bd..4cdc00a96df 100644
 --- a/builtin/replace.c
 +++ b/builtin/replace.c
 @@ -20,6 +20,7 @@ static const char * const git_replace_usage[] = {
  	N_("git replace [-f] <object> <replacement>"),
  	N_("git replace [-f] --edit <object>"),
  	N_("git replace [-f] --graft <commit> [<parent>...]"),
 +	N_("git replace [-f] --convert-graft-file"),
  	N_("git replace -d <object>..."),
  	N_("git replace [--format=<format>] [-l [<pattern>]]"),
  	NULL
 @@ -395,7 +396,9 @@ static int create_graft(int argc, const char **argv, int force)
  
  	if (get_oid(old_ref, &old_oid) < 0)
  		die(_("Not a valid object name: '%s'"), old_ref);
 -	commit = lookup_commit_or_die(&old_oid, old_ref);
 +	commit = lookup_commit_reference(&old_oid);
 +	if (!commit)
 +		return error(_("could not parse %s"), old_ref);
  
  	buffer = get_commit_buffer(commit, &size);
  	strbuf_add(&buf, buffer, size);
 @@ -421,6 +424,53 @@ static int create_graft(int argc, const char **argv, int force)
  	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
  }
  
 +static int convert_graft_file(int force)
 +{
 +	const char *graft_file = get_graft_file();
 +	FILE *fp = fopen_or_warn(graft_file, "r");
 +	struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
 +	struct argv_array args = ARGV_ARRAY_INIT;
 +
 +	if (!fp)
 +		return -1;
 +
 +	while (strbuf_getline(&buf, fp) != EOF) {
 +		int i = 0, j;
 +
 +		while (i != buf.len) {
 +			char save;
 +
 +			for (j = i; j < buf.len && !isspace(buf.buf[j]); j++)
 +				; /* look further */
 +			save = buf.buf[j];
 +			buf.buf[j] = '\0';
 +			argv_array_push(&args, buf.buf + i);
 +			buf.buf[j] = save;
 +
 +			while (j < buf.len && isspace(buf.buf[j]))
 +				j++;
 +			i = j;
 +		}
 +
 +		if (create_graft(args.argc, args.argv, force))
 +			strbuf_addf(&err, "\n\t%s", buf.buf);
 +
 +		argv_array_clear(&args);
 +		strbuf_reset(&buf);
 +	}
 +
 +	strbuf_release(&buf);
 +	argv_array_clear(&args);
 +
 +	if (!err.len)
 +		return unlink_or_warn(graft_file);
 +
 +	warning(_("could not convert the following graft(s):\n%s"), err.buf);
 +	strbuf_release(&err);
 +
 +	return -1;
 +}
 +
  int cmd_replace(int argc, const char **argv, const char *prefix)
  {
  	int force = 0;
 @@ -432,6 +482,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  		MODE_DELETE,
  		MODE_EDIT,
  		MODE_GRAFT,
 +		MODE_CONVERT_GRAFT_FILE,
  		MODE_REPLACE
  	} cmdmode = MODE_UNSPECIFIED;
  	struct option options[] = {
 @@ -439,6 +490,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
  		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
  		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
 +		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
  		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
  			   PARSE_OPT_NOCOMPLETE),
  		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
 @@ -461,7 +513,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  	if (force &&
  	    cmdmode != MODE_REPLACE &&
  	    cmdmode != MODE_EDIT &&
 -	    cmdmode != MODE_GRAFT)
 +	    cmdmode != MODE_GRAFT &&
 +	    cmdmode != MODE_CONVERT_GRAFT_FILE)
  		usage_msg_opt("-f only makes sense when writing a replacement",
  			      git_replace_usage, options);
  
 @@ -494,6 +547,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  				      git_replace_usage, options);
  		return create_graft(argc, argv, force);
  
 +	case MODE_CONVERT_GRAFT_FILE:
 +		if (argc != 0)
 +			usage_msg_opt("--convert-graft-file takes no argument",
 +				      git_replace_usage, options);
 +		return !!convert_graft_file(force);
 +
  	case MODE_LIST:
  		if (argc > 1)
  			usage_msg_opt("only one pattern can be given with -l",
 diff --git a/commit.c b/commit.c
 index a96b0a27154..1a5e8777617 100644
 --- a/commit.c
 +++ b/commit.c
 @@ -181,7 +181,8 @@ static int read_graft_file(const char *graft_file)
  		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
  			 "and will be removed in a future Git version.\n"
  			 "\n"
 -			 "Please use \"git replace --graft [...]\" instead.\n"
 +			 "Please use \"git replace --convert-graft-file\"\n"
 +			 "to convert the grafts into replace refs.\n"
  			 "\n"
  			 "Turn this message off by running\n"
  			 "\"git config advice.graftFileDeprecated false\""));
 diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
 index c630aba657e..77ded6df653 100755
 --- a/t/t6050-replace.sh
 +++ b/t/t6050-replace.sh
 @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
  	git replace -d $HASH10
  '
  
 +test_expect_success '--convert-graft-file' '
 +	: add and convert graft file &&
 +	printf "%s\n%s %s\n%s\n" \
 +		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
 +		>.git/info/grafts &&
 +	git replace --convert-graft-file &&
 +	test_path_is_missing .git/info/grafts &&
 +
 +	: verify that the history is now "grafted" &&
 +	git rev-list HEAD >out &&
 +	test_line_count = 4 out &&
 +
 +	: create invalid graft file and verify that it is not deleted &&
 +	test_when_finished "rm -f .git/info/grafts" &&
 +	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
 +	test_must_fail git replace --convert-graft-file 2>err &&
 +	grep "$EMPTY_BLOB $EMPTY_TREE" err &&
 +	grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
 +'
 +
  test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3

