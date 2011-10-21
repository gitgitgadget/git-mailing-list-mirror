From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 3/3] MSVC: Remove unneeded header stubs
Date: Fri, 21 Oct 2011 21:42:57 +0200
Message-ID: <4EA1CB41.6070609@lyx.org>
References: <4EA1C9C9.9010904@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 21:43:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHKzm-000548-BY
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 21:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab1JUTnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 15:43:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41633 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1JUTnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 15:43:04 -0400
Received: by eye27 with SMTP id 27so4177745eye.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 12:43:02 -0700 (PDT)
Received: by 10.14.14.209 with SMTP id d57mr1479678eed.54.1319226182548;
        Fri, 21 Oct 2011 12:43:02 -0700 (PDT)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id q50sm37516637eef.9.2011.10.21.12.43.01
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 12:43:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EA1C9C9.9010904@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184083>

These headers are not necessary anymore as they are no longer included
in git-compat-util.h.

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

diff --git a/compat/vcbuild/include/arpa/inet.h 
b/compat/vcbuild/include/arpa/inet.h
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
diff --git a/compat/vcbuild/include/inttypes.h 
b/compat/vcbuild/include/inttypes.h
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
diff --git a/compat/vcbuild/include/netinet/in.h 
b/compat/vcbuild/include/netinet/in.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/netinet/in.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netinet/tcp.h 
b/compat/vcbuild/include/netinet/tcp.h
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
diff --git a/compat/vcbuild/include/sys/ioctl.h 
b/compat/vcbuild/include/sys/ioctl.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/ioctl.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/select.h 
b/compat/vcbuild/include/sys/select.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/select.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/socket.h 
b/compat/vcbuild/include/sys/socket.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/socket.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/wait.h 
b/compat/vcbuild/include/sys/wait.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/wait.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/termios.h 
b/compat/vcbuild/include/termios.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/termios.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
-- 
1.7.6.msysgit.0
