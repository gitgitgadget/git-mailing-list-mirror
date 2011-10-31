From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 3/3] MSVC: Remove unneeded header stubs
Date: Mon, 31 Oct 2011 20:12:44 +0100
Message-ID: <1320088364-25916-4-git-send-email-vfr@lyx.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Cc: kusmabite@gmail.com, ramsay@ramsay1.demon.co.uk,
	msysgit@googlegroups.com, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKxIm-0004Bs-D3
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 20:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933987Ab1JaTNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 15:13:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60415 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933236Ab1JaTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 15:13:35 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so5598224eye.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 12:13:35 -0700 (PDT)
Received: by 10.14.15.80 with SMTP id e56mr1392978eee.3.1320088415207;
        Mon, 31 Oct 2011 12:13:35 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id d6sm25272860eec.10.2011.10.31.12.13.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 12:13:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184515>

These headers are no longer needed since they are no longer
unnecessarily included in git-compat-util.h.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/vcbuild/include/arpa/inet.h   |    1 -
 compat/vcbuild/include/grp.h         |    1 -
 compat/vcbuild/include/inttypes.h    |    1 -
 compat/vcbuild/include/netdb.h       |    1 -
 compat/vcbuild/include/netinet/in.h  |    1 -
 compat/vcbuild/include/netinet/tcp.h |    1 -
 compat/vcbuild/include/pwd.h         |    1 -
 compat/vcbuild/include/sys/ioctl.h   |    1 -
 compat/vcbuild/include/sys/select.h  |    1 -
 compat/vcbuild/include/sys/socket.h  |    1 -
 compat/vcbuild/include/sys/wait.h    |    1 -
 compat/vcbuild/include/termios.h     |    1 -
 12 files changed, 0 insertions(+), 12 deletions(-)
 delete mode 100644 compat/vcbuild/include/arpa/inet.h
 delete mode 100644 compat/vcbuild/include/grp.h
 delete mode 100644 compat/vcbuild/include/inttypes.h
 delete mode 100644 compat/vcbuild/include/netdb.h
 delete mode 100644 compat/vcbuild/include/netinet/in.h
 delete mode 100644 compat/vcbuild/include/netinet/tcp.h
 delete mode 100644 compat/vcbuild/include/pwd.h
 delete mode 100644 compat/vcbuild/include/sys/ioctl.h
 delete mode 100644 compat/vcbuild/include/sys/select.h
 delete mode 100644 compat/vcbuild/include/sys/socket.h
 delete mode 100644 compat/vcbuild/include/sys/wait.h
 delete mode 100644 compat/vcbuild/include/termios.h

diff --git a/compat/vcbuild/include/arpa/inet.h b/compat/vcbuild/include/arpa/inet.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/arpa/inet.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/grp.h b/compat/vcbuild/include/grp.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/grp.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/inttypes.h b/compat/vcbuild/include/inttypes.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/inttypes.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netdb.h b/compat/vcbuild/include/netdb.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/netdb.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netinet/in.h b/compat/vcbuild/include/netinet/in.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/netinet/in.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netinet/tcp.h b/compat/vcbuild/include/netinet/tcp.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/netinet/tcp.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/pwd.h b/compat/vcbuild/include/pwd.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/pwd.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/ioctl.h b/compat/vcbuild/include/sys/ioctl.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/ioctl.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/select.h b/compat/vcbuild/include/sys/select.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/select.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/socket.h b/compat/vcbuild/include/sys/socket.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/socket.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/wait.h b/compat/vcbuild/include/sys/wait.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/wait.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/termios.h b/compat/vcbuild/include/termios.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/termios.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
-- 
1.7.4.1
