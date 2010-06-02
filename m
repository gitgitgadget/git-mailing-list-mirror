From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] Makefile: add PYTHON_PATH to GIT-BUILD-OPTIONS
Date: Wed,  2 Jun 2010 18:23:15 -0500
Message-ID: <injaoVtrfs7Li4aYBNxEQTEuVfA0su6k31mnsFSHfME7ANKbGtnFY8il0PxJbc0dX9uP-BWJKTk@cipher.nrlssc.navy.mil>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
Cc: gitster@pobox.com, srabbelier@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 01:23:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxHw-0005Rd-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923Ab0FBXXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:23:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36391 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758898Ab0FBXXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:23:40 -0400
Received: by mail.nrlssc.navy.mil id o52NNa7t028514; Wed, 2 Jun 2010 18:23:36 -0500
In-Reply-To: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
X-OriginalArrivalTime: 02 Jun 2010 23:23:36.0374 (UTC) FILETIME=[A016DD60:01CB02AA]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148278>

From: Brandon Casey <drafnel@gmail.com>

This allows the correct python to be used by the test suite.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d5d6565..7b5de0c 100644
--- a/Makefile
+++ b/Makefile
@@ -1885,6 +1885,7 @@ GIT-CFLAGS: FORCE
 GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
+	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
-- 
1.6.6.2
