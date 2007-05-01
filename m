From: Jari Aalto <jari.aalto@cante.net>
Subject: FYI: 1.5.1.3 Cygwin build result (compiler warnings)
Date: Tue, 01 May 2007 14:14:37 +0300
Organization: Private
Message-ID: <ejm0x0bm.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 13:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiqKi-0006LH-IG
	for gcvg-git@gmane.org; Tue, 01 May 2007 13:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031669AbXEALPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 07:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031673AbXEALPo
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 07:15:44 -0400
Received: from main.gmane.org ([80.91.229.2]:37582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031669AbXEALPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 07:15:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HiqKO-0002s0-Lj
	for git@vger.kernel.org; Tue, 01 May 2007 13:15:28 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 May 2007 13:15:28 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 May 2007 13:15:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:msKyvNmnnmUUsF4M31aNOdGZrLY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45941>


FYI,

In case someone gets interested in addressing the warnings, here is
compile result under current Cygwin.

Jari

----------------------------------------------------------------------

GNU Make 3.81
gcc (GCC) 3.4.4 (cygming special, gdc 0.12, using dmd 0.125)

GIT_VERSION = 1.5.1.3
rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
                test-chmtime.exe libgit.a xdiff/lib.a
rm -f git-convert-objects.exe git-fetch-pack.exe git-fsck.exe git-hash-object.exe git-index-pack.exe git-local-fetch.exe git-fast-import.exe git-merge-base.exe git-daemon.exe git-merge-index.exe git-mktag.exe git-mktree.exe git-patch-id.exe git-peek-remote.exe git-receive-pack.exe git-send-pack.exe git-shell.exe git-show-index.exe git-ssh-fetch.exe git-ssh-upload.exe git-unpack-file.exe git-update-server-info.exe git-upload-pack.exe git-verify-pack.exe git-pack-redundant.exe git-var.exe git-merge-tree.exe git-imap-send.exe git-merge-recursive.exe  git-ssh-pull.exe git-ssh-push.exe git-http-fetch.exe git-http-push.exe git-bisect git-checkout git-clean git-clone git-commit git-fetch git-ls-remote git-merge-one-file git-mergetool git-parse-remote git-pull git-rebase git-repack git-request-pull git-reset git-sh-setup git-tag git-verify-tag git-applymbox git-applypatch git-am git-merge git-me
 rge-stupid git-merge-octopus git-merge-resolve git-merge-ours git-lost-found git-quiltimport git-add--interactive git-archimport git-cvsimport git-relink git-cvsserver git-remote git-svnimport git-cvsexportcommit git-send-email git-svn git-status git-instaweb git-format-patch.exe git-show.exe git-whatchanged.exe git-cherry.exe git-get-tar-commit-id.exe git-init.exe git-repo-config.exe git-fsck-objects.exe git-cherry-pick.exe git-add.exe git-annotate.exe git-apply.exe git-archive.exe git-blame.exe git-branch.exe git-bundle.exe git-cat-file.exe git-checkout-index.exe git-check-ref-format.exe git-commit-tree.exe git-count-objects.exe git-describe.exe git-diff.exe git-diff-files.exe git-diff-index.exe git-diff-tree.exe git-fetch--tool.exe git-fmt-merge-msg.exe git-for-each-ref.exe git-fsck.exe git-gc.exe git-grep.exe git-init-db.exe git-log.exe git-ls-files.exe git-ls-tree.exe git-mailinfo
 .exe git-mailsplit.exe git-merge-base.exe git-merge-file.exe git-mv.exe git-name-rev.exe git-pack-objects.exe git-prune.exe git-prune-packed.exe git-push.exe git-read-tree.exe git-reflog.exe git-config.exe git-rerere.exe git-rev-list.exe git-rev-parse.exe git-revert.exe git-rm.exe git-runstatus.exe git-shortlog.exe git-show-branch.exe git-stripspace.exe git-symbolic-ref.exe git-tar-tree.exe git-unpack-objects.exe git-update-index.exe git-update-ref.exe git-upload-archive.exe git-verify-pack.exe git-write-tree.exe git-show-ref.exe git-pack-refs.exe git.exe
rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
rm -rf autom4te.cache
rm -f configure config.log config.mak.autogen config.mak.append config.status config.cache
rm -rf git-1.5.1.3 .doc-tmp-dir
rm -f git-1.5.1.3.tar.gz git-core_1.5.1.3-*.tar.gz
rm -f git-htmldocs-1.5.1.3.tar.gz git-manpages-1.5.1.3.tar.gz
rm -f gitweb/gitweb.cgi
make -C Documentation/ clean
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/Documentation'
rm -f doc.dep+ doc.dep
perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/Documentation'
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/Documentation'
rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
rm -f cmds-ancillaryinterrogators.txt cmds-ancillarymanipulators.txt cmds-mainporcelain.txt cmds-plumbinginterrogators.txt cmds-plumbingmanipulators.txt cmds-synchingrepositories.txt cmds-synchelpers.txt cmds-purehelpers.txt cmds-foreignscminterface.txt *.made
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/Documentation'
make -C perl clean
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/perl'
rm -f ppport.h
rm -f perl.mak
rm -f perl.mak.old
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/perl'
make -C git-gui clean
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/git-gui'
GITGUI_VERSION = 0.6.5.1.gf6f2
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/git-gui'
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/git-gui'
rm -f git-citool git-gui GIT-VERSION-FILE
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/git-gui'
make -C templates/ clean
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/templates'
rm -rf blt boilerplates.made
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/templates'
make -C t/ clean
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/t'
rm -fr trash
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/t'
rm -f GIT-VERSION-FILE GIT-CFLAGS
make: *** No rule to make target `distclean'.  Stop.
--   Wait, shadowing source files to /usr/src/build/build/git/git-1.5.1.3/.build/build
-- Shadow finished.
--   Running: make configure (auto detected; no ./configure)
GIT_VERSION = 1.5.1.3
    GEN configure
** Build command
--   Building with standard make(1) ./Makefile
    * new build flags or prefix
    CC convert-objects.o
    CC blob.o
    CC commit.o
    CC connect.o
    CC csum-file.o
    CC cache-tree.o
    CC base85.o
    CC date.o
    CC diff-delta.o
    CC entry.o
    CC exec_cmd.o
    CC ident.o
    CC interpolate.o
    CC lockfile.o
    CC object.o
    CC pack-check.o
pack-check.c: In function `show_pack_info':
pack-check.c:123: warning: int format, long unsigned int arg (arg 3)
pack-check.c:123: warning: int format, long unsigned int arg (arg 4)
    CC patch-delta.o
    CC path.o
    CC pkt-line.o
    CC sideband.o
    CC reachable.o
    CC reflog-walk.o
    CC quote.o
    CC read-cache.o
read-cache.c: In function `ce_match_stat_basic':
read-cache.c:133: warning: unsigned int format, long unsigned int arg (arg 2)
    CC refs.o
    CC run-command.o
    CC dir.o
    CC object-refs.o
    CC server-info.o
    CC setup.o
    CC sha1_file.o
sha1_file.c: In function `open_packed_git_1':
sha1_file.c:605: warning: unsigned int format, long unsigned int arg (arg 3)
sha1_file.c:612: warning: unsigned int format, long unsigned int arg (arg 3)
sha1_file.c:612: warning: unsigned int format, uint32_t arg (arg 4)
    CC sha1_name.o
    CC strbuf.o
    CC tag.o
    CC tree.o
    CC usage.o
    CC config.o
    CC environment.o
    CC ctype.o
    CC copy.o
    CC revision.o
    CC pager.o
    CC tree-walk.o
    CC xdiff-interface.o
    CC write_or_die.o
    CC trace.o
    CC list-objects.o
    CC grep.o
    CC alloc.o
    CC merge-file.o
    CC path-list.o
    GEN common-cmds.h
    CC help.o
    CC unpack-trees.o
unpack-trees.c: In function `show_stage_entry':
unpack-trees.c:546: warning: unsigned int format, long unsigned int arg (arg 4)
    CC diff.o
    CC diff-lib.o
    CC diffcore-break.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC tree-diff.o
    CC combine-diff.o
    CC diffcore-delta.o
    CC log-tree.o
    CC color.o
    CC wt-status.o
    CC archive-zip.o
    CC archive-tar.o
    CC shallow.o
    CC utf8.o
utf8.c: In function `reencode_string':
utf8.c:328: warning: passing arg 2 of `libiconv' from incompatible pointer type
    CC convert.o
    CC compat/strcasestr.o
    CC compat/mmap.o
    AR libgit.a
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    AR xdiff/lib.a
    LINK git-convert-objects.exe
    CC fetch-pack.o
fetch-pack.c: In function `get_pack':
fetch-pack.c:516: warning: unsigned int format, long unsigned int arg (arg 4)
fetch-pack.c:516: warning: unsigned int format, long unsigned int arg (arg 5)
    LINK git-fetch-pack.exe
    CC builtin-add.o
    CC builtin-annotate.o
    CC builtin-apply.o
    CC builtin-archive.o
    CC builtin-blame.o
    CC builtin-branch.o
    CC builtin-bundle.o
    CC builtin-cat-file.o
    CC builtin-checkout-index.o
    CC builtin-check-ref-format.o
    CC builtin-commit-tree.o
    CC builtin-count-objects.o
    CC builtin-describe.o
    CC builtin-diff.o
    CC builtin-diff-files.o
    CC builtin-diff-index.o
    CC builtin-diff-tree.o
    CC builtin-fetch--tool.o
    CC builtin-fmt-merge-msg.o
    CC builtin-for-each-ref.o
    CC builtin-fsck.o
    CC builtin-gc.o
    CC builtin-grep.o
    CC builtin-init-db.o
    CC builtin-log.o
    CC builtin-ls-files.o
builtin-ls-files.c: In function `show_ce_entry':
builtin-ls-files.c:201: warning: unsigned int format, long unsigned int arg (arg 3)
    CC builtin-ls-tree.o
    CC builtin-mailinfo.o
    CC builtin-mailsplit.o
    CC builtin-merge-base.o
    CC builtin-merge-file.o
    CC builtin-mv.o
    CC builtin-name-rev.o
    CC builtin-pack-objects.o
builtin-pack-objects.c: In function `write_pack_file':
builtin-pack-objects.c:535: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:550: warning: unsigned int format, uint32_t arg (arg 4)
builtin-pack-objects.c:550: warning: unsigned int format, uint32_t arg (arg 5)
builtin-pack-objects.c:560: warning: unsigned int format, uint32_t arg (arg 2)
builtin-pack-objects.c:560: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c: In function `add_object_entry':
builtin-pack-objects.c:719: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c: In function `find_deltas':
builtin-pack-objects.c:1289: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1303: warning: unsigned int format, uint32_t arg (arg 4)
builtin-pack-objects.c:1303: warning: unsigned int format, uint32_t arg (arg 5)
builtin-pack-objects.c: In function `reuse_cached_pack':
builtin-pack-objects.c:1387: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c: In function `cmd_pack_objects':
builtin-pack-objects.c:1670: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1683: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 4)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 5)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 6)
    CC builtin-prune.o
    CC builtin-prune-packed.o
    CC builtin-push.o
    CC builtin-read-tree.o
    CC builtin-reflog.o
    CC builtin-config.o
    CC builtin-rerere.o
    CC builtin-rev-list.o
    CC builtin-rev-parse.o
    CC builtin-revert.o
    CC builtin-rm.o
    CC builtin-runstatus.o
    CC builtin-shortlog.o
    CC builtin-show-branch.o
    CC builtin-stripspace.o
    CC builtin-symbolic-ref.o
    CC builtin-tar-tree.o
    CC builtin-unpack-objects.o
