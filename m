From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 04/14] Add define guards to compat/win32.h
Date: Fri, 21 Aug 2009 15:30:36 +0200
Message-ID: <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:31:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUDA-0000V9-6H
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbZHUNbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbZHUNbJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:45328 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbZHUNbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:07 -0400
Received: by ey-out-2122.google.com with SMTP id 22so190370eye.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=sUx/zA1gMEVip0n+dNylW3ShtbQEgM/xQg3wDWuv900=;
        b=KdcyNF/xkalKXNGqWEz0edvMui9kpKGGplIc9MHwVqzJP6hwurdo2iViG8jrSfpkDY
         mjIil4febtZufNMXgWyejxO6xgebHKBh3GpdOz2U+B9bYxmfl0YH0XcYF295SiQ1TIhB
         8+YqmY4Mn9Jxa1xtB3JfJ0HW8ZPC1nxphHZyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PK52EWbcXLxsY6cdN0GtuAXGr9s2ACFkNlvCr/3C1ktoE8A1NhJ44VPsYEK/vETJKv
         +nf5gf8GVg1goewyPcfpP4nwvJAcak6vuY/Id25gmGwHIXDjXMZf2Luc6R3BgCo8ei4e
         OGQNj9C7RNvrzlIYueizCXbeQWX6L+sPOA2AA=
Received: by 10.210.143.9 with SMTP id q9mr1178339ebd.73.1250861468864;
        Fri, 21 Aug 2009 06:31:08 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126712>

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/win32.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/compat/win32.h b/compat/win32.h
index c26384e..e8c178d 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -1,3 +1,6 @@
+#ifndef WIN32_H
+#define WIN32_H
+
 /* common Win32 functions for MinGW and Cygwin */
 #include <windows.h>
 
@@ -32,3 +35,5 @@ static inline int get_file_attr(const char *fname, WIN32_FILE_ATTRIBUTE_DATA *fd
 		return ENOENT;
 	}
 }
+
+#endif
-- 
1.6.3.msysgit.0.18.gef407
