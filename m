From: David Woodhouse <dwmw2@infradead.org>
Subject: What broke snapshots now?
Date: Sat, 09 Jul 2005 12:08:56 +0100
Message-ID: <1120907336.8058.293.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-o5OsNvVh3LHy9NYtY38B"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 13:10:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrDDH-0007hG-WC
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 13:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVGILJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 07:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGILJK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 07:09:10 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:20354 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261178AbVGILJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 07:09:03 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DrDCb-00066d-IP; Sat, 09 Jul 2005 12:08:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-o5OsNvVh3LHy9NYtY38B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Does git on master.kernel.org need to be updated to handle packed
objects? See attached. 

Linus, please could you add the snapshot script to your regression
testing? http://david.woodhou.se/git-snapshot.sh

It'd be good to keep that working without too much manual intervention. 

-- 
dwmw2


--=-o5OsNvVh3LHy9NYtY38B
Content-Disposition: inline
Content-Description: Forwarded message - Cron <dwmw2@hera>
	/home/dwmw2/bin/git-snapshot.sh
Content-Type: message/rfc822

Return-path: <dwmw2@hera.kernel.org>
Envelope-to: dwmw2@baythorne.infradead.org
Delivery-date: Fri, 08 Jul 2005 11:18:32 +0100
Received: from [2002:d592:9a28::1] (helo=pentafluge.infradead.org) by
	baythorne.infradead.org with esmtps (Exim 4.51 #1 (Red Hat Linux)) id
	1DqpwF-0007Xj-Ng for dwmw2@baythorne.infradead.org; Fri, 08 Jul 2005
	11:18:31 +0100
Received: from hera.kernel.org ([209.128.68.125]) by
	pentafluge.infradead.org with esmtps (Exim 4.52 #1 (Red Hat Linux)) id
	1DqpwE-0000cL-4F for dwmw2-forward@infradead.org; Fri, 08 Jul 2005 11:18:31
	+0100
Received: from hera.kernel.org (localhost [127.0.0.1]) by hera.kernel.org
	(8.13.1/8.13.1) with ESMTP id j68AIM7w009555 for <dwmw2@hera.kernel.org>;
	Fri, 8 Jul 2005 03:18:22 -0700
Received: (from dwmw2@localhost) by hera.kernel.org (8.13.1/8.13.1/Submit)
	id j68911XE005138; Fri, 8 Jul 2005 02:01:01 -0700
Date: Fri, 8 Jul 2005 02:01:01 -0700
Message-Id: <200507080901.j68911XE005138@hera.kernel.org>
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
++ ls -rt /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.11 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.11-tree /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc2 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc3 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc4 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc5 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.12-rc6 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.13-rc1 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.13-rc2
++ tail -n1
++ sed s:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v::
+ RELNAME=2.6.13-rc2
++ cat /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.13-rc2
+ RELOBJ=c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19
++ tail -n1
++ sed s:/home/dwmw2/snapshots/2.6/tags/v::
++ ls -rt /home/dwmw2/snapshots/2.6/tags/v2.6.13-rc2-git1
+ SNAPNAME=2.6.13-rc2-git1
+ '[' 2.6.13-rc2-git1 == '' ']'
++ cat /home/dwmw2/snapshots/2.6/tags/v2.6.13-rc2-git1
+ LASTOBJ=c101f3136cc98a003d0d16be6fab7d0d950581a6
++ echo 2.6.13-rc2-git1
++ sed 's/^.*-git//'
+ OLDGITNUM=1
++ expr 1 + 1
+ NEWGITNUM=2
+ CURNAME=2.6.13-rc2-git2
++ tree-id c101f3136cc98a003d0d16be6fab7d0d950581a6
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/c1/01f3136cc98a003d0d16be6fab7d0d950581a6: No such file or directory
fatal: git-cat-file c101f3136cc98a003d0d16be6fab7d0d950581a6: bad file
Invalid id: c101f3136cc98a003d0d16be6fab7d0d950581a6
usage: git-cat-file [-t | tagname] <sha1>
usage: git-cat-file [-t | tagname] <sha1>
Invalid id: 
+ LASTTREE=
++ cat /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD
+ CURCOMM=a92b7b80579fe68fe229892815c750f6652eb6a9
++ tree-id a92b7b80579fe68fe229892815c750f6652eb6a9
+ CURTREE=7fd73e9f39bf6003cc3188a10426b62d8c47ab40
++ tree-id c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/c5/21cb0f10ef2bf28a18e1cc8adf378ccbbe5a19: No such file or directory
fatal: git-cat-file c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19: bad file
Invalid id: c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19
usage: git-cat-file [-t | tagname] <sha1>
usage: git-cat-file [-t | tagname] <sha1>
Invalid id: 
+ RELTREE=
+ echo release 2.6.13-rc2 commit tree
release 2.6.13-rc2 commit tree
++ git-cat-file -t c101f3136cc98a003d0d16be6fab7d0d950581a6
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/c1/01f3136cc98a003d0d16be6fab7d0d950581a6: No such file or directory
fatal: git-cat-file c101f3136cc98a003d0d16be6fab7d0d950581a6: bad file
+ echo last c101f3136cc98a003d0d16be6fab7d0d950581a6 tree
last c101f3136cc98a003d0d16be6fab7d0d950581a6 tree
+ echo head a92b7b80579fe68fe229892815c750f6652eb6a9 tree 7fd73e9f39bf6003cc3188a10426b62d8c47ab40
head a92b7b80579fe68fe229892815c750f6652eb6a9 tree 7fd73e9f39bf6003cc3188a10426b62d8c47ab40
+ '[' '' == 7fd73e9f39bf6003cc3188a10426b62d8c47ab40 ']'
++ echo 2.6.13-rc2-git2
++ cut -f2- -d-
+ EXTRAVERSION=-rc2-git2
+ cd /home/dwmw2/snapshots/2.6/stage
+ rm -rf tmp-empty-tree
+ mkdir -p tmp-empty-tree/.git
+ cd tmp-empty-tree
+ git-read-tree a92b7b80579fe68fe229892815c750f6652eb6a9
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/f8/640c306db2d583b9a30f2e52f8fb0a4cf624e0: No such file or directory
fatal: failed to unpack tree object a92b7b80579fe68fe229892815c750f6652eb6a9
+ git-checkout-cache Makefile
checkout-cache: Makefile is not in the cache.
+ perl -pi -e 's/EXTRAVERSION =.*/EXTRAVERSION = -rc2-git2/' Makefile
Can't open Makefile: No such file or directory.
+ git-diff-cache -m -p
+ gzip -9
usage: diff-cache [-r] [-z] [-p] [-i] [--cached] <tree sha1>
+ echo a92b7b80579fe68fe229892815c750f6652eb6a9
+ cg-log c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19:a92b7b80579fe68fe229892815c750f6652eb6a9
mv: cannot stat `.git/heads': No such file or directory
mv: cannot stat `.git/tags': No such file or directory
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/c5/21cb0f10ef2bf28a18e1cc8adf378ccbbe5a19: No such file or directory
fatal: git-cat-file c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19: bad file
Invalid id: c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19
+ echo a92b7b80579fe68fe229892815c750f6652eb6a9
+ echo New Snapshot 2.6.13-rc2-git2
New Snapshot 2.6.13-rc2-git2
+ '[' -z /pub/linux/kernel/v2.6/snapshots ']'
+ '[' -r /staging/upload.lock ']'
+ exec
+ flock -s 200
+ mv -v /home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc2-git2.gz /home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc2-git2.id /home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc2-git2.log /pub/linux/kernel/v2.6/snapshots
`/home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc2-git2.gz' -> `/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-rc2-git2.gz'
`/home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc2-git2.id' -> `/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-rc2-git2.id'
`/home/dwmw2/snapshots/2.6/stage/patch-2.6.13-rc2-git2.log' -> `/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-rc2-git2.log'

--=-o5OsNvVh3LHy9NYtY38B--