builtin-unpack-objects.c: In function `unpack_all':
builtin-unpack-objects.c:327: warning: int format, long unsigned int arg (arg 2)
    CC builtin-update-index.o
    CC builtin-update-ref.o
    CC builtin-upload-archive.o
    CC builtin-verify-pack.o
    CC builtin-write-tree.o
    CC builtin-show-ref.o
    CC builtin-pack-refs.o
    LINK git.exe
    BUILTIN git-fsck.exe
    CC hash-object.o
    LINK git-hash-object.exe
    CC index-pack.o
index-pack.c: In function `parse_pack_header':
index-pack.c:170: warning: int format, long unsigned int arg (arg 2)
    LINK git-index-pack.exe
    CC local-fetch.o
    CC fetch.o
    LINK git-local-fetch.exe
    CC fast-import.o
    LINK git-fast-import.exe
    BUILTIN git-merge-base.exe
    CC daemon.o
    LINK git-daemon.exe
    CC merge-index.o
merge-index.c: In function `merge_entry':
merge-index.c:51: warning: unsigned int format, long unsigned int arg (arg 3)
    LINK git-merge-index.exe
    CC mktag.o
    LINK git-mktag.exe
    CC mktree.o
    LINK git-mktree.exe
    CC patch-id.o
    LINK git-patch-id.exe
    CC peek-remote.o
    LINK git-peek-remote.exe
    CC receive-pack.o
receive-pack.c: In function `unpack':
receive-pack.c:356: warning: unsigned int format, long unsigned int arg (arg 4)
receive-pack.c:356: warning: unsigned int format, long unsigned int arg (arg 5)
    LINK git-receive-pack.exe
    CC send-pack.o
    LINK git-send-pack.exe
    CC shell.o
    LINK git-shell.exe
    CC show-index.o
    LINK git-show-index.exe
    CC ssh-fetch.o
    CC rsh.o
    LINK git-ssh-fetch.exe
    CC ssh-upload.o
    LINK git-ssh-upload.exe
    CC unpack-file.o
    LINK git-unpack-file.exe
    CC update-server-info.o
    LINK git-update-server-info.exe
    CC upload-pack.o
    LINK git-upload-pack.exe
    BUILTIN git-verify-pack.exe
    CC pack-redundant.o
    LINK git-pack-redundant.exe
    CC var.o
    LINK git-var.exe
    CC merge-tree.o
    LINK git-merge-tree.exe
    CC imap-send.o
    LINK git-imap-send.exe
    CC merge-recursive.o
    LINK git-merge-recursive.exe
    CC ssh-pull.o
    LINK git-ssh-pull.exe
    CC ssh-push.o
    LINK git-ssh-push.exe
    CC http.o
    CC http-fetch.o
    LINK git-http-fetch.exe
    CC http-push.o
    LINK git-http-push.exe
    GEN git-bisect
    GEN git-checkout
    GEN git-clean
    GEN git-clone
    GEN git-commit
    GEN git-fetch
    GEN git-ls-remote
    GEN git-merge-one-file
    GEN git-mergetool
    GEN git-parse-remote
    GEN git-pull
    GEN git-rebase
    GEN git-repack
    GEN git-request-pull
    GEN git-reset
    GEN git-sh-setup
    GEN git-tag
    GEN git-verify-tag
    GEN git-applymbox
    GEN git-applypatch
    GEN git-am
    GEN git-merge
    GEN git-merge-stupid
    GEN git-merge-octopus
    GEN git-merge-resolve
    GEN git-merge-ours
    GEN git-lost-found
    GEN git-quiltimport
    SUBDIR perl
