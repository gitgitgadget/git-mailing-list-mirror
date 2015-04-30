From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Thu, 30 Apr 2015 10:00:14 +0200
Message-ID: <5541E10E.6070606@drmicha.warpmail.net>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com> <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Koosha Khajehmoogahi <koosha@posteo.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	=?ISO-8859-15?Q?Nguye=5E=7En_Th=E1i_Ngo=2Ec_Duy?= 
	<pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?ISO-8859-15?Q?Jakub_Nare=3Bbski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 10:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnjOR-0000Jn-PN
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 10:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbbD3IAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 04:00:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38472 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779AbbD3IAR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 04:00:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id BB4C620F01
	for <git@vger.kernel.org>; Thu, 30 Apr 2015 04:00:16 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 30 Apr 2015 04:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=D2Pip+wyMnvf61Qcd3anQRwS4BY=; b=Fm/OeT
	Hx9uiU0utP53T84Owon0EXfL9bTMQiGJ9xgpsPPZ20z+mapBgrEW2qTKpSG3EGno
	vx8aoRBp7CGp5Yt71G5cdFuxDrYH9GFGpyaqRAIhPatlix4LNM+J76IhP21qiyD1
	SDIYYJePWSCi81P3XYz8GQ/3FhE8gKin5EeOI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=D2Pip+wyMnvf61Q
	cd3anQRwS4BY=; b=THFLG8Zh1EkskXUYVl8baXVtxfz1+0q2R0kvPo9HBObjfr9
	Ezk0fpexPBeed4zU6AcMWqdKR0p6Bw8hR2gmlq9D8SN59nPxA5d29ksgiqm7jhym
	8pvRJkkvEwPfG0V/TYdQYEDaejM7gY01OKjRRuC1J5sov+LtMdXT6hXRF09E=
X-Sasl-enc: DwPpgEaq6S+lZzB47ujDA4KtXFIzyyhjjl4ppCvnPx/S 1430380816
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 67248C0001A;
	Thu, 30 Apr 2015 04:00:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268061>

