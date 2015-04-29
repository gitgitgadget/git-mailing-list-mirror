From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Wed, 29 Apr 2015 15:42:57 -0700
Message-ID: <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Koosha Khajehmoogahi <koosha@posteo.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 00:43:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynah9-0000wQ-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 00:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbbD2WnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 18:43:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750937AbbD2WnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 18:43:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4E1A4DEAB;
	Wed, 29 Apr 2015 18:42:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S7IiyzaEJESVTiTOm4g45hl7+ZU=; b=aj8+y5
	UiXrs1zwpaPRWndjXi79ZgA84Qvxn3UV8+JqFbXwJHWqVR9G7UIxv6sspH73PoAs
	sQVunFipeEVYz6ZNO8Yz8MlVvULmRk1UzEfsx05scRgSqFgoLlfcYqn6RBxD/gNS
	wAnpME+fS9gU+zHi5j1yrk0XwQLM1E/j63NTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wexHqgsLvij1bDdToD6B11gzHwcjB2am
	sNh4mTae4u/NopCWHc/rSwSNQvv7EEW90TP7avnr64yuj0HDWzmFGnx7b4W3j2Fi
	THSIW0WK3ulQp4wonOE2x5fOmfjEqTcPdmxHCTrsVu7U66BWixCbwUACvIL3A9KC
	FG1UcbvZPgE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A8564DEAA;
	Wed, 29 Apr 2015 18:42:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0765A4DEA9;
	Wed, 29 Apr 2015 18:42:59 -0400 (EDT)
In-Reply-To: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Apr 2015 13:01:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15DF0EAC-EEC1-11E4-A3C7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268032>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
> ...

There are a handful of topics that are almost there but not
finished.  Could the topic owners and area submaintainers who are
involved in them report their current status soonish, please, to
help me decide to keep or discard them?

Thanks.



