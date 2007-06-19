From: Bill Lear <rael@zopyra.com>
Subject: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 07:37:38 -0500
Message-ID: <18039.52754.563688.907038@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 14:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0cxv-0004B6-Aw
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 14:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbXFSMhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 08:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbXFSMhp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 08:37:45 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61787 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbXFSMho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 08:37:44 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JCbiT15497;
	Tue, 19 Jun 2007 07:37:44 -0500
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50476>

Also breaks (tar fails) if I do the 'make configure; ./configure'
route.  This is my third try to send this.  I sent also to Junio
yesterday, but no response.

% uname -a Linux blake 2.6.18-8.1.4.el5xen #1 SMP Thu May 17 03:43:13 EDT 2007 x86_64 x86_64 x86_64 GNU/Linux

% gcc --version
gcc (GCC) 4.1.1 20070105 (Red Hat 4.1.1-52)

% make prefix=/opt/git-1.5.2.2 all doc
GIT_VERSION = 1.5.2.2-dirty
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
    CC patch-ids.o
    CC object.o
    CC pack-check.o
    CC pack-write.o
    CC patch-delta.o
    CC path.o
    CC pkt-line.o
    CC sideband.o
    CC reachable.o
    CC reflog-walk.o
    CC quote.o
    CC read-cache.o
    CC refs.o
    CC run-command.o
    CC dir.o
    CC object-refs.o
    CC server-info.o
    CC setup.o
    CC sha1_file.o
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
    CC match-trees.o
    CC alloc.o
    CC merge-file.o
    CC path-list.o
    GEN common-cmds.h
    CC help.o
    CC unpack-trees.o
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
    CC convert.o
    CC attr.o
    CC decorate.o
    CC progress.o
    CC mailmap.o
    CC symlinks.o
    CC compat/strlcpy.o
    AR libgit.a
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    AR xdiff/lib.a
    LINK git-convert-objects
libgit.a(utf8.o): In function `reencode_string':
/home/blear/build/git-1.5.2.2/utf8.c:317: undefined reference to `libiconv_open'
/home/blear/build/git-1.5.2.2/utf8.c:328: undefined reference to `libiconv'
/home/blear/build/git-1.5.2.2/utf8.c:353: undefined reference to `libiconv_close'
/home/blear/build/git-1.5.2.2/utf8.c:334: undefined reference to `libiconv_close'
collect2: ld returned 1 exit status
make: *** [git-convert-objects] Error 1


Bill