Junio C Hamano venit, vidit, dixit 30.04.2015 00:42:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>> ...
> 
> There are a handful of topics that are almost there but not
> finished.  Could the topic owners and area submaintainers who are
> involved in them report their current status soonish, please, to
> help me decide to keep or discard them?
> 
> Thanks.
> 
> 
> 
>> * kk/log-merges-config (2015-04-21) 5 commits
>>  - bash-completion: add support for git-log --merges= and log.merges
>>  - t4202-log: add tests for --merges=
>>  - Documentation: add git-log --merges= option and log.merges config. var
>>  - log: honor log.merges= option
>>  - revision: add --merges={show|only|hide} option
>>
>>  "git log" (but not other commands in the "log" family) learned to
>>  pay attention to the log.merges configuration variable that can be
>>  set to "show" (the normal behaviour), "only" (hide non-merge
>>  commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
>>  can be used to override the setting from the command line.
> 
> 
> 
>> * mh/fdopen-with-retry (2015-03-06) 6 commits
>>  - buffer_fdinit(): use fdopen_with_retry()
>>  - update_info_file(): use fdopen_with_retry()
>>  - copy_to_log(): use fdopen_with_retry()
>>  - fdopen_lock_file(): use fdopen_with_retry()
>>  - SQUASH??? $gmane/264889
>>  - xfdopen(): if first attempt fails, free memory and try again
>>
>>  Various parts of the code where they call fdopen() can fail when
>>  they run out of memory; attempt to proceed by retrying the
>>  operation after freeing some resource.
> 
> 
>> * mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
>>  - t/lib-git-svn: check same httpd module dirs as lib-httpd
>>  - t/lib-httpd: load mod_unixd
>>
>>  This is the first two commits in a three-patch series $gmane/266962

Based on the replies so far, those 2 are fine, but I would amend the
commit message.

I'm still waiting on help/input for 3/3. Jeff noted that the pertaining
tests are run locally (file://) if httpd cannot be started, and that we
may care less and less about git-svn anyways. In that case we might even
scrap 2/3.

In any case, 2/3 doesn't hurt either. So, should I resend 1 and 2 with
amended commit message?

[Also, I'm being hit a by a "work/job bus" so to speak, which is why
everyting in mg/ is kind of lingering; I do recall something about stash...]

>> * jk/at-push-sha1 (2015-03-31) 6 commits
>>  - sha1_name: implement @{push} shorthand
>>  - sha1_name: refactor upstream_mark
>>  - remote.c: provide per-branch pushremote name
>>  - remote.c: hoist branch.*.remote lookup out of remote_get_1
>>  - remote.c: drop "remote" pointer from "struct branch"
>>  - remote.c: drop default_remote_name variable
>>
>>  Introduce <branch>@{push} short-hand to denote the remote-tracking
>>  branch that tracks the branch at the remote the <branch> would be
>>  pushed to.
>>
>>  Waiting for a reroll ($gmane/266573).
> 
> 
>> * pt/xdg-config-path (2015-04-12) 7 commits
>>  - path.c: remove home_config_paths()
>>  - git-config: replace use of home_config_paths()
>>  - git-commit: replace use of home_config_paths()
>>  - credential-store.c: replace home_config_paths() with xdg_config_home()
>>  - dir.c: replace home_config_paths() with xdg_config_home()
>>  - attr.c: replace home_config_paths() with xdg_config_home()
>>  - path.c: implement xdg_config_home()
>>  (this branch uses pt/credential-xdg.)
>>
>>  Seen some discussions.
>>  Waiting for a reroll ($gmane/267518).
> 
> 
>> * mh/numparse (2015-03-19) 14 commits
>>  - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
>>  - diff_opt_parse(): use convert_i() when handling "-l<num>"
>>  - opt_arg(): simplify pointer handling
>>  - opt_arg(): report errors parsing option values
>>  - opt_arg(): use convert_i() in implementation
>>  - opt_arg(): val is always non-NULL
>>  - builtin_diff(): detect errors when parsing --unified argument
>>  - handle_revision_opt(): use convert_ui() when handling "--abbrev="
>>  - strtoul_ui(), strtol_i(): remove functions
>>  - handle_revision_opt(): use convert_i() when handling "-<digit>"
>>  - handle_revision_opt(): use skip_prefix() in many places
>>  - write_subdirectory(): use convert_ui() for parsing mode
>>  - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
>>  - numparse: new module for parsing integral numbers
>>
>>  Many codepaths use unchecked use of strtol() and friends (or even
>>  worse, atoi()).  Introduce a set of wrappers that try to be more
>>  careful.
>>
>>  Waiting for a reroll ($gmane/266209).
> 
> 
> 
>> * tf/gitweb-project-listing (2015-03-19) 5 commits
>>  - gitweb: make category headings into links when they are directories
>>  - gitweb: optionally set project category from its pathname
>>  - gitweb: add a link under the search box to clear a project filter
>>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
>>  - gitweb: fix typo in man page
>>
>>  Update gitweb to make it more pleasant to deal with a hierarchical
>>  forest of repositories.
>>
>>  Any comments from those who use or have their own code in Gitweb?
> 
>> * nd/list-files (2015-02-09) 21 commits
>>  - t3080: tests for git-list-files
>>  - list-files: -M aka diff-cached
>>  - list-files -F: show submodules with the new indicator '&'
>>  - list-files: add -F/--classify
>>  - list-files: show directories as well as files
>>  - list-files: do not show duplicate cached entries
>>  - list-files: sort output and remove duplicates
>>  - list-files: add -t back
>>  - list-files: add -1 short for --no-column
>>  - list-files: add -R/--recursive short for --max-depth=-1
>>  - list-files: -u does not imply showing stages
>>  - list-files: make alias 'ls' default to 'list-files'
>>  - list-files: a user friendly version of ls-files and more
>>  - ls-files: support --max-depth
>>  - ls-files: add --column
>>  - ls-files: add --color to highlight file names
>>  - ls-files: buffer full item in strbuf before printing
>>  - ls_colors.c: highlight submodules like directories
>>  - ls_colors.c: add a function to color a file name
>>  - ls_colors.c: parse color.ls.* from config file
>>  - ls_colors.c: add $LS_COLORS parsing code
>>
>>  A new "git list-files" Porcelain command, "ls-files" with bells and
>>  whistles.
>>
>>  Reroll to base on wt-status work ($gmane/265142) has seen some
>>  positive discussions.
>>
>>  Waiting for a further polished reroll ($gmane/265534).
> 
> 
> 
>> * js/fsck-opt (2015-01-21) 19 commits
>>  - fsck: support ignoring objects in `git fsck` via fsck.skiplist
>>  - fsck: git receive-pack: support excluding objects from fsck'ing
>>  - fsck: introduce `git fsck --quick`
>>  - fsck: support demoting errors to warnings
>>  - fsck: document the new receive.fsck.* options
>>  - fsck: allow upgrading fsck warnings to errors
>>  - fsck: optionally ignore specific fsck issues completely
>>  - fsck: disallow demoting grave fsck errors to warnings
>>  - fsck: add a simple test for receive.fsck.*
>>  - fsck: make fsck_tag() warn-friendly
>>  - fsck: handle multiple authors in commits specially
>>  - fsck: make fsck_commit() warn-friendly
>>  - fsck: make fsck_ident() warn-friendly
>>  - fsck: report the ID of the error/warning
>>  - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
>>  - fsck: offer a function to demote fsck errors to warnings
>>  - fsck: provide a function to parse fsck message IDs
>>  - fsck: introduce identifiers for fsck messages
>>  - fsck: introduce fsck options
>>
>>  "fsck.warnings = <list of error tokens>" I suggested turned out to
>>  be an unpopular choice (sorry Dscho).
>>
>>  Expecting a reroll.
