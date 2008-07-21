From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 7/9] Windows: Make $(gitexecdir) relative
Date: Mon, 21 Jul 2008 21:19:56 +0200
Message-ID: <1216667998-8879-8-git-send-email-johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-4-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-5-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-7-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0x3-00025p-4l
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbYGUTUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbYGUTUY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:24 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39827 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbYGUTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id E4C7833ED3;
	Mon, 21 Jul 2008 21:20:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
In-Reply-To: <1216667998-8879-7-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89389>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 908c1cb..1bfffff 100644
--- a/Makefile
+++ b/Makefile
@@ -745,6 +745,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
+	gitexecdir = ../libexec/git-core
 	template_dir = ../share/git-core/templates/
 	ETC_GITCONFIG = ../etc/gitconfig
 endif
-- 
1.6.0.rc0.18.g6aef2
