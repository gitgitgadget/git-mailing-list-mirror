Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC59F1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbcHPIaI (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:30:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:52313 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbcHPIaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:30:05 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MBIAz-1bSBF81Fzh-00AEv2; Tue, 16 Aug 2016 10:29:55
 +0200
Date:	Tue, 16 Aug 2016 10:29:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
In-Reply-To: <xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608161026110.4924@virtualbox>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de> <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> <xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-938696117-1471336195=:4924"
X-Provags-ID: V03:K0:ctAk62eFEdfdBbMzdF//eLn1fjoOGaZ0YZIvD0enHtDiQCfHdZG
 lMp4Ok69orAufS1R/i0/i8iyDkqNF4XOvlUqvbFLjNp4kjaUeKgND06vm1EQMeNQZpNiBAS
 Zgu1b3k4kEGhUF+pC3TpiV0p8cDYpIJAyZCql/PlItuMplFLIBvxbPwaGZYeDjScjxHhjWz
 T3hEJtWuFD6trlrWkptdQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:P2BgSMHjeSM=:8DB+Dan/PV/kJZxA5loNFz
 kJpAfLow+0Ni/o6XLpF3dL5kAGMj8WW3FDJoGYL2ARfZXO5b5R87xRBdU3rEkele9VywpVmms
 KlxrD1IVDe59yA4ZthFUk0+9jhj4n62DmYd9aMiUJJvXO2/UnV/mDTF4an1kGBFgYS0fgNjPD
 hwahy0ydZ/cQ+8rfGqwMks4BGkII238udGy83YU6zR0+fI+rMQ6aQAJg3b8yvITzifftGw0YA
 j91VKagz7au39Rg4lcrH9FCyh9YrcueftKA4SaFeKA6rj9ey8q0d9M5ng1eWzeg3rNLniE/CW
 gwrq+IiLkapBWwZecloLYKhCbqrtbe6uWAGrMghDax7zT1LYPgLyk/YO+0GhXDm6lKRIuYV3J
 s1P5usxyD0cz+Ntlc8mROXrgaaeooKBF8AJd6rNo6QkJuFQzea6hIqpt/64arGvvGV3tbui2i
 K8Hy81idTyBXk+fyhW+5w0nn4NuQ+O/BK5IM7sPU30nGn0r8mKgCNi8AN5zVr90yeBWZatD4w
 u7VhSykmzC85MIJi1UeS+KGGxctxn8Dj8SEI+zSzbQKKzQ64WneLM4GjQTo5anJKmSkYsYGnv
 fFiavF7FsGnVG/GOPReY0etZUZMHH62M7fK0s08YnF8v3nx8SOvAxaTIPKCTpiy3g+ufRSxyW
 4cdDcDutlUjJobUdyzXXdd5UOjtcj6G2osAY3RB6JrxHZaZiOfTmrhF07CI2mbtZ2t2IPYzv3
 mUxEo8+KMvj5WAMICoWUpttQwvTUJIZGf1nJMfZNJnmEe6YDRAvDRKEDkyEU5/QA8EAkUAsmD
 ZLrfVVM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-938696117-1471336195=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 15 Aug 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >> +test-lint-filenames:
> >> +=09@illegal=3D"$$(git ls-files | grep '["*:<>?\\|]')"; \
> >
> > This pattern must exclude questionables on either NTFS or HFS+; it
> > is ironic that it is not even sufficient to limit ourselves to the
> > Portable Character Set [*1*], but such is life.
> >
> > By the way, doesn't ls-files take pathspec glob, saving one extra
> > process to run grep?

I specifically did not do that, sorry for omitting the rationale from the
commit message. The reason why I have that grep is so that the backslash
can also catch non-ASCII characters, such as "Hell=C3=B6-J=C3=BCni=C3=B6".