'/usr/bin/perl' Makefile.PL PREFIX='/cygdrive/x/home/jaalto'
Writing perl.mak for Git
    GEN git-add--interactive
    GEN git-archimport
    GEN git-cvsimport
    GEN git-relink
    GEN git-cvsserver
    GEN git-remote
    GEN git-svnimport
    GEN git-cvsexportcommit
    GEN git-send-email
    GEN git-svn
    GEN git-status
    GEN gitweb/gitweb.cgi
    GEN git-instaweb
    BUILTIN git-format-patch.exe
    BUILTIN git-show.exe
    BUILTIN git-whatchanged.exe
    BUILTIN git-cherry.exe
    BUILTIN git-get-tar-commit-id.exe
    BUILTIN git-init.exe
    BUILTIN git-repo-config.exe
    BUILTIN git-fsck-objects.exe
    BUILTIN git-cherry-pick.exe
    BUILTIN git-add.exe
    BUILTIN git-annotate.exe
    BUILTIN git-apply.exe
    BUILTIN git-archive.exe
    BUILTIN git-blame.exe
    BUILTIN git-branch.exe
    BUILTIN git-bundle.exe
    BUILTIN git-cat-file.exe
    BUILTIN git-checkout-index.exe
    BUILTIN git-check-ref-format.exe
    BUILTIN git-commit-tree.exe
    BUILTIN git-count-objects.exe
    BUILTIN git-describe.exe
    BUILTIN git-diff.exe
    BUILTIN git-diff-files.exe
    BUILTIN git-diff-index.exe
    BUILTIN git-diff-tree.exe
    BUILTIN git-fetch--tool.exe
    BUILTIN git-fmt-merge-msg.exe
    BUILTIN git-for-each-ref.exe
    BUILTIN git-gc.exe
    BUILTIN git-grep.exe
    BUILTIN git-init-db.exe
    BUILTIN git-log.exe
    BUILTIN git-ls-files.exe
    BUILTIN git-ls-tree.exe
    BUILTIN git-mailinfo.exe
    BUILTIN git-mailsplit.exe
    BUILTIN git-merge-file.exe
    BUILTIN git-mv.exe
    BUILTIN git-name-rev.exe
    BUILTIN git-pack-objects.exe
    BUILTIN git-prune.exe
    BUILTIN git-prune-packed.exe
    BUILTIN git-push.exe
    BUILTIN git-read-tree.exe
    BUILTIN git-reflog.exe
    BUILTIN git-config.exe
    BUILTIN git-rerere.exe
    BUILTIN git-rev-list.exe
    BUILTIN git-rev-parse.exe
    BUILTIN git-revert.exe
    BUILTIN git-rm.exe
    BUILTIN git-runstatus.exe
    BUILTIN git-shortlog.exe
    BUILTIN git-show-branch.exe
    BUILTIN git-stripspace.exe
    BUILTIN git-symbolic-ref.exe
    BUILTIN git-tar-tree.exe
    BUILTIN git-unpack-objects.exe
    BUILTIN git-update-index.exe
    BUILTIN git-update-ref.exe
    BUILTIN git-upload-archive.exe
    BUILTIN git-write-tree.exe
    BUILTIN git-show-ref.exe
    BUILTIN git-pack-refs.exe
