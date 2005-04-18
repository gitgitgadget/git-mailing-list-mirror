From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 15:28:38 -0500
Message-ID: <1113856118.4998.70.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: linux-scsi-owner@vger.kernel.org Mon Apr 18 22:25:44 2005
Return-path: <linux-scsi-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcnn-000226-If
	for lnx-linux-scsi@gmane.org; Mon, 18 Apr 2005 22:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDRU25 (ORCPT <rfc822;lnx-linux-scsi@m.gmane.org>);
	Mon, 18 Apr 2005 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDRU25
	(ORCPT <rfc822;linux-scsi-outgoing>);
	Mon, 18 Apr 2005 16:28:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38636 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261158AbVDRU2x (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
	Mon, 18 Apr 2005 16:28:53 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3IKSdA11747;
	Mon, 18 Apr 2005 16:28:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org

As of today, I have two SCSI git trees operational:

rsync://www.parisc-linux.org/~jejb/scsi-rc-fixes-2.6.git

and

rsync://www.parisc-linux.org/~jejb/scsi-misc-2.6.git

The latter has a non trivial merge in it because of a conflict in
scsi_device.h, so merges actually do work ...

The trees are exported from BK a changeset at a time (except the merge
bits, which were done manually).  I'll continue to accumulate patches in
the BK trees for the time being since we don't have a nice web browser
interface for the git trees (and also my commit scripts are all BK
based).

Linus, the rc-fixes repo is ready for applying ... it's the same one I
announced on linux-scsi and lkml a while ago just with the git date
information updated to be correct (the misc one should wait until after
2.6.12 is final).

James


