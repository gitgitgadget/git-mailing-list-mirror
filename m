From: dave morgan <morgad@eclipse.co.uk>
Subject: problem compiling tonights Git
Date: Thu, 02 Feb 2006 18:41:30 +0000
Organization: the great unwashed
Message-ID: <i6k4u1p8jnuq0anj0v59bep2r6itnqk2ru@4ax.com>
Reply-To: david morgan <morgad@eclipse.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Thu Feb 02 19:42:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4jOl-00046G-Tg
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 19:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWBBSld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 13:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWBBSld
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 13:41:33 -0500
Received: from mra03.ch.as12513.net ([82.153.252.25]:3819 "EHLO
	mra03.ch.as12513.net") by vger.kernel.org with ESMTP
	id S1750973AbWBBSld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 13:41:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mra03.ch.as12513.net (Postfix) with ESMTP id 9B728D4282
	for <git@vger.kernel.org>; Thu,  2 Feb 2006 18:41:31 +0000 (GMT)
Received: from mra03.ch.as12513.net ([127.0.0.1])
 by localhost (mra03.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 09880-01-71 for <git@vger.kernel.org>;
 Thu,  2 Feb 2006 18:41:30 +0000 (GMT)
Received: from unknown (unknown [82.152.150.47])
	by mra03.ch.as12513.net (Postfix) with SMTP id 6A813D41EF
	for <git@vger.kernel.org>; Thu,  2 Feb 2006 18:41:30 +0000 (GMT)
To: git@vger.kernel.org
X-Mailer: Forte Agent 3.2/32.830
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15514>

Debian/testing system, 2.6.15 Kernel, AMD Athlon CPU @ 1Ghz, 512Mb RAM
(some of the following lines re-wrapped by my mailer)

david@tower2:~/git$ cg-update -v
Fetching head...
Fetching objects...
progress: 28 objects, 107898 bytes
Fetching tags...
Tree change:
8233340ce6eb700eb2cd9c0fef4d1705997c499b:823bcd6edc7f7330714486b228b052953c2f4229

Applying changes...
Fast-forwarding 8233340ce6eb700eb2cd9c0fef4d1705997c499b ->
823bcd6edc7f7330714486b228b052953c2f4229
        on top of 8233340ce6eb700eb2cd9c0fef4d1705997c499b...
:100644 100644 243f967... 36363bd... M  combine-diff.c
:100644 100644 8ae6dbc... ec51e7d... M  diff.c
:100755 100755 6e3a44a... b6799d8... M  git-svnimport.perl
:100644 100644 92326f9... 97ce13c... M  http-fetch.c
:100644 100644 ad0eafe... f92b960... M  index.c
:100644 100644 1bc1887... a554e07... M  rev-list.c
:100644 100644 a84a04f... afec98d... M  update-index.c
david@tower2:~/git$ make install
GIT_VERSION = 1.1.6.g823b
gcc -o index.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' index.c
gcc -o diff.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  diff.c
gcc -o combine-diff.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'
combine-diff.c
ar rcs libgit.a blob.o commit.o connect.o count-delta.o csum-file.o
date.o diff-delta.o entry.o exec_cmd.o ident.o index.o object.o
pack-check.o patch-delta.o path.o pkt-line.o quote.o read-cache.o
refs.o run-command.o server-info.o setup.o sha1_file.o sha1_name.o
strbuf.o tag.o tree.o usage.o config.o environment.o ctype.o copy.o
fetch-clone.o diff.o diffcore-break.o diffcore-order.o
diffcore-pathspec.o diffcore-pickaxe.o diffcore-rename.o tree-diff.o
combine-diff.o epoch.o
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-apply apply.o
libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-cat-file
cat-file.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o
git-checkout-index  checkout-index.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-clone-pack
clone-pack.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-commit-tree
commit-tree.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o
git-convert-objects  convert-objects.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-diff-files
diff-files.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-diff-index
diff-index.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-diff-stages
diff-stages.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-diff-tree
diff-tree.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-fetch-pack
fetch-pack.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-fsck-objects
fsck-objects.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-hash-object
hash-object.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-index-pack
index-pack.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-init-db
init-db.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-local-fetch
local-fetch.o fetch.o libgit.a -lz  -lcrypto
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -o git-ls-files
ls-files.o libgit.a -lz  -lcrypto
collect2: ld terminated with signal 11 [Segmentation fault]
make: *** [git-ls-files] Error 1


david@tower2:~/git$ ld --version
GNU ld version 2.16.91 20051214 Debian GNU/Linux
Copyright 2005 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of
the GNU General Public License.  This program has absolutely no
warranty.


is this a problem with git-ls-files, or my toolchain?

best regards
Dave
