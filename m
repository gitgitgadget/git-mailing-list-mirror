From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2012, #03; Tue, 8)
Date: Tue, 08 May 2012 12:16:32 -0700
Message-ID: <7vfwbav5yn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 21:16:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRptq-0006kj-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 21:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab2EHTQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 15:16:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843Ab2EHTQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 15:16:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8F797599;
	Tue,  8 May 2012 15:16:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	pseeGsAN/FZsnIgwNibPJq8IjI=; b=u7Rx7XGMvst3goIvXhCND7Sv8HPHdvDzp
	7yf8qUWpjy/YSc8y0kNvffGv0Dpdp8tp1WdJXMOQSqZjQOVIRAIsVLlZGaHX9grw
	nnmgp9YYUfz+6MslkrIxxDdB8HAZbwiVMP/vGl1WId/pXfgsZWVumHkXDjsaOqmf
	qN0cd6vT3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VDN
	NVBfWRS+nnF025286ddkNKWcpK1rPqUFay3PY/OXn0rQp1wjZo4evycKJ0e2ZyOY
	Oloi5rUU4+7lGV3dyFTDuIkvldM9wVEMSkpGFiZpcFj1pYpTi9cxalV7TLfJjGeC
	a0Cr41qE8J6vR6H8ty0K/AKmSt6q2m0Pxsr+0EOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF43F7598;
	Tue,  8 May 2012 15:16:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11B4E7595; Tue,  8 May 2012
 15:16:33 -0400 (EDT)
X-master-at: a3935e6791c619a9f2f472e9e553d45d88c4e263
X-next-at: fc4d754aa0f0b59f9e5aae11a66367f2db8d5ae0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5337253C-9942-11E1-9306-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197416>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The ninth batch of topics have graduated to 'master'; we seem to have
accumulated more topics on 'next' in the meantime, but they all look
healthy.  It is a good time to start preparing for the feature freeze.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ah/maint-grep-double-init (2012-05-07) 1 commit
  (merged to 'next' on 2012-05-08 at 51f84c5)
 + grep.c: remove redundant line of code

Will merge to 'master'.

* ef/maint-1.7.6-clone-progress-fix (2012-05-07) 1 commit
 + clone: fix progress-regression
 (this branch is used by ef/maint-clone-progress-fix.)

Will merge to 'master'.

* ef/maint-clone-progress-fix (2012-05-07) 1 commit
  (merged to 'next' on 2012-05-08 at b9a6cad)
 + Merge branch 'ef/maint-1.7.6-clone-progress-fix' into ef/maint-clone-progress-fix
 (this branch uses ef/maint-1.7.6-clone-progress-fix.)

Some time ago, "git clone" lost the progress output for its "checkout"
phase; when run without any "--quiet" option, it should give progress to
the lengthy operation.

Will merge to 'master'.

* fa/maint-config-doc (2012-05-07) 1 commit
  (merged to 'next' on 2012-05-08 at 54cc478)
 + Documentation/git-config: describe and clarify "--local <file>" option

Will merge to 'master'.

* fc/simplify-complete-revlist-file (2012-05-07) 1 commit
  (merged to 'next' on 2012-05-08 at ff0b7d1)
 + completion: simplify __git_complete_revlist_file

Will merge to 'master'.

* jk/maint-status-porcelain-z-b (2012-05-08) 4 commits
 + status: respect "-b" for porcelain format
 + status: fix null termination with "-b"
 + status: refactor null_termination option
 + commit: refactor option parsing
 (this branch is used by jk/status-porcelain-z-b.)

Will merge to 'master'.

* jk/status-porcelain-z-b (2012-05-08) 2 commits
  (merged to 'next' on 2012-05-08 at 31172dd)
 + status: refactor colopts handling
 + Merge branch 'jk/maint-status-porcelain-z-b' into HEAD
 (this branch uses jk/maint-status-porcelain-z-b.)

"git status --porcelain" ignored "--branch" option by mistake.  The output
for "git status --branch -z" was also incorrect and did not terminate the
record for the current branch name with NUL as asked.

Will merge to 'master'.

* ef/checkout-empty (2012-05-08) 1 commit
  (merged to 'next' on 2012-05-08 at fc4d754)
 + checkout: do not corrupt HEAD on empty repo

