From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 4/7] autoconf: remove few redundant semicolons
Date: Thu, 19 Jul 2012 00:34:59 +0200
Message-ID: <1913417f049bb2cb4786aa82ec49af5ae1238a5b.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrcqL-0005Ub-SS
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab2GRWfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59123 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab2GRWf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:26 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so1272200wey.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=iNf3b37cbj0J3GHPijcWngb2507jyO0f7gmL36M6PW8=;
        b=pAOrA5iL7Sf2K6Q7KBC2ZJQS4NxMKH3qHEnKtKXnLNUSuT3fEveK2+hvb90BTMku+Q
         kWjDIlopLQjEeRNn1Ltrq2N0NO4+Ca/MhfFoJXUvx1EagcMmsyJvUqmyUET5/hxBPRQk
         yB3uykWSgq0e7ReidJaQ0v8J55SwOG4lieH3X8uLcugE3WHdb1fdf3Sq22zho6E1n1eS
         CiHluCBifEpACYFRdPU+bAv8k9otsEu8v6CuAl5tOuQxmCZ/3xo8TqQCqu89ZChD8lom
         MS8qEmWhF+xIWAXImsmQw+rE8W2nKhsUaRZ4kYjXpCchKca36xpS3OgjqoZlKWBEUjQq
         fmVQ==
Received: by 10.216.135.148 with SMTP id u20mr541898wei.137.1342650926199;
        Wed, 18 Jul 2012 15:35:26 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201702>

They are merely useless now, but would get in the way of future changes.

No semantic change is intended.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9472f6b..5fb9734 100644
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
