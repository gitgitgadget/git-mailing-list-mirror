From: Sven Verdoolaege <skimo@kotnet.org>
Subject: gitk and duplicate commits
Date: Wed, 29 Jun 2005 17:55:23 +0200
Message-ID: <20050629155523.GS5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 18:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnfAV-0006F7-7E
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 18:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVF2QSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVF2QPn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 12:15:43 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:55271 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262590AbVF2QKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 12:10:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 5E397137B70
	for <git@vger.kernel.org>; Wed, 29 Jun 2005 18:10:10 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id A7CEA137AC0
	for <git@vger.kernel.org>; Wed, 29 Jun 2005 18:10:08 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 904C3AED86
	for <git@vger.kernel.org>; Wed, 29 Jun 2005 18:10:08 +0200 (CEST)
Received: (qmail 31460 invoked by uid 500); 29 Jun 2005 15:55:23 -0000
To: Paul Mackerras <paulus@samba.org>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If I pass in the same commit multiple times (possibly
under different names) to gitk,
it will echo the warning from git-rev-list
(sort_list_in_merge_order: duplicate commit 82e3583b9426c193659a4c1315d6a3b3cee11dce ignored)
and then simply stop.

Surely this can be handled more gracefully.

Note that I do want to be able to pass the same commit
multiple times.  At least, I don't want to check
whether two "branches" happen to refer to the same commit.

skimo