Running "git checkout" on an unborn branch used to corrupt HEAD
(regression in 1.7.10); this makes it error out.

Will merge to 'master'.

* nd/i18n-apply-lego (2012-05-08) 1 commit
  (merged to 'next' on 2012-05-08 at c2be904)
 + apply: remove lego in i18n string in gitdiff_verify_name

Will merge to 'master'.

* nd/i18n-parseopt (2012-05-08) 2 commits
  (merged to 'next' on 2012-05-08 at 15eb029)
 + i18n: apply: mark parseopt strings for translation
 + i18n: parseopt: lookup help and argument translations when showing usage

Text from "git cmd --help" are getting prepared for i18n.

* rs/maint-dir-strbuf (2012-05-08) 1 commit
 + dir: convert to strbuf
 (this branch is used by rs/dir-strbuf.)

Will merge to 'master'.

* rs/dir-strbuf (2012-05-08) 1 commit
  (merged to 'next' on 2012-05-08 at 0bc94fb)
 + Merge branch 'rs/maint-dir-strbuf' into rs/dir-strbuf
 (this branch uses rs/maint-dir-strbuf.)

Will merge to 'master'.

--------------------------------------------------
[Graduated to "master"]

* jk/maint-tformat-with-z (2012-05-01) 2 commits
  (merged to 'next' on 2012-05-02 at a0f8af7)
 + log-tree: the previous one is still not quite right
 + log-tree: use custom line terminator in line termination mode

"log -z --pretty=tformat:..." does not terminate each record with NUL
and this is a beginning of an attempt to fix it.  It still is not right
but the patch does not make externally observable behaviour worse.

* nh/empty-rebase (2012-05-03) 1 commit
  (merged to 'next' on 2012-05-04 at 8a79d96)
 + git cherry-pick: do not dereference a potential NULL pointer

Fix to a topic merged to 'master'.

* th/difftool-diffall (2012-04-23) 8 commits
  (merged to 'next' on 2012-05-02 at fdc9f60)
 + difftool: print list of valid tools with '--tool-help'
 + difftool: teach difftool to handle directory diffs
 + difftool: eliminate setup_environment function
 + difftool: stop appending '.exe' to git
 + difftool: remove explicit change of PATH
 + difftool: exit(0) when usage is printed
 + difftool: add '--no-gui' option
 + difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) into
"git difftool" framework. 

* zj/diff-empty-chmod (2012-05-02) 5 commits
  (merged to 'next' on 2012-05-02 at fb8cb11)
 + t4006: Windows do not have /dev/zero
  (merged to 'next' on 2012-05-01 at 5a92787)
 + diff --stat: do not run diff on indentical files
 + diff --stat: report mode-only changes for binary files like text files
 + tests: check --[short]stat output after chmod
 + test: modernize style of t4006

"git diff --stat" used to fully count a binary file with modified
execution bits whose contents is unmodified, which was not right.

--------------------------------------------------
[Stalled]

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
Not ready.
There still seem to be other bugs hiding (e.g. try pushing twice).

* nl/http-proxy-more (2012-05-03) 6 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: fix http_proxy specified without protocol part
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not set

It appears that the scope of this series should be drastically reduced, or
perhaps wait the entire topic until cURL library gains the necessary hooks
to tell us what proxy server wants us to authenticate when giving us 407.

Probably we will end up discarding this series, at least for this cycle.

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* jc/install-no-hardlinks (2012-05-04) 1 commit
  (merged to 'next' on 2012-05-07 at b69e132)
 + Makefile: NO_INSTALL_HARDLINKS

Your build platform may support hardlinks but you may prefer not to use
them, e.g. when installing to DESTDIR to make a tarball and untarring on
a filesystem that has poor support for hardlinks.

The Makefile in git-gui project may need to learn to honor the same
setting; it unconditionally creates git-citool by hardlinking git-gui.

Will merge to 'master'.

* jk/maint-reflog-walk-count-vs-time (2012-05-07) 5 commits
  (merged to 'next' on 2012-05-08 at b1a9987)
 + reflog-walk: tell explicit --date=default from not having --date at all
  (merged to 'next' on 2012-05-07 at 3652958)
 + reflog-walk: always make HEAD@{0} show indexed selectors
 + reflog-walk: clean up "flag" field of commit_reflog struct
 + log: respect date_mode_explicit with --format:%gd
 + t1411: add more selector index/date tests