rm -f 'git-convert-objects';  rm -f 'git-fetch-pack';  rm -f 'git-fsck';  rm -f 'git-hash-object';  rm -f 'git-index-pack';  rm -f 'git-local-fetch';  rm -f 'git-fast-import';  rm -f 'git-merge-base';  rm -f 'git-daemon';  rm -f 'git-merge-index';  rm -f 'git-mktag';  rm -f 'git-mktree';  rm -f 'git-patch-id';  rm -f 'git-peek-remote';  rm -f 'git-receive-pack';  rm -f 'git-send-pack';  rm -f 'git-shell';  rm -f 'git-show-index';  rm -f 'git-ssh-fetch';  rm -f 'git-ssh-upload';  rm -f 'git-unpack-file';  rm -f 'git-update-server-info';  rm -f 'git-upload-pack';  rm -f 'git-verify-pack';  rm -f 'git-pack-redundant';  rm -f 'git-var';  rm -f 'git-merge-tree';  rm -f 'git-imap-send';  rm -f 'git-merge-recursive';  rm -f 'git-ssh-pull';  rm -f 'git-ssh-push';  rm -f 'git-http-fetch';  rm -f 'git-http-push';  rm -f 'git-format-patch';  rm -f 'git-show';  rm -f 'git-whatchanged';  rm -f 'git-c
 herry';  rm -f 'git-get-tar-commit-id';  rm -f 'git-init';  rm -f 'git-repo-config';  rm -f 'git-fsck-objects';  rm -f 'git-cherry-pick';  rm -f 'git-add';  rm -f 'git-annotate';  rm -f 'git-apply';  rm -f 'git-archive';  rm -f 'git-blame';  rm -f 'git-branch';  rm -f 'git-bundle';  rm -f 'git-cat-file';  rm -f 'git-checkout-index';  rm -f 'git-check-ref-format';  rm -f 'git-commit-tree';  rm -f 'git-count-objects';  rm -f 'git-describe';  rm -f 'git-diff';  rm -f 'git-diff-files';  rm -f 'git-diff-index';  rm -f 'git-diff-tree';  rm -f 'git-fetch--tool';  rm -f 'git-fmt-merge-msg';  rm -f 'git-for-each-ref';  rm -f 'git-fsck';  rm -f 'git-gc';  rm -f 'git-grep';  rm -f 'git-init-db';  rm -f 'git-log';  rm -f 'git-ls-files';  rm -f 'git-ls-tree';  rm -f 'git-mailinfo';  rm -f 'git-mailsplit';  rm -f 'git-merge-base';  rm -f 'git-merge-file';  rm -f 'git-mv';  rm -f 'git-name-rev';  rm 
 -f 'git-pack-objects';  rm -f 'git-prune';  rm -f 'git-prune-packed';  rm -f 'git-push';  rm -f 'git-read-tree';  rm -f 'git-reflog';  rm -f 'git-config';  rm -f 'git-rerere';  rm -f 'git-rev-list';  rm -f 'git-rev-parse';  rm -f 'git-revert';  rm -f 'git-rm';  rm -f 'git-runstatus';  rm -f 'git-shortlog';  rm -f 'git-show-branch';  rm -f 'git-stripspace';  rm -f 'git-symbolic-ref';  rm -f 'git-tar-tree';  rm -f 'git-unpack-objects';  rm -f 'git-update-index';  rm -f 'git-update-ref';  rm -f 'git-upload-archive';  rm -f 'git-verify-pack';  rm -f 'git-write-tree';  rm -f 'git-show-ref';  rm -f 'git-pack-refs';  rm -f 'git';
    SUBDIR git-gui
GITGUI_VERSION = 0.6.5.1.gf6f2
make[1]: Warning: File `GIT-VERSION-FILE' has modification time 1.7 s in the future
    GEN git-gui
    BUILTIN git-citool
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
    SUBDIR perl
cp Git.pm blib/lib/Git.pm
    SUBDIR templates
** Install command
--   Emptying /usr/src/build/build/git/git-1.5.1.3/.inst
--   Installing docs to /usr/src/build/build/git/git-1.5.1.3/.inst/usr/share/doc/git-1.5.1.3 
--   Installing docs from /usr/src/build/build/git/git-1.5.1.3/Documentation
--   Running install to /usr/src/build/build/git/git-1.5.1.3/.inst
--   Running 'make install' (or equiv.) in /usr/src/build/build/git/git-1.5.1.3/.build/build
    * new build flags or prefix
    CC convert-objects.o
    CC blob.o
    CC commit.o
    CC connect.o
    CC csum-file.o
    CC cache-tree.o
    CC base85.o
    CC date.o
    CC diff-delta.o
    CC entry.o
    CC exec_cmd.o
    CC ident.o
    CC interpolate.o
    CC lockfile.o
    CC object.o
    CC pack-check.o
pack-check.c: In function `show_pack_info':
pack-check.c:123: warning: int format, long unsigned int arg (arg 3)
pack-check.c:123: warning: int format, long unsigned int arg (arg 4)
    CC patch-delta.o
    CC path.o
    CC pkt-line.o
    CC sideband.o
    CC reachable.o
    CC reflog-walk.o
    CC quote.o
    CC read-cache.o
