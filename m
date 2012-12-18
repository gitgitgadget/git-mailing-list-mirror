From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/3] Makefile: replace "echo 1>..." with "echo >..."
Date: Tue, 18 Dec 2012 20:00:08 +0100
Message-ID: <20121218190009.29910.53988.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:01:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2Pg-0002uO-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2LRTA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:00:56 -0500
Received: from mail-3d.bbox.fr ([194.158.122.58]:42661 "EHLO mail-3d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755503Ab2LRTAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:00:54 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3d.bbox.fr (Postfix) with ESMTP id CE77095;
	Tue, 18 Dec 2012 20:00:53 +0100 (CET)
X-git-sha1: bafa10b36fd5c960c426deb5d9160c89e2271f30 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211774>

This is clearer to many people this way.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7db8445..e055c9a 100644
--- a/Makefile
+++ b/Makefile
@@ -2183,7 +2183,7 @@ endef
 GIT-SCRIPT-DEFINES: FORCE
 	@FLAGS='$(SCRIPT_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo 1>&2 "    * new script parameters"; \
+		echo >&2 "    * new script parameters"; \
 		echo "$$FLAGS" >$@; \
             fi
 
@@ -2564,7 +2564,7 @@ TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
 GIT-PREFIX: FORCE
 	@FLAGS='$(TRACK_PREFIX)'; \
 	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
-		echo 1>&2 "    * new prefix flags"; \
+		echo >&2 "    * new prefix flags"; \
 		echo "$$FLAGS" >GIT-PREFIX; \
 	fi
 
@@ -2573,7 +2573,7 @@ TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):$(USE_GETTEXT_SCHEME)
 GIT-CFLAGS: FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
-		echo 1>&2 "    * new build flags"; \
+		echo >&2 "    * new build flags"; \
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
@@ -2582,7 +2582,7 @@ TRACK_LDFLAGS = $(subst ','\'',$(ALL_LDFLAGS))
 GIT-LDFLAGS: FORCE
 	@FLAGS='$(TRACK_LDFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-LDFLAGS 2>/dev/null`" ; then \
-		echo 1>&2 "    * new link flags"; \
+		echo >&2 "    * new link flags"; \
 		echo "$$FLAGS" >GIT-LDFLAGS; \
             fi
 
@@ -2631,7 +2631,7 @@ TRACK_PYTHON = $(subst ','\'',-DPYTHON_PATH='$(PYTHON_PATH_SQ)')
 GIT-PYTHON-VARS: FORCE
 	@VARS='$(TRACK_PYTHON)'; \
 	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo 1>&2 "    * new Python interpreter location"; \
+		echo >&2 "    * new Python interpreter location"; \
 		echo "$$VARS" >$@; \
             fi
 endif
-- 
1.8.1.rc1.2.g8740035
