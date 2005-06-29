From: David Woodhouse <dwmw2@infradead.org>
Subject: Today's kernel git snapshot broke.
Date: Wed, 29 Jun 2005 21:55:34 +0100
Message-ID: <1120078535.3690.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-JISjl+sxKfZ1CjWL/mBR"
X-From: git-owner@vger.kernel.org Wed Jun 29 22:54:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnjZ4-0003gJ-1T
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 22:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVF2VAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVF2U70
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 16:59:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55519 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262648AbVF2U5K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 16:57:10 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DnjcC-0001Db-4j
	for git@vger.kernel.org; Wed, 29 Jun 2005 21:57:09 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-JISjl+sxKfZ1CjWL/mBR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

What happened here...

(Script at http://david.woodhou.se/git-snapshot.sh)

-- 
dwmw2

--=-JISjl+sxKfZ1CjWL/mBR
Content-Disposition: inline
Content-Description: Forwarded message - Cron <dwmw2@hera>
	/home/dwmw2/bin/git-snapshot.sh
Content-Type: message/rfc822

Return-path: <dwmw2@hera.kernel.org>
Envelope-to: dwmw2@baythorne.infradead.org
Delivery-date: Wed, 29 Jun 2005 11:11:12 +0100
Received: from [2002:d592:9a28::1] (helo=pentafluge.infradead.org) by
	baythorne.infradead.org with esmtps (Exim 4.51 #1 (Red Hat Linux)) id
	1DnZXD-0002Sf-Vn for dwmw2@baythorne.infradead.org; Wed, 29 Jun 2005
	11:11:12 +0100
Received: from hera.kernel.org ([209.128.68.125]) by
	pentafluge.infradead.org with esmtps (Exim 4.43 #1 (Red Hat Linux)) id
	1DnZXB-0005LL-PH for dwmw2-forward@infradead.org; Wed, 29 Jun 2005 11:11:11
	+0100
Received: from hera.kernel.org (localhost [127.0.0.1]) by hera.kernel.org
	(8.13.1/8.13.1) with ESMTP id j5TAB51s030847 for <dwmw2@hera.kernel.org>;
	Wed, 29 Jun 2005 03:11:06 -0700
Received: (from dwmw2@localhost) by hera.kernel.org (8.13.1/8.13.1/Submit)
	id j5T91219026133; Wed, 29 Jun 2005 02:01:02 -0700
Date: Wed, 29 Jun 2005 02:01:02 -0700
Message-Id: <200506290901.j5T91219026133@hera.kernel.org>
From: root@hera.kernel.org (Cron Daemon)
To: dwmw2@hera.kernel.org
Subject: Cron <dwmw2@hera> /home/dwmw2/bin/git-snapshot.sh
X-Cron-Env: <SHELL=/bin/sh>
X-Cron-Env: <HOME=/home/dwmw2>
X-Cron-Env: <PATH=/usr/bin:/bin>
X-Cron-Env: <LOGNAME=dwmw2>
X-Cron-Env: <USER=dwmw2>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on
	localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.1
X-Spam-Checker-Version: SpamAssassin 3.0.1 (2004-10-22) on hera.kernel.org
X-Spam-Score: 0.0 (/)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

+ case `hostname` in
++ hostname
+ export PATH=/home/dwmw2/cogito:/usr/bin:/bin
+ PATH=/home/dwmw2/cogito:/usr/bin:/bin
+ export BASE_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+ BASE_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+ STAGINGLOCK=/staging/upload.lock
+ FINAL=/pub/linux/kernel/v2.6/snapshots
+ '[' '!' -d /pub/scm/linux/kernel/git/torvalds/linux-2.6.git ']'
+ export WORK_DIRECTORY=/home/dwmw2/snapshots/2.6
+ WORK_DIRECTORY=/home/dwmw2/snapshots/2.6
+ export SNAP_TAG_DIRECTORY=/home/dwmw2/snapshots/2.6/tags
+ SNAP_TAG_DIRECTORY=/home/dwmw2/snapshots/2.6/tags
+ export STAGE=/home/dwmw2/snapshots/2.6/stage
+ STAGE=/home/dwmw2/snapshots/2.6/stage
+ export SHA1_FILE_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
+ SHA1_FILE_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
++ ls -rt /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.11 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.11-tree /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc2 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc3 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc4 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc5 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc6 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.13-rc1
++ tail -n1
++ sed s:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v::
+ RELNAME=2.6.13-rc1
++ cat /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.13-rc1
+ RELOBJ=733ad933f62e82ebc92fed988c7f0795e64dea62
++ tail -n1
++ sed s:/home/dwmw2/snapshots/2.6/tags/v::
++ ls -rt '/home/dwmw2/snapshots/2.6/tags/v2.6.13-rc1-git*'
ls: /home/dwmw2/snapshots/2.6/tags/v2.6.13-rc1-git*: No such file or directory
+ SNAPNAME=
+ '[' '' == '' ']'
+ LASTOBJ=733ad933f62e82ebc92fed988c7f0795e64dea62
+ CURNAME=2.6.13-rc1-git1
++ tree-id 733ad933f62e82ebc92fed988c7f0795e64dea62
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/73/3ad933f62e82ebc92fed988c7f0795e64dea62: No such file or directory
fatal: git-cat-file 733ad933f62e82ebc92fed988c7f0795e64dea62: bad file
Invalid id: 733ad933f62e82ebc92fed988c7f0795e64dea62
usage: git-cat-file [-t | tagname] <sha1>
usage: git-cat-file [-t | tagname] <sha1>
Invalid id: 
+ LASTTREE=
++ cat /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD
+ CURCOMM=4c91aedb75d1b87deccf16d58f67fb46402d7d44
++ tree-id 4c91aedb75d1b87deccf16d58f67fb46402d7d44
+ CURTREE=9fba45e2b1a769b0f984fa7b780020256ed3b9ba
++ tree-id 733ad933f62e82ebc92fed988c7f0795e64dea62
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/73/3ad933f62e82ebc92fed988c7f0795e64dea62: No such file or directory
fatal: git-cat-file 733ad933f62e82ebc92fed988c7f0795e64dea62: bad file
Invalid id: 733ad933f62e82ebc92fed988c7f0795e64dea62
usage: git-cat-file [-t | tagname] <sha1>
usage: git-cat-file [-t | tagname] <sha1>
Invalid id: 
+ RELTREE=
+ echo release 2.6.13-rc1 commit tree
release 2.6.13-rc1 commit tree
++ git-cat-file -t 733ad933f62e82ebc92fed988c7f0795e64dea62
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/73/3ad933f62e82ebc92fed988c7f0795e64dea62: No such file or directory
fatal: git-cat-file 733ad933f62e82ebc92fed988c7f0795e64dea62: bad file
+ echo last 733ad933f62e82ebc92fed988c7f0795e64dea62 tree
last 733ad933f62e82ebc92fed988c7f0795e64dea62 tree
+ echo head 4c91aedb75d1b87deccf16d58f67fb46402d7d44 tree 9fba45e2b1a769b0f984fa7b780020256ed3b9ba
head 4c91aedb75d1b87deccf16d58f67fb46402d7d44 tree 9fba45e2b1a769b0f984fa7b780020256ed3b9ba
+ '[' '' == 9fba45e2b1a769b0f984fa7b780020256ed3b9ba ']'
++ echo 2.6.13-rc1-git1
++ cut -f2- -d-
+ EXTRAVERSION=-rc1-git1
+ cd /home/dwmw2/snapshots/2.6/stage
+ rm -rf tmp-empty-tree
+ mkdir -p tmp-empty-tree/.git
+ cd tmp-empty-tree
+ git-read-tree 4c91aedb75d1b87deccf16d58f67fb46402d7d44
+ git-checkout-cache Makefile
+ perl -pi -e 's/EXTRAVERSION =.*/EXTRAVERSION = -rc1-git1/' Makefile
+ git-diff-cache -m -p
+ gzip -9
usage: diff-cache [-r] [-z] [-p] [-i] [--cached] <tree sha1>
+ echo 4c91aedb75d1b87deccf16d58f67fb46402d7d44
+ cg-log 733ad933f62e82ebc92fed988c7f0795e64dea62:4c91aedb75d1b87deccf16d58f67fb46402d7d44
mv: cannot stat `.git/heads': No such file or directory
mv: cannot stat `.git/tags': No such file or directory
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/73/3ad933f62e82ebc92fed988c7f0795e64dea62: No such file or directory
fatal: git-cat-file 733ad933f62e82ebc92fed988c7f0795e64dea62: bad file
Invalid id: 733ad933f62e82ebc92fed988c7f0795e64dea62
+ echo 4c91aedb75d1b87deccf16d58f67fb46402d7d44
+ echo New Snapshot 2.6.13-rc1-git1
New Snapshot 2.6.13-rc1-git1
+ '[' -z /pub/linux/kernel/v2.6/snapshots ']'
+ '[' -r /staging/upload.lock ']'
+ exec
+ flock -s 200
+ mv -v /home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc1-git1.gz /home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc1-git1.id /home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc1-git1.log /pub/linux/kernel/v2.6/snapshots
`/home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc1-git1.gz' -> `/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-rc1-git1.gz'
`/home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc1-git1.id' -> `/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-rc1-git1.id'
`/home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc1-git1.log' -> `/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-rc1-git1.log'

--=-JISjl+sxKfZ1CjWL/mBR--