> * kk/log-merges-config (2015-04-21) 5 commits
>  - bash-completion: add support for git-log --merges= and log.merges
>  - t4202-log: add tests for --merges=
>  - Documentation: add git-log --merges= option and log.merges config. var
>  - log: honor log.merges= option
>  - revision: add --merges={show|only|hide} option
>
>  "git log" (but not other commands in the "log" family) learned to
>  pay attention to the log.merges configuration variable that can be
>  set to "show" (the normal behaviour), "only" (hide non-merge
>  commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
>  can be used to override the setting from the command line.



> * mh/fdopen-with-retry (2015-03-06) 6 commits
>  - buffer_fdinit(): use fdopen_with_retry()
>  - update_info_file(): use fdopen_with_retry()
>  - copy_to_log(): use fdopen_with_retry()
>  - fdopen_lock_file(): use fdopen_with_retry()
>  - SQUASH??? $gmane/264889
>  - xfdopen(): if first attempt fails, free memory and try again
>
>  Various parts of the code where they call fdopen() can fail when
>  they run out of memory; attempt to proceed by retrying the
>  operation after freeing some resource.


> * mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
>  - t/lib-git-svn: check same httpd module dirs as lib-httpd
>  - t/lib-httpd: load mod_unixd
>
>  This is the first two commits in a three-patch series $gmane/266962


> * jk/at-push-sha1 (2015-03-31) 6 commits
>  - sha1_name: implement @{push} shorthand
>  - sha1_name: refactor upstream_mark
>  - remote.c: provide per-branch pushremote name
>  - remote.c: hoist branch.*.remote lookup out of remote_get_1
>  - remote.c: drop "remote" pointer from "struct branch"
>  - remote.c: drop default_remote_name variable
>
>  Introduce <branch>@{push} short-hand to denote the remote-tracking
>  branch that tracks the branch at the remote the <branch> would be
>  pushed to.
>
>  Waiting for a reroll ($gmane/266573).


> * pt/xdg-config-path (2015-04-12) 7 commits
>  - path.c: remove home_config_paths()
>  - git-config: replace use of home_config_paths()
>  - git-commit: replace use of home_config_paths()
>  - credential-store.c: replace home_config_paths() with xdg_config_home()
>  - dir.c: replace home_config_paths() with xdg_config_home()
>  - attr.c: replace home_config_paths() with xdg_config_home()
>  - path.c: implement xdg_config_home()
>  (this branch uses pt/credential-xdg.)
>
>  Seen some discussions.
>  Waiting for a reroll ($gmane/267518).


> * mh/numparse (2015-03-19) 14 commits
>  - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
>  - diff_opt_parse(): use convert_i() when handling "-l<num>"
>  - opt_arg(): simplify pointer handling
>  - opt_arg(): report errors parsing option values
>  - opt_arg(): use convert_i() in implementation
>  - opt_arg(): val is always non-NULL
>  - builtin_diff(): detect errors when parsing --unified argument
>  - handle_revision_opt(): use convert_ui() when handling "--abbrev="
>  - strtoul_ui(), strtol_i(): remove functions
>  - handle_revision_opt(): use convert_i() when handling "-<digit>"
>  - handle_revision_opt(): use skip_prefix() in many places
>  - write_subdirectory(): use convert_ui() for parsing mode
>  - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
>  - numparse: new module for parsing integral numbers
>
>  Many codepaths use unchecked use of strtol() and friends (or even
>  worse, atoi()).  Introduce a set of wrappers that try to be more
>  careful.
>
>  Waiting for a reroll ($gmane/266209).



> * tf/gitweb-project-listing (2015-03-19) 5 commits
>  - gitweb: make category headings into links when they are directories
>  - gitweb: optionally set project category from its pathname
>  - gitweb: add a link under the search box to clear a project filter
>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
>  - gitweb: fix typo in man page
>
>  Update gitweb to make it more pleasant to deal with a hierarchical
>  forest of repositories.
>
>  Any comments from those who use or have their own code in Gitweb?

> * nd/list-files (2015-02-09) 21 commits
>  - t3080: tests for git-list-files
>  - list-files: -M aka diff-cached
>  - list-files -F: show submodules with the new indicator '&'
>  - list-files: add -F/--classify
>  - list-files: show directories as well as files
>  - list-files: do not show duplicate cached entries
>  - list-files: sort output and remove duplicates
>  - list-files: add -t back
>  - list-files: add -1 short for --no-column
>  - list-files: add -R/--recursive short for --max-depth=-1
>  - list-files: -u does not imply showing stages
>  - list-files: make alias 'ls' default to 'list-files'
>  - list-files: a user friendly version of ls-files and more
>  - ls-files: support --max-depth
>  - ls-files: add --column
>  - ls-files: add --color to highlight file names
>  - ls-files: buffer full item in strbuf before printing
>  - ls_colors.c: highlight submodules like directories
>  - ls_colors.c: add a function to color a file name
>  - ls_colors.c: parse color.ls.* from config file
>  - ls_colors.c: add $LS_COLORS parsing code
>
>  A new "git list-files" Porcelain command, "ls-files" with bells and
>  whistles.
>
>  Reroll to base on wt-status work ($gmane/265142) has seen some
>  positive discussions.
>
>  Waiting for a further polished reroll ($gmane/265534).



> * js/fsck-opt (2015-01-21) 19 commits
>  - fsck: support ignoring objects in `git fsck` via fsck.skiplist
>  - fsck: git receive-pack: support excluding objects from fsck'ing
>  - fsck: introduce `git fsck --quick`
>  - fsck: support demoting errors to warnings
>  - fsck: document the new receive.fsck.* options
>  - fsck: allow upgrading fsck warnings to errors
>  - fsck: optionally ignore specific fsck issues completely
>  - fsck: disallow demoting grave fsck errors to warnings
>  - fsck: add a simple test for receive.fsck.*
>  - fsck: make fsck_tag() warn-friendly
>  - fsck: handle multiple authors in commits specially
>  - fsck: make fsck_commit() warn-friendly
>  - fsck: make fsck_ident() warn-friendly
>  - fsck: report the ID of the error/warning
>  - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
>  - fsck: offer a function to demote fsck errors to warnings
>  - fsck: provide a function to parse fsck message IDs
>  - fsck: introduce identifiers for fsck messages
>  - fsck: introduce fsck options
>
>  "fsck.warnings = <list of error tokens>" I suggested turned out to
>  be an unpopular choice (sorry Dscho).
>
>  Expecting a reroll.