read-cache.c: In function `ce_match_stat_basic':
read-cache.c:133: warning: unsigned int format, long unsigned int arg (arg 2)
    CC refs.o
    CC run-command.o
    CC dir.o
    CC object-refs.o
    CC server-info.o
    CC setup.o
    CC sha1_file.o
sha1_file.c: In function `open_packed_git_1':
sha1_file.c:605: warning: unsigned int format, long unsigned int arg (arg 3)
sha1_file.c:612: warning: unsigned int format, long unsigned int arg (arg 3)
sha1_file.c:612: warning: unsigned int format, uint32_t arg (arg 4)
    CC sha1_name.o
    CC strbuf.o
    CC tag.o
    CC tree.o
    CC usage.o
    CC config.o
    CC environment.o
    CC ctype.o
    CC copy.o
    CC revision.o
    CC pager.o
    CC tree-walk.o
    CC xdiff-interface.o
    CC write_or_die.o
    CC trace.o
    CC list-objects.o
    CC grep.o
    CC alloc.o
    CC merge-file.o
    CC path-list.o
    CC help.o
    CC unpack-trees.o
unpack-trees.c: In function `show_stage_entry':
unpack-trees.c:546: warning: unsigned int format, long unsigned int arg (arg 4)
    CC diff.o
    CC diff-lib.o
    CC diffcore-break.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC tree-diff.o
    CC combine-diff.o
    CC diffcore-delta.o
    CC log-tree.o
    CC color.o
    CC wt-status.o
    CC archive-zip.o
    CC archive-tar.o
    CC shallow.o
    CC utf8.o
utf8.c: In function `reencode_string':
utf8.c:328: warning: passing arg 2 of `libiconv' from incompatible pointer type
    CC convert.o
    CC compat/strcasestr.o
    CC compat/mmap.o
    AR libgit.a
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    AR xdiff/lib.a
    LINK git-convert-objects.exe
    CC fetch-pack.o
fetch-pack.c: In function `get_pack':
fetch-pack.c:516: warning: unsigned int format, long unsigned int arg (arg 4)
fetch-pack.c:516: warning: unsigned int format, long unsigned int arg (arg 5)
    LINK git-fetch-pack.exe
    CC builtin-add.o
    CC builtin-annotate.o
    CC builtin-apply.o
    CC builtin-archive.o
    CC builtin-blame.o
    CC builtin-branch.o
    CC builtin-bundle.o
    CC builtin-cat-file.o
    CC builtin-checkout-index.o
    CC builtin-check-ref-format.o
    CC builtin-commit-tree.o
    CC builtin-count-objects.o
    CC builtin-describe.o
    CC builtin-diff.o
    CC builtin-diff-files.o
    CC builtin-diff-index.o
    CC builtin-diff-tree.o
    CC builtin-fetch--tool.o
    CC builtin-fmt-merge-msg.o
    CC builtin-for-each-ref.o
    CC builtin-fsck.o
    CC builtin-gc.o
    CC builtin-grep.o
    CC builtin-init-db.o
    CC builtin-log.o
    CC builtin-ls-files.o
builtin-ls-files.c: In function `show_ce_entry':
builtin-ls-files.c:201: warning: unsigned int format, long unsigned int arg (arg 3)
    CC builtin-ls-tree.o
    CC builtin-mailinfo.o
    CC builtin-mailsplit.o
    CC builtin-merge-base.o
    CC builtin-merge-file.o
    CC builtin-mv.o
    CC builtin-name-rev.o
    CC builtin-pack-objects.o
builtin-pack-objects.c: In function `write_pack_file':
builtin-pack-objects.c:535: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:550: warning: unsigned int format, uint32_t arg (arg 4)
builtin-pack-objects.c:550: warning: unsigned int format, uint32_t arg (arg 5)
builtin-pack-objects.c:560: warning: unsigned int format, uint32_t arg (arg 2)
builtin-pack-objects.c:560: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c: In function `add_object_entry':
builtin-pack-objects.c:719: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c: In function `find_deltas':
builtin-pack-objects.c:1289: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1303: warning: unsigned int format, uint32_t arg (arg 4)
builtin-pack-objects.c:1303: warning: unsigned int format, uint32_t arg (arg 5)
builtin-pack-objects.c: In function `reuse_cached_pack':
builtin-pack-objects.c:1387: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c: In function `cmd_pack_objects':
builtin-pack-objects.c:1670: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1683: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 3)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 4)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 5)
builtin-pack-objects.c:1705: warning: unsigned int format, uint32_t arg (arg 6)
    CC builtin-prune.o
    CC builtin-prune-packed.o
    CC builtin-push.o
    CC builtin-read-tree.o
    CC builtin-reflog.o
    CC builtin-config.o
    CC builtin-rerere.o
    CC builtin-rev-list.o
    CC builtin-rev-parse.o
    CC builtin-revert.o
    CC builtin-rm.o
    CC builtin-runstatus.o
    CC builtin-shortlog.o
    CC builtin-show-branch.o
    CC builtin-stripspace.o
    CC builtin-symbolic-ref.o
    CC builtin-tar-tree.o
    CC builtin-unpack-objects.o
