Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425B0205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbdABQQ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:16:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:60880 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbdABQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:16:56 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbMb0-1clpRc0zZy-00kwya; Mon, 02
 Jan 2017 17:16:46 +0100
Date:   Mon, 2 Jan 2017 17:16:44 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH v4 0/4] Show Git Mailing List: a builtin difftool
In-Reply-To: <cover.1480019834.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1483373635.git.johannes.schindelin@gmx.de>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1IYK8HBD9XDXj90o/Xbiqvg4s4kN6uRFcp2+A3vyEg9Qrks+UIO
 4XSorIGQJ3Bigj6Xlf/vzbWEYxsVAam7n9JqbjlOW5HhQYeCYiu+uizkD7mOTvmsJfCVLLK
 UDvlxnK1EjHZEk0C4gDk+zowQHWlQpytw+4ezslyS+Aun6MsqXINoSL61wBbyOSFYb9mFvw
 izGATJ1T2+cRNBlK3J3JQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oahl7OoBT9U=:ocGPGlJ1/GNNXECtuBpTHG
 s8kS2ogY1g+f9Z8tH8i5q0+CDmC4p0VxNXOx2g8/RJLPDVgE10e35nEwu+5CEzdpUzcE7cLUV
 zGmjMHSC3wQZrh4RQD+H5qA7yo4cIKoy15a++gjnrF/2GchLM39gTUYtp4Un/8Uh7lMEnMikt
 uSk+koJlCedzk9fh5ykcx4lfuIgu3kQcGgReacnGfrg0hrMH9SPeR/pu3baEHRvNEGIPE9rIe
 NBq8yN0Ufq1MCRxDl5AjdpbA1P5jl5MZRX+UZUKFTcWNcmRzT991CVkM8AJ7TKMBUNANKsXAM
 V8GDpIlw4khGUJZ26LVmJVNh2msC749f5/2CS6Ui3Rf05rCnom+/gPeQbAOsMATXLpkcwIsFO
 9CkVRuelCT/q06zB6BiXZZ2Y/vJG78Q2ImWESPAwsRdi0havdE4RkmC8EgxGLvgNiJkZLMxHa
 PBiu5CMgD/83v9OLDZ9BsPol6/MEz3Tt88FPD6ynMdWYIfidxWLnH8a9FEQlfDjAbSQtkX3/3
 NZmmAT0uGgK4eV7tIrOvmhQMCJMDpIUA3m91yEtnAaKziq+eHrmtOb9/sP5eCaoArvV+ZD7Bv
 4iBjfc1vDXI3SdlYDR69fdjNLZs5dQHAbYv4LGTECEUkuW7zipgkZvfTQFrdvQmrLGYOAcoY1
 F4dp3QWC5Td9d79rwew0LwpY56po9cYg4O5Lz8dEOoU0hkNtR2eSPO0efGr/vUrRmmUsXSOew
 2Jfk0wt2HYPhwB0U64iOG5U3WapFgJ6SIv1YZAiRjnKup4Rk/gHINp6QnBqiHuZ+3oSm0Gyxv
 qjBUk9HYvo2+g75XERVDF51j/708VuOaP1A9mbw0+I4pBjU5LXatEhJznIlQ4zI7rC1sbg54Q
 hcGZCRpddtX77rG+6V0fmhTmqy0BAKMUAARzJV7eKlPDsoNO+QT1yl0fjXoCiW0bX2jQQHMrf
 n8xcovak2ZKrwah5bAD2/EPzWmYojLCxPDIzN3GqJFnKx7S63dJYN0MFpOygaDLf8cuA4IJh2
 JacBIGBSVfDUnXOwwcvkPVql1EMZDKPczbBQRAiTzKd/IfAK0EhTFlbVH6I3O9iK1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been working on the builtin difftool for a while now, for two
reasons:

1. Perl is really not native on Windows. Not only is there a performance
   penalty to be paid just for running Perl scripts, we also have to deal
   with the fact that users may have different Perl installations, with
   different options, and some other Perl installation may decide to set
   PERL5LIB globally, wreaking havoc with Git for Windows' Perl (which we
   have to use because almost all other Perl distributions lack the
   Subversion bindings we need for `git svn`).

2. Perl makes for a rather large reason that Git for Windows' installer
   weighs in with >30MB. While one Perl script less does not relieve us
   of that burden, it is one step in the right direction.

Changes since v3:

- made path_entry_cmp static

- fixed a few bugs identified by Coverity

- fixed overzealous status parsing that did not expect any number after
  C or R