Gives a better DWIM behaviour for --pretty=format:%gd, "stash list", and
"log -g", depending on how the starting point ("master" vs "master@{0}" vs
"master@{now}") and date formatting options (e.g. "--date=iso") are given
on the command line.

Will merge to 'master'.

* nd/i18n-branch-lego (2012-05-04) 1 commit
  (merged to 'next' on 2012-05-07 at af4e16f)
 + branch: remove lego in i18n tracking info strings

Fix yet another message construction by concatenating pieces of sentenes,
which is unfriendly to i18n.

Will merge to 'next'.

* js/checkout-detach-count (2012-05-04) 2 commits
  (merged to 'next' on 2012-05-07 at 2957590)
 + checkout (detached): truncate list of orphaned commits at the new HEAD
 + t2020-checkout-detach: check for the number of orphaned commits

When checking out another commit from an already detached state, we used
to report all commits that are not reachable from any of the refs as
lossage, but some of them might be reachable from the new HEAD, and there
is no need to warn about them.

Will merge to 'master'.

* nd/stream-to-archive (2012-05-03) 10 commits
  (merged to 'next' on 2012-05-07 at 92f11c4)
 + t5000: rationalize unzip tests
 + archive-zip: streaming for deflated files
 + archive-zip: streaming for stored files
 + archive-zip: factor out helpers for writing sizes and CRC
 + archive-zip: remove uncompressed_size
 + archive-tar: stream large blobs to tar file
 + archive: delegate blob reading to backend
 + archive-tar: unindent write_tar_entry by one level
 + archive-tar: turn write_tar_entry into blob-writing only
 + streaming: void pointer instead of char pointer

Stream large blobs directly out to archive files without slurping
everything in memory first.

Will merge to 'master'.

* mh/ref-api-lazy-loose (2012-05-04) 18 commits
  (merged to 'next' on 2012-05-04 at a70d858)
 + refs: fix find_containing_dir() regression
 + refs: read loose references lazily
 + read_loose_refs(): eliminate ref_cache argument
 + struct ref_dir: store a reference to the enclosing ref_cache
 + search_for_subdir(): return (ref_dir *) instead of (ref_entry *)
 + get_ref_dir(): add function for getting a ref_dir from a ref_entry
 + read_loose_refs(): rename function from get_ref_dir()
 + refs: wrap top-level ref_dirs in ref_entries
 + find_containing_dir(): use strbuf in implementation of this function
 + bisect: copy filename string obtained from git_path()
 + do_for_each_reflog(): use a strbuf to hold logfile name
 + do_for_each_reflog(): return early on error
 + get_ref_dir(): take the containing directory as argument
 + refs.c: extract function search_for_subdir()
 + get_ref_dir(): require that the dirname argument ends in '/'
 + get_ref_dir(): rename "base" parameter to "dirname"
 + get_ref_dir(): use a strbuf to hold refname
 + get_ref_dir(): return early if directory cannot be read

Refs API is updated to lazily read sub-hierarchies of refs/ namespace,
so that we do not have to grab everything from the filesystem when we
are only interested in listing branches, for example.

Will merge to 'master'.

* nd/threaded-index-pack (2012-05-07) 4 commits
  (merged to 'next' on 2012-05-08 at 053b797)
 + index-pack: disable threading if NO_PREAD is defined
 + index-pack: support multithreaded delta resolving
 + index-pack: restructure pack processing into three main functions
 + compat/win32/pthread.h: Add an pthread_key_delete() implementation

Enables threading in index-pack to resolve base data in parallel.

Will merge to 'master'.

* mm/push-default-switch-warning (2012-04-26) 2 commits
 - t5541: warning message is given even with --quiet
 - push: start warning upcoming default change for push.default

Will squash the two, but this has to wait for a few release cycles.

--------------------------------------------------
[Discarded]

* cb/daemon-test-race-fix (2012-04-27) 2 commits
  (merged to 'next' on 2012-04-27 at 84bbcf8)
 + Revert "git-daemon wrapper to wait until daemon is ready"
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Fix race condition between starting and waiting for git-daemon in the
test.

Reverted from 'next' to replace it with js/daemon-test-race-fix.