builtin-unpack-objects.c: In function `unpack_all':
builtin-unpack-objects.c:327: warning: int format, long unsigned int arg (arg 2)
    CC builtin-update-index.o
    CC builtin-update-ref.o
    CC builtin-upload-archive.o
    CC builtin-verify-pack.o
    CC builtin-write-tree.o
    CC builtin-show-ref.o
    CC builtin-pack-refs.o
    LINK git.exe
    BUILTIN git-fsck.exe
    CC hash-object.o
    LINK git-hash-object.exe
    CC index-pack.o
index-pack.c: In function `parse_pack_header':
index-pack.c:170: warning: int format, long unsigned int arg (arg 2)
    LINK git-index-pack.exe
    CC local-fetch.o
    CC fetch.o
    LINK git-local-fetch.exe
    CC fast-import.o
    LINK git-fast-import.exe
    BUILTIN git-merge-base.exe
    CC daemon.o
    LINK git-daemon.exe
    CC merge-index.o
merge-index.c: In function `merge_entry':
merge-index.c:51: warning: unsigned int format, long unsigned int arg (arg 3)
    LINK git-merge-index.exe
    CC mktag.o
    LINK git-mktag.exe
    CC mktree.o
    LINK git-mktree.exe
    CC patch-id.o
    LINK git-patch-id.exe
    CC peek-remote.o
    LINK git-peek-remote.exe
    CC receive-pack.o
receive-pack.c: In function `unpack':
receive-pack.c:356: warning: unsigned int format, long unsigned int arg (arg 4)
receive-pack.c:356: warning: unsigned int format, long unsigned int arg (arg 5)
    LINK git-receive-pack.exe
    CC send-pack.o
    LINK git-send-pack.exe
    CC shell.o
    LINK git-shell.exe
    CC show-index.o
    LINK git-show-index.exe
    CC ssh-fetch.o
    CC rsh.o
    LINK git-ssh-fetch.exe
    CC ssh-upload.o
    LINK git-ssh-upload.exe
    CC unpack-file.o
    LINK git-unpack-file.exe
    CC update-server-info.o
    LINK git-update-server-info.exe
    CC upload-pack.o
    LINK git-upload-pack.exe
    BUILTIN git-verify-pack.exe
    CC pack-redundant.o
    LINK git-pack-redundant.exe
    CC var.o
    LINK git-var.exe
    CC merge-tree.o
    LINK git-merge-tree.exe
    CC imap-send.o
    LINK git-imap-send.exe
    CC merge-recursive.o
    LINK git-merge-recursive.exe
    CC ssh-pull.o
    LINK git-ssh-pull.exe
    CC ssh-push.o
    LINK git-ssh-push.exe
    CC http.o
    CC http-fetch.o
    LINK git-http-fetch.exe
    CC http-push.o
    LINK git-http-push.exe
    SUBDIR perl
'/usr/bin/perl' Makefile.PL PREFIX='/usr'
Writing perl.mak for Git
    GEN git-add--interactive
    GEN git-archimport
    GEN git-cvsimport
    GEN git-relink
    GEN git-cvsserver
    GEN git-remote
    GEN git-svnimport
    GEN git-cvsexportcommit
    GEN git-send-email
    GEN git-svn
    BUILTIN git-format-patch.exe
    BUILTIN git-show.exe
    BUILTIN git-whatchanged.exe
    BUILTIN git-cherry.exe
    BUILTIN git-get-tar-commit-id.exe
    BUILTIN git-init.exe
    BUILTIN git-repo-config.exe
    BUILTIN git-fsck-objects.exe
    BUILTIN git-cherry-pick.exe
    BUILTIN git-add.exe
    BUILTIN git-annotate.exe
    BUILTIN git-apply.exe
    BUILTIN git-archive.exe
    BUILTIN git-blame.exe
    BUILTIN git-branch.exe
    BUILTIN git-bundle.exe
    BUILTIN git-cat-file.exe
    BUILTIN git-checkout-index.exe
    BUILTIN git-check-ref-format.exe
    BUILTIN git-commit-tree.exe
    BUILTIN git-count-objects.exe
    BUILTIN git-describe.exe
    BUILTIN git-diff.exe
    BUILTIN git-diff-files.exe
    BUILTIN git-diff-index.exe
    BUILTIN git-diff-tree.exe
    BUILTIN git-fetch--tool.exe
    BUILTIN git-fmt-merge-msg.exe
    BUILTIN git-for-each-ref.exe
    BUILTIN git-gc.exe
    BUILTIN git-grep.exe
    BUILTIN git-init-db.exe
    BUILTIN git-log.exe
    BUILTIN git-ls-files.exe
    BUILTIN git-ls-tree.exe
    BUILTIN git-mailinfo.exe
    BUILTIN git-mailsplit.exe
    BUILTIN git-merge-file.exe
    BUILTIN git-mv.exe
    BUILTIN git-name-rev.exe
    BUILTIN git-pack-objects.exe
    BUILTIN git-prune.exe
    BUILTIN git-prune-packed.exe
    BUILTIN git-push.exe
    BUILTIN git-read-tree.exe
    BUILTIN git-reflog.exe
    BUILTIN git-config.exe
    BUILTIN git-rerere.exe
    BUILTIN git-rev-list.exe
    BUILTIN git-rev-parse.exe
    BUILTIN git-revert.exe
    BUILTIN git-rm.exe
    BUILTIN git-runstatus.exe
    BUILTIN git-shortlog.exe
    BUILTIN git-show-branch.exe
    BUILTIN git-stripspace.exe
    BUILTIN git-symbolic-ref.exe
    BUILTIN git-tar-tree.exe
    BUILTIN git-unpack-objects.exe
    BUILTIN git-update-index.exe
    BUILTIN git-update-ref.exe
    BUILTIN git-upload-archive.exe
    BUILTIN git-write-tree.exe
    BUILTIN git-show-ref.exe
    BUILTIN git-pack-refs.exe
