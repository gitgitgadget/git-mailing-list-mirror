From: Melton Low <softw.devl@gmail.com>
Subject: Build error with 1.7.2 and 1.7.2.1 on PPC Mac OS X 10.4
Date: Wed, 28 Jul 2010 21:10:29 -0600
Message-ID: <6E0EF82C-2938-4149-A277-D51BC046B4E2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: multipart/mixed; boundary=Apple-Mail-1--729364758
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 06:12:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeKTj-0001KE-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 06:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824Ab0G2EMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 00:12:12 -0400
Received: from mail-pv0-f194.google.com ([74.125.83.194]:49252 "EHLO
	mail-pv0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab0G2EML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 00:12:11 -0400
X-Greylist: delayed 3698 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2010 00:12:11 EDT
Received: by pvc7 with SMTP id 7so22640pvc.1
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:content-type
         :message-id:date:to:mime-version:x-mailer;
        bh=0V1aIQe9h1YWLBTdH9W7+nG6NZmL8pul5b1VT+rvEYI=;
        b=wd2zl5ULnKn9jvSrjhsTQWy4CkoguY5WgM/R77c1T3uiE1tuqQQN0Hg/2xNpUjRFCg
         rjw7bPu04rMoaqA8fZgAE9pWEuee1f5JFxFW3N795x4w5/N4aoBU2Q0QmM5PJ7Hm/9XL
         UJCtkrxJxM9LVCl/6/nd+ZMIEhqKilIq/l6S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:content-type:message-id:date:to:mime-version:x-mailer;
        b=VTvWgfW81l+ghNu6h9QP9hnClMlIbqdkk91CzyzuY44+NUzzzIIhMJRrHUfHVqoCzJ
         mBb8XlygDtTNHpT1p82injbTEBdTnxLzvgJqLBvK0OLQL910tfxJ/47KotUg7TokIYm9
         rCCbAL4mUaH+cMNoO7jUfpuJcuFy2Qg8icMmg=
Received: by 10.114.109.8 with SMTP id h8mr16515573wac.208.1280373033248;
        Wed, 28 Jul 2010 20:10:33 -0700 (PDT)
Received: from [192.168.1.101] (S010690840de80d96.cg.shawcable.net [70.72.31.86])
        by mx.google.com with ESMTPS id g4sm567082wae.2.2010.07.28.20.10.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 20:10:32 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152156>


--Apple-Mail-1--729364758
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

Error during build on 1.7.2.  I just tried building 1.7.2.1 with the =
same error.  A partial output from my attempt to build 1.7.2.1:

    * new build flags or prefix
    CC fast-import.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC abspath.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC advice.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'

The full error log is attached.  I have also attached the configure log. =
 Configure did not report any problem for both version.

No problem building version 1.7.1.2 released today.

The steps I used to:

make configure
./configure --prefix=3D/usr/local
make all

My environment is:
PPC Mac
Mac OS X 10.4.11

Any help would be appreciated.

Regards, Mel=

--Apple-Mail-1--729364758
Content-Disposition: attachment;
	filename=git-build.txt
Content-Type: text/plain;
	x-unix-mode=0600;
	name="git-build.txt"
Content-Transfer-Encoding: 7bit

    * new build flags or prefix
    CC fast-import.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC abspath.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC advice.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC alias.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC alloc.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC archive.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC archive-tar.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC archive-zip.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC attr.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC base85.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC bisect.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC blob.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC branch.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC bundle.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC cache-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC color.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC combine-diff.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC commit.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC config.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC connect.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC convert.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC copy.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC csum-file.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC ctype.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC date.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC decorate.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diffcore-break.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diffcore-delta.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diffcore-order.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diffcore-pickaxe.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diffcore-rename.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diff-delta.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diff-lib.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diff-no-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC diff.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC dir.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC editor.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC entry.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC environment.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC exec_cmd.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC fsck.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC graph.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC grep.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC hash.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC help.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC hex.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC ident.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC levenshtein.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC list-objects.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC ll-merge.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC lockfile.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC log-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC mailmap.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC match-trees.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC merge-file.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC merge-recursive.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC name-hash.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC notes.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC notes-cache.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC object.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pack-check.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pack-refs.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pack-revindex.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pack-write.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pager.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC parse-options.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC patch-delta.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC patch-ids.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC path.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pkt-line.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC preload-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC pretty.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC progress.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC quote.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC reachable.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC read-cache.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC reflog-walk.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC refs.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC remote.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC replace_object.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC rerere.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC resolve-undo.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC revision.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC run-command.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC server-info.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC setup.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC sha1-lookup.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC sha1_file.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC sha1_name.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC shallow.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC sideband.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC sigchain.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC strbuf.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC string-list.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC submodule.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC symlinks.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC tag.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC trace.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC transport.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC transport-helper.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC tree-diff.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC tree-walk.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC unpack-trees.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC url.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC usage.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC userdiff.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC utf8.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC walker.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC wrapper.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC write_or_die.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC ws.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC wt-status.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC xdiff-interface.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC thread-utils.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC compat/memmem.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    AR libgit.a
    CC xdiff/xdiffi.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC xdiff/xprepare.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC xdiff/xutils.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC xdiff/xemit.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC xdiff/xmerge.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC xdiff/xpatience.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    AR xdiff/lib.a
    LINK git-fast-import
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC imap-send.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-imap-send
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC shell.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-shell
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC show-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-show-index
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC upload-pack.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-upload-pack
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC http-backend.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-http-backend
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC http.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC http-walker.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC http-fetch.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-http-fetch
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC http-push.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-http-push
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC daemon.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-daemon
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC remote-curl.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git-remote-http
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LN/CP git-remote-https
    LN/CP git-remote-ftp
    LN/CP git-remote-ftps
    GEN git-am
    GEN git-bisect
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-lost-found
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-pull
    GEN git-quiltimport
    GEN git-rebase--interactive
    GEN git-rebase
    GEN git-repack
    GEN git-request-pull
    GEN git-stash
    GEN git-submodule
    GEN git-web--browse
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX='/usr/local'
Writing perl.mak for Git
    GEN git-add--interactive
    GEN git-difftool
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-relink
    GEN git-send-email
    GEN git-svn
    GEN git-remote-testgit
    SUBDIR gitweb
    SUBDIR ../
make[2]: `GIT-VERSION-FILE' is up to date.
    GEN gitweb.cgi
    GEN git-instaweb
    GEN git-mergetool--lib
    GEN git-parse-remote
    GEN git-sh-setup
    GEN common-cmds.h
    CC git.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/add.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/annotate.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/apply.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/archive.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/bisect--helper.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/blame.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/branch.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/bundle.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/cat-file.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/check-attr.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/check-ref-format.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/checkout-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/checkout.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/clean.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/clone.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/commit-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/commit.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/config.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/count-objects.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/describe.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/diff-files.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/diff-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/diff-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/diff.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/fast-export.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/fetch-pack.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/fetch.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/fmt-merge-msg.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/for-each-ref.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/fsck.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/gc.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/grep.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/hash-object.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/help.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/index-pack.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/init-db.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/log.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/ls-files.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/ls-remote.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/ls-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/mailinfo.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/mailsplit.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge-base.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge-file.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge-ours.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge-recursive.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/merge-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/mktag.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/mktree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/mv.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/name-rev.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/notes.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/pack-objects.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/pack-redundant.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/pack-refs.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/patch-id.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/prune-packed.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/prune.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/push.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/read-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/receive-pack.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/reflog.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/remote.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/replace.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/rerere.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/reset.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/rev-list.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/rev-parse.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/revert.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/rm.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/send-pack.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/shortlog.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/show-branch.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/show-ref.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/stripspace.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/symbolic-ref.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/tag.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/tar-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/unpack-file.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/unpack-objects.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/update-index.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/update-ref.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/update-server-info.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/upload-archive.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/var.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/verify-pack.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/verify-tag.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC builtin/write-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK git
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    BUILTIN git-add
    BUILTIN git-annotate
    BUILTIN git-apply
    BUILTIN git-archive
    BUILTIN git-bisect--helper
    BUILTIN git-blame
    BUILTIN git-branch
    BUILTIN git-bundle
    BUILTIN git-cat-file
    BUILTIN git-check-attr
    BUILTIN git-check-ref-format
    BUILTIN git-checkout-index
    BUILTIN git-checkout
    BUILTIN git-clean
    BUILTIN git-clone
    BUILTIN git-commit-tree
    BUILTIN git-commit
    BUILTIN git-config
    BUILTIN git-count-objects
    BUILTIN git-describe
    BUILTIN git-diff-files
    BUILTIN git-diff-index
    BUILTIN git-diff-tree
    BUILTIN git-diff
    BUILTIN git-fast-export
    BUILTIN git-fetch-pack
    BUILTIN git-fetch
    BUILTIN git-fmt-merge-msg
    BUILTIN git-for-each-ref
    BUILTIN git-fsck
    BUILTIN git-gc
    BUILTIN git-grep
    BUILTIN git-hash-object
    BUILTIN git-help
    BUILTIN git-index-pack
    BUILTIN git-init-db
    BUILTIN git-log
    BUILTIN git-ls-files
    BUILTIN git-ls-remote
    BUILTIN git-ls-tree
    BUILTIN git-mailinfo
    BUILTIN git-mailsplit
    BUILTIN git-merge
    BUILTIN git-merge-base
    BUILTIN git-merge-file
    BUILTIN git-merge-index
    BUILTIN git-merge-ours
    BUILTIN git-merge-recursive
    BUILTIN git-merge-tree
    BUILTIN git-mktag
    BUILTIN git-mktree
    BUILTIN git-mv
    BUILTIN git-name-rev
    BUILTIN git-notes
    BUILTIN git-pack-objects
    BUILTIN git-pack-redundant
    BUILTIN git-pack-refs
    BUILTIN git-patch-id
    BUILTIN git-prune-packed
    BUILTIN git-prune
    BUILTIN git-push
    BUILTIN git-read-tree
    BUILTIN git-receive-pack
    BUILTIN git-reflog
    BUILTIN git-remote
    BUILTIN git-replace
    BUILTIN git-rerere
    BUILTIN git-reset
    BUILTIN git-rev-list
    BUILTIN git-rev-parse
    BUILTIN git-revert
    BUILTIN git-rm
    BUILTIN git-send-pack
    BUILTIN git-shortlog
    BUILTIN git-show-branch
    BUILTIN git-show-ref
    BUILTIN git-stripspace
    BUILTIN git-symbolic-ref
    BUILTIN git-tag
    BUILTIN git-tar-tree
    BUILTIN git-unpack-file
    BUILTIN git-unpack-objects
    BUILTIN git-update-index
    BUILTIN git-update-ref
    BUILTIN git-update-server-info
    BUILTIN git-upload-archive
    BUILTIN git-var
    BUILTIN git-verify-pack
    BUILTIN git-verify-tag
    BUILTIN git-write-tree
    BUILTIN git-cherry
    BUILTIN git-cherry-pick
    BUILTIN git-format-patch
    BUILTIN git-fsck-objects
    BUILTIN git-get-tar-commit-id
    BUILTIN git-init
    BUILTIN git-merge-subtree
    BUILTIN git-peek-remote
    BUILTIN git-repo-config
    BUILTIN git-show
    BUILTIN git-stage
    BUILTIN git-status
    BUILTIN git-whatchanged
    SUBDIR git-gui
GITGUI_VERSION = 0.12.0.64.g89d6
    * new locations or Tcl/Tk interpreter
    GEN git-gui
    INDEX lib/
    MSGFMT    po/de.msg 520 translated.
    MSGFMT    po/el.msg 381 translated, 4 fuzzy, 6 untranslated.
    MSGFMT    po/fr.msg 520 translated.
    MSGFMT    po/hu.msg 514 translated.
    MSGFMT    po/it.msg 519 translated, 1 untranslated.
    MSGFMT    po/ja.msg 520 translated.
    MSGFMT    po/nb.msg 474 translated, 39 untranslated.
    MSGFMT    po/ru.msg 513 translated, 2 untranslated.
    MSGFMT    po/sv.msg 520 translated.
    MSGFMT po/zh_cn.msg 366 translated, 7 fuzzy, 17 untranslated.
    SUBDIR gitk-git
    GEN gitk-wish
Generating catalog po/de.msg
msgfmt --statistics --tcl po/de.po -l de -d po/
289 translated messages.
Generating catalog po/es.msg
msgfmt --statistics --tcl po/es.po -l es -d po/
200 translated messages, 7 untranslated messages.
Generating catalog po/fr.msg
msgfmt --statistics --tcl po/fr.po -l fr -d po/
276 translated messages, 4 fuzzy translations.
Generating catalog po/hu.msg
msgfmt --statistics --tcl po/hu.po -l hu -d po/
288 translated messages.
Generating catalog po/it.msg
msgfmt --statistics --tcl po/it.po -l it -d po/
283 translated messages, 6 untranslated messages.
Generating catalog po/ja.msg
msgfmt --statistics --tcl po/ja.po -l ja -d po/
284 translated messages.
Generating catalog po/ru.msg
msgfmt --statistics --tcl po/ru.po -l ru -d po/
245 translated messages.
Generating catalog po/sv.msg
msgfmt --statistics --tcl po/sv.po -l sv -d po/
289 translated messages.
    SUBDIR perl
cp private-Error.pm blib/lib/Error.pm
cp Git.pm blib/lib/Git.pm
Manifying blib/man3/private-Error.3pm
Manifying blib/man3/Git.3pm
    SUBDIR git_remote_helpers
    SUBDIR templates
    CC test-chmtime.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-chmtime
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-ctype.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-ctype
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-date.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-date
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-delta.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-delta
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-dump-cache-tree.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-dump-cache-tree
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-genrandom.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-genrandom
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-match-trees.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-match-trees
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-parse-options.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-parse-options
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-path-utils.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-path-utils
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-run-command.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-run-command
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-sha1.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-sha1
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-sigchain.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-sigchain
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    CC test-index-version.o
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    LINK test-index-version
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
    GEN bin-wrappers/git
    GEN bin-wrappers/git-upload-pack
    GEN bin-wrappers/git-receive-pack
    GEN bin-wrappers/git-upload-archive
    GEN bin-wrappers/git-shell
    GEN bin-wrappers/git-cvsserver
    GEN bin-wrappers/test-chmtime
    GEN bin-wrappers/test-ctype
    GEN bin-wrappers/test-date
    GEN bin-wrappers/test-delta
    GEN bin-wrappers/test-dump-cache-tree
    GEN bin-wrappers/test-genrandom
    GEN bin-wrappers/test-match-trees
    GEN bin-wrappers/test-parse-options
    GEN bin-wrappers/test-path-utils
    GEN bin-wrappers/test-run-command
    GEN bin-wrappers/test-sha1
    GEN bin-wrappers/test-sigchain
    GEN bin-wrappers/test-index-version

--Apple-Mail-1--729364758
Content-Disposition: attachment;
	filename=git-configure.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="git-configure.txt"
Content-Transfer-Encoding: 7bit

BigMac:~/Downloads/git-1.7.2.1 melton$ make configure
GIT_VERSION = 1.7.2.1
make: `configure' is up to date.
BigMac:~/Downloads/git-1.7.2.1 melton$ ./configure --prefix=/usr/local
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
configure: CHECKS for programs
checking for cc... cc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether cc accepts -g... yes
checking for cc option to accept ISO C89... none needed
checking for inline... inline
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... no
checking if linker supports -rpath... no
configure: WARNING: linker does not support runtime path to dynamic libraries
checking for gar... no
checking for ar... ar
checking for gtar... no
checking for tar... tar
checking for gnudiff... no
checking for gdiff... no
checking for diff... diff
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for curl_global_init in -lcurl... yes
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -lc... no
checking for iconv in -liconv... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for inet_ntop... yes
checking for inet_pton... yes
checking for hstrerror... yes
checking for basename in -lc... yes
configure: CHECKS for header files
checking how to run the C preprocessor... cc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking for old iconv()... yes
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking whether formatted IO functions support C99 size specifiers... yes
checking whether system succeeds to read fopen'ed directory... no
checking whether snprintf() and/or vsnprintf() return bogus value... no
configure: CHECKS for library functions
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking paths.h usability... yes
checking paths.h presence... yes
checking for paths.h... yes
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for memmem... no
checking for strlcpy... yes
checking for library containing strlcpy... none required
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for mkstemps... yes
checking for library containing mkstemps... none required
checking Checking for POSIX Threads with '-mt'... no
checking Checking for POSIX Threads with '-pthread'... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
BigMac:~/Downloads/git-1.7.2.1 melton$ 

--Apple-Mail-1--729364758--
