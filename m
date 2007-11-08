From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Makefile: wt-status.h is also a lib header
Date: Thu, 8 Nov 2007 00:10:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080010300.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipuzf-0003kK-Kq
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759353AbXKHALR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759323AbXKHALR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:11:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:41638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759298AbXKHALP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:11:15 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:11:13 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp029) with SMTP; 08 Nov 2007 01:11:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19++2MJNN9+h1O+8pPPsdwZct/2cPF6LDgv6vOS6P
	PJZ9sXnJOt2E3T
X-X-Sender: gene099@racer.site
In-Reply-To: <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63904>


When a struct in wt-status.h changes, many files need to be rebuilt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e5dc63b..dad9c5a 100644
--- a/Makefile
+++ b/Makefile
@@ -288,7 +288,8 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h \
+	wt-status.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
-- 
1.5.3.5.1597.g7191
