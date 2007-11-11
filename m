From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH 0/3] git-svn log fixes
Date: Sat, 10 Nov 2007 22:10:32 -0800
Message-ID: <1194761435-7286-1-git-send-email-ddkilzer@kilzer.net>
Cc: gitster@pobox.com, David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 07:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir61x-0008DP-PE
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbXKKGKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 01:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbXKKGKe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:10:34 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:61313 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbXKKGKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 01:10:33 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id EA542183618F;
	Sat, 10 Nov 2007 22:10:32 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id CF19528057;
	Sat, 10 Nov 2007 22:10:32 -0800 (PST)
X-AuditID: 1180711d-a0abebb0000008bf-31-47369cd81a22
Received: from localhost.localdomain (unknown [17.151.89.105])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 935E82804F;
	Sat, 10 Nov 2007 22:10:32 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64408>

This patch series contains varies fixes for the "git-svn log" command:

[PATCH 1/3] git-svn log: fix ascending revision ranges
[PATCH 2/3] git-svn log: include commit log for the smallest revision in a range
[PATCH 3/3] git-svn log: handle unreachable revisions like "svn log"

I am looking for feedback since this is my first significant patch series
for git.  (I posted a couple of documentation fixes and Makefile tweaks
previously.)

Thanks!

Dave
--
 git-svn.perl           |   60 ++++++++++++++++++++++++------------
 t/t9116-git-svn-log.sh |   80 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 20 deletions(-)
--
