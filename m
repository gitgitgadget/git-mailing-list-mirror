From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/3] Compile fix for MSVC: Include <io.h>
Date: Mon, 31 Oct 2011 20:12:43 +0100
Message-ID: <1320088364-25916-3-git-send-email-vfr@lyx.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Cc: kusmabite@gmail.com, ramsay@ramsay1.demon.co.uk,
	msysgit@googlegroups.com, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:13:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKxIg-0004BE-9W
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 20:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933953Ab1JaTNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 15:13:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60415 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933236Ab1JaTNd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 15:13:33 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so5598224eye.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 12:13:32 -0700 (PDT)
Received: by 10.14.19.5 with SMTP id m5mr1376173eem.121.1320088412466;
        Mon, 31 Oct 2011 12:13:32 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id d6sm25272860eec.10.2011.10.31.12.13.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 12:13:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184514>

This include is needed for _commit(..) which is used in mingw.h.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/msvc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index a33b01c..aa4b563 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -4,6 +4,7 @@
 #include <direct.h>
 #include <process.h>
 #include <malloc.h>
+#include <io.h>
 
 /* porting function */
 #define inline __inline
-- 
1.7.4.1
