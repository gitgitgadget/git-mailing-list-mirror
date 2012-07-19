From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 4/7] autoconf: remove few redundant semicolons
Date: Thu, 19 Jul 2012 09:49:59 +0200
Message-ID: <836c08e3c00035f41aee320dc166eb259ec747a6.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlVS-00077p-CD
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab2GSHug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:36 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43518 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab2GSHuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:22 -0400
Received: by bkwj10 with SMTP id j10so2137770bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=6LUROLHb68TOD8pC4e1zyZQmAElkpQUtyLl7E0ta0Lw=;
        b=QAiKYh8nS8T/bEOJRBxJy/Aa3UkvQHay55k7AexP94XyUyFHib+Pr1drsI6LJrfGCw
         UcOX1c7MVg9skMvowMMZRxZ1ZbmJDI/T0G6k6rc+mZYOWLxCV6he3MQhNbKBscjmL2gk
         5rE0745fzVy0nwurL3epll94AIRCa+Q0nY5VBGD4UEDZMj6clP2GZEcpMdcR2WLFOgaS
         hO+zkpLckuq8Jpe/ULPEHIuvJfrEc42NEIHDp3aQ58rm3EOuaGbEXhMBXX7K8pvHbRpW
         sIXk5iVyLLDjdtCoMYkcbMvxHK2xiozyrdlLoyBH9pyGNrYdkB1o9ytK3oo2KMkHPLkz
         7AvA==
Received: by 10.204.0.80 with SMTP id 16mr279841bka.71.1342684221315;
        Thu, 19 Jul 2012 00:50:21 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <cover.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201723>

They are merely useless now, but would get in the way of future changes.

No semantic change is intended.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 200776f..b453ba5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -203,7 +203,7 @@ AC_ARG_ENABLE([jsmin],
 [
   JSMIN=$enableval;
   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
-  GIT_CONF_SUBST([JSMIN], [$enableval]);
+  GIT_CONF_SUBST([JSMIN], [$enableval])
 ])
 
 # Define option to enable CSS minification
@@ -213,7 +213,7 @@ AC_ARG_ENABLE([cssmin],
 [
   CSSMIN=$enableval;
   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
-  GIT_CONF_SUBST([CSSMIN], [$enableval]);
+  GIT_CONF_SUBST([CSSMIN], [$enableval])
 ])
 
 ## Site configuration (override autodetection)
-- 
1.7.10.2.1067.g553d16e