> One more thing you may want to exclude is HT.  Here is a suggested
> reroll.  I reworded to avoid a subjective "truly platform-independent",
> which is not what we intend to aim for anyway (we only try to support
> the platforms we care about).

Unfortunately, this version (actually, the version of `pu`, which I
assume is identical) does not work correctly:

$ make test-lint
do not use non-portable file name(s): Git-SVN/00compile.t
Git-SVN/Utils/add_path_to_url.t
Git-SVN/Utils/can_compress.t
Git-SVN/Utils/canonicalize_url.t
Git-SVN/Utils/collapse_dotdot.t
Git-SVN/Utils/fatal.t
Git-SVN/Utils/join_paths.t
diff-lib/COPYING
diff-lib/README
helper/.gitignore
helper/test-chmtime.c
helper/test-config.c
helper/test-ctype.c
helper/test-date.c
helper/test-delta.c
helper/test-dump-cache-tree.c
helper/test-dump-split-index.c
helper/test-dump-untracked-cache.c
helper/test-dump-watchman.c
helper/test-fake-ssh.c
helper/test-genrandom.c
helper/test-hashmap.c
helper/test-index-version.c
helper/test-line-buffer.c
helper/test-match-trees.c
helper/test-mergesort.c
helper/test-mktemp.c
helper/test-parse-options.c
helper/test-path-utils.c
helper/test-prio-queue.c
helper/test-read-cache.c
helper/test-regex.c
helper/test-revision-walking.c
helper/test-run-command.c
helper/test-scrap-cache-tree.c
helper/test-sha1-array.c
helper/test-sha1.c
helper/test-sha1.sh
helper/test-sigchain.c
helper/test-string-list.c
helper/test-submodule-config.c
helper/test-subprocess.c
helper/test-svn-fe.c
helper/test-urlmatch-normalization.c
helper/test-wildmatch.c
lib-gpg/keyring.gpg
lib-gpg/ownertrust
lib-httpd/apache.conf
lib-httpd/broken-smart-http.sh
lib-httpd/error.sh
lib-httpd/passwd
lib-httpd/ssl.cnf
perf/.gitignore
perf/Makefile
perf/README
perf/aggregate.perl
perf/min_time.perl
perf/p0000-perf-lib-sanity.sh
perf/p0001-rev-list.sh
perf/p0002-read-cache.sh
perf/p3400-rebase.sh
perf/p3404-rebase-interactive.sh
perf/p4000-diff-algorithms.sh
perf/p4001-diff-no-index.sh
perf/p4211-line-log.sh
perf/p5302-pack-index.sh
perf/p5303-many-packs.sh
perf/p5310-pack-bitmaps.sh
perf/p7000-filter-branch.sh
perf/p7300-clean.sh
perf/p7810-grep.sh
perf/perf-lib.sh
perf/run
t0110/README
t0110/url-1
t0110/url-10
t0110/url-11
t0110/url-2
t0110/url-3
t0110/url-4
t0110/url-5
t0110/url-6
t0110/url-7
t0110/url-8
t0110/url-9
t0200/test.c
t0200/test.perl
t0200/test.sh
t0202/test.pl
t1509/excludes
t1509/prepare-chroot.sh
t3900/1-UTF-8.txt
t3900/2-UTF-8.txt
t3900/ISO-2022-JP.txt
t3900/ISO8859-1.txt
t3900/UTF-16.txt
t3900/eucJP.txt
t4013/diff.config_format.subjectprefix_DIFFERENT_PREFIX
t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
t4013/diff.diff-tree_--cc_--patch-with-stat_master
t4013/diff.diff-tree_--cc_--stat_--summary_master
t4013/diff.diff-tree_--cc_--stat_--summary_side
t4013/diff.diff-tree_--cc_--stat_master
t4013/diff.diff-tree_--cc_master
t4013/diff.diff-tree_--patch-with-raw_initial
t4013/diff.diff-tree_--patch-with-stat_initial
t4013/diff.diff-tree_--pretty=3Doneline_--patch-with-raw_initial
t4013/diff.diff-tree_--pretty=3Doneline_--patch-with-stat_initial
t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-raw_initial
t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-stat_initial
t4013/diff.diff-tree_--pretty=3Doneline_--root_-p_initial
t4013/diff.diff-tree_--pretty=3Doneline_--root_initial
t4013/diff.diff-tree_--pretty=3Doneline_-p_initial
t4013/diff.diff-tree_--pretty=3Doneline_initial
t4013/diff.diff-tree_--pretty_--patch-with-raw_initial
t4013/diff.diff-tree_--pretty_--patch-with-stat_initial
t4013/diff.diff-tree_--pretty_--patch-with-stat_side
t4013/diff.diff-tree_--pretty_--root_--patch-with-raw_initial
t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
t4013/diff.diff-tree_--pretty_--root_--stat_initial
t4013/diff.diff-tree_--pretty_--root_--summary_-r_initial
t4013/diff.diff-tree_--pretty_--root_--summary_initial
t4013/diff.diff-tree_--pretty_--root_-p_initial
t4013/diff.diff-tree_--pretty_--root_initial
t4013/diff.diff-tree_--pretty_--stat_--summary_initial
t4013/diff.diff-tree_--pretty_--stat_initial
t4013/diff.diff-tree_--pretty_--summary_initial
t4013/diff.diff-tree_--pretty_-p_initial
t4013/diff.diff-tree_--pretty_-p_side
t4013/diff.diff-tree_--pretty_initial
t4013/diff.diff-tree_--pretty_side
t4013/diff.diff-tree_--root_--abbrev_initial
t4013/diff.diff-tree_--root_--patch-with-raw_initial
t4013/diff.diff-tree_--root_--patch-with-stat_initial
t4013/diff.diff-tree_--root_-p_initial
t4013/diff.diff-tree_--root_-r_--abbrev=3D4_initial
t4013/diff.diff-tree_--root_-r_--abbrev_initial
t4013/diff.diff-tree_--root_-r_initial
t4013/diff.diff-tree_--root_initial
t4013/diff.diff-tree_-c_--abbrev_master
t4013/diff.diff-tree_-c_--stat_--summary_master
t4013/diff.diff-tree_-c_--stat_--summary_side
t4013/diff.diff-tree_-c_--stat_master
t4013/diff.diff-tree_-c_master
t4013/diff.diff-tree_-p_-m_master
t4013/diff.diff-tree_-p_initial
t4013/diff.diff-tree_-p_master
t4013/diff.diff-tree_-r_--abbrev=3D4_initial
t4013/diff.diff-tree_-r_--abbrev_initial
t4013/diff.diff-tree_-r_initial
t4013/diff.diff-tree_initial
t4013/diff.diff-tree_master
t4013/diff.diff_--abbrev_initial..side
t4013/diff.diff_--cached
t4013/diff.diff_--cached_--_file0
t4013/diff.diff_--dirstat-by-file_initial_rearrange
t4013/diff.diff_--dirstat_initial_rearrange
t4013/diff.diff_--dirstat_master~1_master~2
t4013/diff.diff_--name-status_dir2_dir
t4013/diff.diff_--no-index_--name-status_--_dir2_dir
t4013/diff.diff_--no-index_--name-status_dir2_dir
t4013/diff.diff_--no-index_dir_dir3
t4013/diff.diff_--patch-with-raw_-r_initial..side
t4013/diff.diff_--patch-with-raw_initial..side
t4013/diff.diff_--patch-with-stat_-r_initial..side
t4013/diff.diff_--patch-with-stat_initial..side
t4013/diff.diff_--stat_initial..side
t4013/diff.diff_-r_--stat_initial..side
t4013/diff.diff_-r_initial..side
t4013/diff.diff_initial..side
t4013/diff.diff_master_master^_side
t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_initial..side
t4013/diff.format-patch_--attach_--stdout_initial..master
t4013/diff.format-patch_--attach_--stdout_initial..master^
t4013/diff.format-patch_--attach_--stdout_initial..side
t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTESTCASE_initi=
al..master
t4013/diff.format-patch_--inline_--stdout_initial..master
t4013/diff.format-patch_--inline_--stdout_initial..master^
t4013/diff.format-patch_--inline_--stdout_initial..master^^
t4013/diff.format-patch_--inline_--stdout_initial..side
t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
t4013/diff.format-patch_--stdout_--no-numbered_initial..master
t4013/diff.format-patch_--stdout_--numbered_initial..master
t4013/diff.format-patch_--stdout_initial..master
t4013/diff.format-patch_--stdout_initial..master^
t4013/diff.format-patch_--stdout_initial..side
t4013/diff.log_--decorate=3Dfull_--all
t4013/diff.log_--decorate_--all
t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
t4013/diff.log_--patch-with-stat_master
t4013/diff.log_--patch-with-stat_master_--_dir_
t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
t4013/diff.log_--root_--patch-with-stat_--summary_master
t4013/diff.log_--root_--patch-with-stat_master
t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
t4013/diff.log_--root_-p_master
t4013/diff.log_--root_master
t4013/diff.log_-GF_-p_--pickaxe-all_master
t4013/diff.log_-GF_-p_master
t4013/diff.log_-GF_master
t4013/diff.log_-SF_-p_master
t4013/diff.log_-SF_master
t4013/diff.log_-SF_master_--max-count=3D0
t4013/diff.log_-SF_master_--max-count=3D1
t4013/diff.log_-SF_master_--max-count=3D2
t4013/diff.log_-S_F_master
t4013/diff.log_-m_-p_--first-parent_master
t4013/diff.log_-m_-p_master
t4013/diff.log_-p_--first-parent_master
t4013/diff.log_-p_master
t4013/diff.log_master
t4013/diff.rev-list_--children_HEAD
t4013/diff.rev-list_--parents_HEAD
t4013/diff.show_--first-parent_master
t4013/diff.show_--patch-with-raw_side
t4013/diff.show_--patch-with-stat_--summary_side
t4013/diff.show_--patch-with-stat_side
t4013/diff.show_--root_initial
t4013/diff.show_--stat_--summary_side
t4013/diff.show_--stat_side
t4013/diff.show_-c_master
t4013/diff.show_-m_master
t4013/diff.show_initial
t4013/diff.show_master
t4013/diff.show_side
t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_
t4013/diff.whatchanged_--patch-with-stat_master
t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master
t4013/diff.whatchanged_--root_--patch-with-stat_master
t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
t4013/diff.whatchanged_--root_-p_master
t4013/diff.whatchanged_--root_master
t4013/diff.whatchanged_-SF_-p_master
t4013/diff.whatchanged_-SF_master
t4013/diff.whatchanged_-p_master
t4013/diff.whatchanged_master
t4018/README
t4018/cpp-c++-function
t4018/cpp-class-constructor
t4018/cpp-class-constructor-mem-init
t4018/cpp-class-definition
t4018/cpp-class-definition-derived
t4018/cpp-class-destructor
t4018/cpp-function-returning-global-type
t4018/cpp-function-returning-nested
t4018/cpp-function-returning-pointer
t4018/cpp-function-returning-reference
t4018/cpp-gnu-style-function
t4018/cpp-namespace-definition
t4018/cpp-operator-definition
t4018/cpp-skip-access-specifiers
t4018/cpp-skip-comment-block
t4018/cpp-skip-labels
t4018/cpp-struct-definition
t4018/cpp-struct-single-line
t4018/cpp-template-function-definition
t4018/cpp-union-definition
t4018/cpp-void-c-function
t4018/css-brace-in-col-1
t4018/css-colon-eol
t4018/css-colon-selector
t4018/css-common
t4018/css-long-selector-list
t4018/css-prop-sans-indent
t4018/css-short-selector-list
t4018/css-trailing-space
t4018/custom1-pattern
t4018/custom2-match-to-end-of-line
t4018/custom3-alternation-in-pattern
t4018/fountain-scene
t4018/java-class-member-function
t4018/perl-skip-end-of-heredoc
t4018/perl-skip-forward-decl
t4018/perl-skip-sub-in-pod
t4018/perl-sub-definition
t4018/perl-sub-definition-kr-brace
t4020/diff.NUL
t4034/ada/expect
t4034/ada/post
t4034/ada/pre
t4034/bibtex/expect
t4034/bibtex/post
t4034/bibtex/pre
t4034/cpp/expect
t4034/cpp/post
t4034/cpp/pre
t4034/csharp/expect
t4034/csharp/post
t4034/csharp/pre
t4034/css/expect
t4034/css/post
t4034/css/pre
t4034/fortran/expect
t4034/fortran/post
t4034/fortran/pre
t4034/html/expect
t4034/html/post
t4034/html/pre
t4034/java/expect
t4034/java/post
t4034/java/pre
t4034/matlab/expect
t4034/matlab/post
t4034/matlab/pre
t4034/objc/expect
t4034/objc/post
t4034/objc/pre
t4034/pascal/expect
t4034/pascal/post
t4034/pascal/pre
t4034/perl/expect
t4034/perl/post
t4034/perl/pre
t4034/php/expect
t4034/php/post
t4034/php/pre
t4034/python/expect
t4034/python/post
t4034/python/pre
t4034/ruby/expect
t4034/ruby/post
t4034/ruby/pre
t4034/tex/expect
t4034/tex/post
t4034/tex/pre
t4051/appended1.c
t4051/appended2.c
t4051/dummy.c
t4051/hello.c
t4051/includes.c
t4100/t-apply-1.expect
t4100/t-apply-1.patch
t4100/t-apply-2.expect
t4100/t-apply-2.patch
t4100/t-apply-3.expect
t4100/t-apply-3.patch
t4100/t-apply-4.expect
t4100/t-apply-4.patch
t4100/t-apply-5.expect
t4100/t-apply-5.patch
t4100/t-apply-6.expect
t4100/t-apply-6.patch
t4100/t-apply-7.expect
t4100/t-apply-7.patch
t4100/t-apply-8.expect
t4100/t-apply-8.patch
t4100/t-apply-9.expect
t4100/t-apply-9.patch
t4101/diff.0-1
t4101/diff.0-2
t4101/diff.0-3
t4101/diff.1-0
t4101/diff.1-2
t4101/diff.1-3
t4101/diff.2-0
t4101/diff.2-1
t4101/diff.2-3
t4101/diff.3-0
t4101/diff.3-1
t4101/diff.3-2
t4109/expect-1
t4109/expect-2
t4109/expect-3
t4109/patch1.patch
t4109/patch2.patch
t4109/patch3.patch
t4109/patch4.patch
t4110/expect
t4110/patch1.patch
t4110/patch2.patch
t4110/patch3.patch
t4110/patch4.patch
t4110/patch5.patch
t4135/.gitignore
t4135/add-plain.diff
t4135/add-with backslash.diff
t4135/add-with quote.diff
t4135/add-with spaces.diff
t4135/add-with tab.diff
t4135/damaged-tz.diff
t4135/damaged.diff
t4135/diff-plain.diff
t4135/diff-with backslash.diff
t4135/diff-with quote.diff
t4135/diff-with spaces.diff
t4135/diff-with tab.diff
t4135/funny-tz.diff
t4135/git-plain.diff
t4135/git-with backslash.diff
t4135/git-with quote.diff
t4135/git-with spaces.diff
t4135/git-with tab.diff
t4135/make-patches
t4211/expect.beginning-of-file
t4211/expect.end-of-file
t4211/expect.move-support-f
t4211/expect.multiple
t4211/expect.multiple-overlapping
t4211/expect.multiple-superset
t4211/expect.parallel-change-f-to-main
t4211/expect.simple-f
t4211/expect.simple-f-to-main
t4211/expect.simple-main
t4211/expect.simple-main-to-end
t4211/expect.two-ranges
t4211/expect.vanishes-early
t4211/history.export
t4252/am-test-1-1
t4252/am-test-1-2
t4252/am-test-2-1
t4252/am-test-2-2
t4252/am-test-3-1
t4252/am-test-3-2
t4252/am-test-4-1
t4252/am-test-4-2
t4252/am-test-5-1
t4252/am-test-5-2
t4252/am-test-6-1
t4252/file-1-0
t4252/file-2-0
t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a
t5000/huge-and-future.tar
t5000/pax.tar
t5003/infozip-symlinks.zip
t5004/empty-with-pax-header.tar
t5004/empty.zip
t5100/.gitattributes
t5100/0001mboxrd
t5100/0002mboxrd
t5100/embed-from.expect
t5100/embed-from.in
t5100/empty
t5100/info-from.expect
t5100/info-from.in
t5100/info0001
t5100/info0002
t5100/info0003
t5100/info0004
t5100/info0005
t5100/info0006
t5100/info0007
t5100/info0008
t5100/info0009
t5100/info0010
t5100/info0011
t5100/info0012
t5100/info0012--message-id
t5100/info0013
t5100/info0014
t5100/info0014--scissors
t5100/info0015
t5100/info0015--no-inbody-headers
t5100/info0016
t5100/info0016--no-inbody-headers
t5100/info0017
t5100/msg0001
t5100/msg0002
t5100/msg0003
t5100/msg0004
t5100/msg0005
t5100/msg0006
t5100/msg0007
t5100/msg0008
t5100/msg0009
t5100/msg0010
t5100/msg0011
t5100/msg0012
t5100/msg0012--message-id
t5100/msg0013
t5100/msg0014
t5100/msg0014--scissors
t5100/msg0015
t5100/msg0015--no-inbody-headers
t5100/msg0016
t5100/msg0016--no-inbody-headers
t5100/msg0017
t5100/nul-b64.expect
t5100/nul-b64.in
t5100/nul-plain
t5100/patch0001
t5100/patch0002
t5100/patch0003
t5100/patch0004
t5100/patch0005
t5100/patch0006
t5100/patch0007
t5100/patch0008
t5100/patch0009
t5100/patch0010
t5100/patch0011
t5100/patch0012
t5100/patch0012--message-id
t5100/patch0013
t5100/patch0014
t5100/patch0014--scissors
t5100/patch0015
t5100/patch0015--no-inbody-headers
t5100/patch0016
t5100/patch0016--no-inbody-headers
t5100/patch0017
t5100/quoted-from.expect
t5100/quoted-from.in
t5100/rfc2047-info-0001
t5100/rfc2047-info-0002
t5100/rfc2047-info-0003
t5100/rfc2047-info-0004
t5100/rfc2047-info-0005
t5100/rfc2047-info-0006
t5100/rfc2047-info-0007
t5100/rfc2047-info-0008
t5100/rfc2047-info-0009
t5100/rfc2047-info-0010
t5100/rfc2047-info-0011
t5100/rfc2047-samples.mbox
t5100/sample.mbox
t5100/sample.mboxrd
t5515/fetch.br-branches-default
t5515/fetch.br-branches-default-merge
t5515/fetch.br-branches-default-merge_branches-default
t5515/fetch.br-branches-default-octopus
t5515/fetch.br-branches-default-octopus_branches-default
t5515/fetch.br-branches-default_branches-default
t5515/fetch.br-branches-one
t5515/fetch.br-branches-one-merge
t5515/fetch.br-branches-one-merge_branches-one
t5515/fetch.br-branches-one-octopus
t5515/fetch.br-branches-one-octopus_branches-one
t5515/fetch.br-branches-one_branches-one
t5515/fetch.br-config-explicit
t5515/fetch.br-config-explicit-merge
t5515/fetch.br-config-explicit-merge_config-explicit
t5515/fetch.br-config-explicit-octopus
t5515/fetch.br-config-explicit-octopus_config-explicit
t5515/fetch.br-config-explicit_config-explicit
t5515/fetch.br-config-glob
t5515/fetch.br-config-glob-merge
t5515/fetch.br-config-glob-merge_config-glob
t5515/fetch.br-config-glob-octopus
t5515/fetch.br-config-glob-octopus_config-glob
t5515/fetch.br-config-glob_config-glob
t5515/fetch.br-remote-explicit
t5515/fetch.br-remote-explicit-merge
t5515/fetch.br-remote-explicit-merge_remote-explicit
t5515/fetch.br-remote-explicit-octopus
t5515/fetch.br-remote-explicit-octopus_remote-explicit
t5515/fetch.br-remote-explicit_remote-explicit
t5515/fetch.br-remote-glob
t5515/fetch.br-remote-glob-merge
t5515/fetch.br-remote-glob-merge_remote-glob
t5515/fetch.br-remote-glob-octopus
t5515/fetch.br-remote-glob-octopus_remote-glob
t5515/fetch.br-remote-glob_remote-glob
t5515/fetch.br-unconfig
t5515/fetch.br-unconfig_--tags_.._.git
t5515/fetch.br-unconfig_.._.git
t5515/fetch.br-unconfig_.._.git_one
t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
t5515/fetch.br-unconfig_.._.git_one_two
t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
t5515/fetch.br-unconfig_branches-default
t5515/fetch.br-unconfig_branches-one
t5515/fetch.br-unconfig_config-explicit
t5515/fetch.br-unconfig_config-glob
t5515/fetch.br-unconfig_remote-explicit
t5515/fetch.br-unconfig_remote-glob
t5515/fetch.master
t5515/fetch.master_--tags_.._.git
t5515/fetch.master_.._.git
t5515/fetch.master_.._.git_one
t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
t5515/fetch.master_.._.git_one_two
t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
t5515/fetch.master_branches-default
t5515/fetch.master_branches-one
t5515/fetch.master_config-explicit
t5515/fetch.master_config-glob
t5515/fetch.master_remote-explicit
t5515/fetch.master_remote-glob
t5515/refs.br-branches-default
t5515/refs.br-branches-default-merge
t5515/refs.br-branches-default-merge_branches-default
t5515/refs.br-branches-default-octopus
t5515/refs.br-branches-default-octopus_branches-default
t5515/refs.br-branches-default_branches-default
t5515/refs.br-branches-one
t5515/refs.br-branches-one-merge
t5515/refs.br-branches-one-merge_branches-one
t5515/refs.br-branches-one-octopus
t5515/refs.br-branches-one-octopus_branches-one
t5515/refs.br-branches-one_branches-one
t5515/refs.br-config-explicit
t5515/refs.br-config-explicit-merge
t5515/refs.br-config-explicit-merge_config-explicit
t5515/refs.br-config-explicit-octopus
t5515/refs.br-config-explicit-octopus_config-explicit
t5515/refs.br-config-explicit_config-explicit
t5515/refs.br-config-glob
t5515/refs.br-config-glob-merge
t5515/refs.br-config-glob-merge_config-glob
t5515/refs.br-config-glob-octopus
t5515/refs.br-config-glob-octopus_config-glob
t5515/refs.br-config-glob_config-glob
t5515/refs.br-remote-explicit
t5515/refs.br-remote-explicit-merge
t5515/refs.br-remote-explicit-merge_remote-explicit
t5515/refs.br-remote-explicit-octopus
t5515/refs.br-remote-explicit-octopus_remote-explicit
t5515/refs.br-remote-explicit_remote-explicit
t5515/refs.br-remote-glob
t5515/refs.br-remote-glob-merge
t5515/refs.br-remote-glob-merge_remote-glob
t5515/refs.br-remote-glob-octopus
t5515/refs.br-remote-glob-octopus_remote-glob
t5515/refs.br-remote-glob_remote-glob
t5515/refs.br-unconfig
t5515/refs.br-unconfig_--tags_.._.git
t5515/refs.br-unconfig_.._.git
t5515/refs.br-unconfig_.._.git_one
t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
t5515/refs.br-unconfig_.._.git_one_two
t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
t5515/refs.br-unconfig_branches-default
t5515/refs.br-unconfig_branches-one
t5515/refs.br-unconfig_config-explicit
t5515/refs.br-unconfig_config-glob
t5515/refs.br-unconfig_remote-explicit
t5515/refs.br-unconfig_remote-glob
t5515/refs.master
t5515/refs.master_--tags_.._.git
t5515/refs.master_.._.git
t5515/refs.master_.._.git_one
t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file
t5515/refs.master_.._.git_one_two
t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file
t5515/refs.master_.._.git_tag_tag-one_tag_tag-three
t5515/refs.master_branches-default
t5515/refs.master_branches-one
t5515/refs.master_config-explicit
t5515/refs.master_config-glob
t5515/refs.master_remote-explicit
t5515/refs.master_remote-glob
t7500/add-comments
t7500/add-content
t7500/add-content-and-comment
t7500/add-signed-off
t7500/add-whitespaced-content
t7500/edit-content
t8005/euc-japan.txt
t8005/sjis.txt
t8005/utf8.txt
t9000/test.pl
t9110/svm.dump
t9111/svnsync.dump
t9115/funky-names.dump
t9121/renamed-dir.dump
t9126/follow-deleted-readded.dump
t9135/svn.dump
t9136/svn.dump
t9150/make-svk-dump
t9150/svk-merge.dump
t9151/.gitignore
t9151/make-svnmerge-dump
t9151/svn-mergeinfo.dump
t9153/svn.dump
t9154/svn.dump
t9161/branches.dump
t9601/cvsroot/.gitattributes
t9601/cvsroot/CVSROOT/.gitignore
t9601/cvsroot/module/added-imported.txt,v
t9601/cvsroot/module/imported-anonymously.txt,v
t9601/cvsroot/module/imported-modified-imported.txt,v
t9601/cvsroot/module/imported-modified.txt,v
t9601/cvsroot/module/imported-once.txt,v
t9601/cvsroot/module/imported-twice.txt,v
t9602/README
t9602/cvsroot/.gitattributes
t9602/cvsroot/CVSROOT/.gitignore
t9602/cvsroot/module/default,v
t9602/cvsroot/module/sub1/default,v
t9602/cvsroot/module/sub1/subsubA/default,v
t9602/cvsroot/module/sub1/subsubB/default,v
t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
t9602/cvsroot/module/sub2/default,v
t9602/cvsroot/module/sub2/subsubA/default,v
t9602/cvsroot/module/sub3/default,v
t9603/cvsroot/.gitattributes
t9603/cvsroot/CVSROOT/.gitignore
t9603/cvsroot/module/a,v
t9603/cvsroot/module/b,v
t9604/cvsroot/.gitattributes
t9604/cvsroot/CVSROOT/.gitignore
t9604/cvsroot/module/a,v
t9700/test.pl
valgrind/.gitignore
valgrind/analyze.sh
valgrind/default.supp
valgrind/valgrind.sh
make: *** [Makefile:72: test-lint-filenames] Error 1

As a consequence, my two `pu`-based CI jobs failed to run even one
regression test.

Ciao,
Dscho
--8323329-938696117-1471336195=:4924--