rm -f 'git-convert-objects';  rm -f 'git-fetch-pack';  rm -f 'git-fsck';  rm -f 'git-hash-object';  rm -f 'git-index-pack';  rm -f 'git-local-fetch';  rm -f 'git-fast-import';  rm -f 'git-merge-base';  rm -f 'git-daemon';  rm -f 'git-merge-index';  rm -f 'git-mktag';  rm -f 'git-mktree';  rm -f 'git-patch-id';  rm -f 'git-peek-remote';  rm -f 'git-receive-pack';  rm -f 'git-send-pack';  rm -f 'git-shell';  rm -f 'git-show-index';  rm -f 'git-ssh-fetch';  rm -f 'git-ssh-upload';  rm -f 'git-unpack-file';  rm -f 'git-update-server-info';  rm -f 'git-upload-pack';  rm -f 'git-verify-pack';  rm -f 'git-pack-redundant';  rm -f 'git-var';  rm -f 'git-merge-tree';  rm -f 'git-imap-send';  rm -f 'git-merge-recursive';  rm -f 'git-ssh-pull';  rm -f 'git-ssh-push';  rm -f 'git-http-fetch';  rm -f 'git-http-push';  rm -f 'git-format-patch';  rm -f 'git-show';  rm -f 'git-whatchanged';  rm -f 'git-c
 herry';  rm -f 'git-get-tar-commit-id';  rm -f 'git-init';  rm -f 'git-repo-config';  rm -f 'git-fsck-objects';  rm -f 'git-cherry-pick';  rm -f 'git-add';  rm -f 'git-annotate';  rm -f 'git-apply';  rm -f 'git-archive';  rm -f 'git-blame';  rm -f 'git-branch';  rm -f 'git-bundle';  rm -f 'git-cat-file';  rm -f 'git-checkout-index';  rm -f 'git-check-ref-format';  rm -f 'git-commit-tree';  rm -f 'git-count-objects';  rm -f 'git-describe';  rm -f 'git-diff';  rm -f 'git-diff-files';  rm -f 'git-diff-index';  rm -f 'git-diff-tree';  rm -f 'git-fetch--tool';  rm -f 'git-fmt-merge-msg';  rm -f 'git-for-each-ref';  rm -f 'git-fsck';  rm -f 'git-gc';  rm -f 'git-grep';  rm -f 'git-init-db';  rm -f 'git-log';  rm -f 'git-ls-files';  rm -f 'git-ls-tree';  rm -f 'git-mailinfo';  rm -f 'git-mailsplit';  rm -f 'git-merge-base';  rm -f 'git-merge-file';  rm -f 'git-mv';  rm -f 'git-name-rev';  rm 
 -f 'git-pack-objects';  rm -f 'git-prune';  rm -f 'git-prune-packed';  rm -f 'git-push';  rm -f 'git-read-tree';  rm -f 'git-reflog';  rm -f 'git-config';  rm -f 'git-rerere';  rm -f 'git-rev-list';  rm -f 'git-rev-parse';  rm -f 'git-revert';  rm -f 'git-rm';  rm -f 'git-runstatus';  rm -f 'git-shortlog';  rm -f 'git-show-branch';  rm -f 'git-stripspace';  rm -f 'git-symbolic-ref';  rm -f 'git-tar-tree';  rm -f 'git-unpack-objects';  rm -f 'git-update-index';  rm -f 'git-update-ref';  rm -f 'git-upload-archive';  rm -f 'git-verify-pack';  rm -f 'git-write-tree';  rm -f 'git-show-ref';  rm -f 'git-pack-refs';  rm -f 'git';
    SUBDIR git-gui
make[1]: Nothing to be done for `all'.
    SUBDIR perl
    SUBDIR templates
install -d -m755 '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin'
install -d -m755 '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin'
install git-convert-objects.exe git-fetch-pack.exe git-fsck.exe git-hash-object.exe git-index-pack.exe git-local-fetch.exe git-fast-import.exe git-merge-base.exe git-daemon.exe git-merge-index.exe git-mktag.exe git-mktree.exe git-patch-id.exe git-peek-remote.exe git-receive-pack.exe git-send-pack.exe git-shell.exe git-show-index.exe git-ssh-fetch.exe git-ssh-upload.exe git-unpack-file.exe git-update-server-info.exe git-upload-pack.exe git-verify-pack.exe git-pack-redundant.exe git-var.exe git-merge-tree.exe git-imap-send.exe git-merge-recursive.exe  git-ssh-pull.exe git-ssh-push.exe git-http-fetch.exe git-http-push.exe git-bisect git-checkout git-clean git-clone git-commit git-fetch git-ls-remote git-merge-one-file git-mergetool git-parse-remote git-pull git-rebase git-repack git-request-pull git-reset git-sh-setup git-tag git-verify-tag git-applymbox git-applypatch git-am git-merge git-
 merge-stupid git-merge-octopus git-merge-resolve git-merge-ours git-lost-found git-quiltimport git-add--interactive git-archimport git-cvsimport git-relink git-cvsserver git-remote git-svnimport git-cvsexportcommit git-send-email git-svn git-status git-instaweb '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin'
install git.exe gitk '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin'
/usr/bin/make -C templates DESTDIR='/usr/src/build/build/git/git-1.5.1.3/.inst' install
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/templates'
install -d -m755 '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/share/git-core/templates/'
(cd blt && tar cf - .) | \
        (cd '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/share/git-core/templates/' && tar xf -)
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/templates'
/usr/bin/make -C perl prefix='/usr' install
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/perl'
make[2]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/perl'
Installing /usr/src/build/build/git/git-1.5.1.3/.inst/usr/lib/perl5/site_perl/5.8/Git.pm
Writing /usr/src/build/build/git/git-1.5.1.3/.inst/usr/lib/perl5/site_perl/5.8/cygwin/auto/Git/.packlist
Appending installation info to /usr/src/build/build/git/git-1.5.1.3/.inst/usr/lib/perl5/5.8/cygwin/perllocal.pod
make[2]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/perl'
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/perl'
/usr/bin/make -C git-gui install
make[1]: Entering directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/git-gui'
install -d -m755 '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin'
install git-gui '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin'
rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-citool' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-gui' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-citool' ;
make[1]: Leaving directory `/usr/src/build/build/git/git-1.5.1.3/.build/build/git-gui'
if test 'z/usr/bin' != 'z/usr/bin'; \
        then \
                ln -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' \
                        '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' || \
                cp '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' \
                        '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe'; \
        fi
rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-format-patch.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-format-patch.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-whatchanged.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-whatchanged.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cherry.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cherry.exe' ;  rm -f '/usr/src/build/build/git/gi
 t-1.5.1.3/.inst/usr/bin/git-get-tar-commit-id.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-get-tar-commit-id.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-init.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-init.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-repo-config.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-repo-config.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck-objects.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck-objects.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/
 .inst/usr/bin/git-cherry-pick.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cherry-pick.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-add.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-add.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-annotate.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-annotate.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-apply.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-apply.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-archive.exe' && ln '/usr/s
 rc/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-archive.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-blame.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-blame.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-branch.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-branch.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-bundle.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-bundle.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cat-file.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.
 exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cat-file.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-checkout-index.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-checkout-index.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-check-ref-format.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-check-ref-format.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-commit-tree.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-commit-tree.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-count-objects.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin
 /git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-count-objects.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-describe.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-describe.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-files.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-files.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-index.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build
 /git/git-1.5.1.3/.inst/usr/bin/git-diff-index.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-tree.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-tree.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fetch--tool.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fetch--tool.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fmt-merge-msg.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fmt-merge-msg.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-for-each-ref.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1
 .5.1.3/.inst/usr/bin/git-for-each-ref.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-gc.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-gc.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-grep.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-grep.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-init-db.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-init-db.exe' ;  rm -f '/usr/src/bu
 ild/build/git/git-1.5.1.3/.inst/usr/bin/git-log.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-log.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ls-files.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ls-files.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ls-tree.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ls-tree.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mailinfo.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mailinfo.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ma
 ilsplit.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mailsplit.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-base.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-base.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-file.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-file.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mv.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mv.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-name-rev.exe' && ln '/usr/src/build/bu
 ild/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-name-rev.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-objects.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-objects.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-prune.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-prune.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-prune-packed.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-prune-packed.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-push.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/us
 r/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-push.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-read-tree.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-read-tree.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-reflog.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-reflog.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-config.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-config.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rerere.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1
 .5.1.3/.inst/usr/bin/git-rerere.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rev-list.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rev-list.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rev-parse.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rev-parse.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-revert.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-revert.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rm.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rm.exe' ;  rm -f '/
 usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-runstatus.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-runstatus.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-shortlog.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-shortlog.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show-branch.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show-branch.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-stripspace.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-stripspace.exe' ;  rm -f '/usr/src/build/build/gi
 t/git-1.5.1.3/.inst/usr/bin/git-symbolic-ref.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-symbolic-ref.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-tar-tree.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-tar-tree.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-unpack-objects.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-unpack-objects.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-update-index.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-update-index.exe' ;  rm -f '/usr/src/build/build/git/git-
 1.5.1.3/.inst/usr/bin/git-update-ref.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-update-ref.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-upload-archive.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-upload-archive.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-verify-pack.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-verify-pack.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-write-tree.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-write-tree.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/
 .inst/usr/bin/git-show-ref.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show-ref.exe' ;  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-refs.exe' && ln '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git.exe' '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-refs.exe' ;
rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-convert-objects';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fetch-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-hash-object';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-index-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-local-fetch';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fast-import';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-base';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-daemon';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-index';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mktag';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mktree';
   rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-patch-id';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-peek-remote';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-receive-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-send-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-shell';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show-index';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ssh-fetch';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ssh-upload';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-unpack-file';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-update-server-info';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-upload-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bi
 n/git-verify-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-redundant';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-var';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-imap-send';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-recursive';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ssh-pull';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ssh-push';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-http-fetch';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-http-push';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-format-patch';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst
 /usr/bin/git-whatchanged';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cherry';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-get-tar-commit-id';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-init';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-repo-config';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck-objects';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cherry-pick';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-add';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-annotate';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-apply';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-archive';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-blame';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/b
 in/git-branch';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-bundle';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-cat-file';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-checkout-index';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-check-ref-format';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-commit-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-count-objects';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-describe';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-files';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-index';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-diff-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.i
 nst/usr/bin/git-fetch--tool';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fmt-merge-msg';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-for-each-ref';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-fsck';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-gc';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-grep';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-init-db';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-log';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ls-files';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-ls-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mailinfo';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mailsplit';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-me
 rge-base';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-merge-file';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-mv';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-name-rev';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-objects';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-prune';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-prune-packed';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-push';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-read-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-reflog';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-config';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rerere';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rev-list';  rm -f 
 '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rev-parse';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-revert';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-rm';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-runstatus';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-shortlog';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show-branch';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-stripspace';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-symbolic-ref';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-tar-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-unpack-objects';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-update-index';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-update-ref';  r
 m -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-upload-archive';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-verify-pack';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-write-tree';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-show-ref';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git-pack-refs';  rm -f '/usr/src/build/build/git/git-1.5.1.3/.inst/usr/bin/git';