Johannes Schindelin (4):
  Avoid Coverity warning about unfree()d git_exec_path()
  difftool: add a skeleton for the upcoming builtin
  difftool: implement the functionality in the builtin
  t7800: run both builtin and scripted difftool, for now

 .gitignore                                    |   1 +
 Makefile                                      |   3 +-
 builtin.h                                     |   1 +
 builtin/difftool.c                            | 733 ++++++++++++++++++++++++++
 exec_cmd.c                                    |   5 +-
 git-difftool.perl => git-legacy-difftool.perl |   0
 git.c                                         |   6 +
 t/t7800-difftool.sh                           |  29 +
 8 files changed, 776 insertions(+), 2 deletions(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => git-legacy-difftool.perl (100%)


base-commit: e05806da9ec4aff8adfed142ab2a2b3b02e33c8c
Published-As: https://github.com/dscho/git/releases/tag/builtin-difftool-v4
Fetch-It-Via: git fetch https://github.com/dscho/git builtin-difftool-v4

Interdiff vs v3:

 diff --git a/builtin/difftool.c b/builtin/difftool.c
 index 3480920fea..2115e548a5 100644
 --- a/builtin/difftool.c
 +++ b/builtin/difftool.c
 @@ -73,8 +73,10 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
  	if (*p != ' ')
  		return error("expected ' ', got '%c'", *p);
  	*status = *++p;
 -	if (!status || p[1])
 -		return error("unexpected trailer: '%s'", p);
 +	if (!*status)
 +		return error("missing status");
 +	if (p[1] && !isdigit(p[1]))
 +		return error("unexpected trailer: '%s'", p + 1);
  	return 0;
  }
  
 @@ -107,7 +109,8 @@ static int use_wt_file(const char *workdir, const char *name,
  		struct object_id wt_oid;
  		int fd = open(buf.buf, O_RDONLY);
  
 -		if (!index_fd(wt_oid.hash, fd, &st, OBJ_BLOB, name, 0)) {
 +		if (fd >= 0 &&
 +		    !index_fd(wt_oid.hash, fd, &st, OBJ_BLOB, name, 0)) {
  			if (is_null_oid(oid)) {
  				oidcpy(oid, &wt_oid);
  				use = 1;
 @@ -162,7 +165,7 @@ static void add_left_or_right(struct hashmap *map, const char *path,
  		e->left[0] = e->right[0] = '\0';
  		hashmap_add(map, e);
  	}
 -	strcpy(is_right ? e->right : e->left, content);
 +	strlcpy(is_right ? e->right : e->left, content, PATH_MAX);
  }
  
  struct path_entry {
 @@ -170,7 +173,7 @@ struct path_entry {
  	char path[FLEX_ARRAY];
  };
  
 -int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
 +static int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
  {
  	return strcmp(a->path, key ? key : b->path);
  }
 @@ -423,17 +426,16 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
  				struct cache_entry *ce2 =
  					make_cache_entry(rmode, roid.hash,
  							 dst_path, 0, 0);
 -				ce_mode_from_stat(ce2, rmode);
  
  				add_index_entry(&wtindex, ce2,
  						ADD_CACHE_JUST_APPEND);
  
 -				add_path(&wtdir, wtdir_len, dst_path);
  				add_path(&rdir, rdir_len, dst_path);
  				if (ensure_leading_directories(rdir.buf))
  					return error("could not create "
  						     "directory for '%s'",
  						     dst_path);
 +				add_path(&wtdir, wtdir_len, dst_path);
  				if (symlinks) {
  					if (symlink(wtdir.buf, rdir.buf)) {
  						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
 diff --git a/exec_cmd.c b/exec_cmd.c
 index 19ac2146d0..587bd7eb48 100644
 --- a/exec_cmd.c
 +++ b/exec_cmd.c
 @@ -65,6 +65,7 @@ void git_set_argv_exec_path(const char *exec_path)
  const char *git_exec_path(void)
  {
  	const char *env;
 +	static char *system_exec_path;
  
  	if (argv_exec_path)
  		return argv_exec_path;
 @@ -74,7 +75,9 @@ const char *git_exec_path(void)
  		return env;
  	}
  
 -	return system_path(GIT_EXEC_PATH);
 +	if (!system_exec_path)
 +		system_exec_path = system_path(GIT_EXEC_PATH);
 +	return system_exec_path;
  }
  
  static void add_path(struct strbuf *out, const char *path)
 diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
 index e94910c563..273ab55723 100755
 --- a/t/t7800-difftool.sh
 +++ b/t/t7800-difftool.sh
 @@ -23,6 +23,20 @@ prompt_given ()
  	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
  }
  
 +for use_builtin_difftool in false true
 +do
 +
 +test_expect_success 'verify we are running the correct difftool' '
 +	if test true = '$use_builtin_difftool'
 +	then
 +		test_must_fail ok=129 git difftool -h >help &&
 +		grep "g, --gui" help
 +	else
 +		git difftool -h >help &&
 +		grep "g|--gui" help
 +	fi
 +'
 +
  # NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.
  
  # Create a file on master and change it on branch
 @@ -606,4 +620,17 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
  	)
  '
  
 +test true != $use_builtin_difftool || break
 +
 +test_expect_success 'tear down for re-run' '
 +	rm -rf * .[a-z]* &&
 +	git init
 +'
 +
 +# run as builtin difftool now
 +GIT_CONFIG_PARAMETERS="'difftool.usebuiltin=true'"
 +export GIT_CONFIG_PARAMETERS
 +
 +done
 +
  test_done

-- 
2.11.0.rc3.windows.1

