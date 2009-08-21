From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 10/14] Add empty header files for MSVC port
Date: Fri, 21 Aug 2009 15:30:42 +0200
Message-ID: <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE4-00012X-LQ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbZHUNbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbZHUNbT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:45328 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbZHUNbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:14 -0400
Received: by ey-out-2122.google.com with SMTP id 22so190370eye.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=AB88k+d3tZ1NbW/cINbMHFgIcNkpSKDlgajhL9IiyBQ=;
        b=BqsYkFOGzdpUcemNy41EeIRVr234qHkZ7D8E2SYsodCPHOicLjC/HvWFszrfCri4/J
         4JQAbWb6E1hCv+7clgbG44zNq8o+pX4QcOaRWFNtqzGLUpSD6Etrpo6uT123m4hYVJzg
         DCYZvdIu3cCLLmH+kPVCF756hbFiOWcoqL+CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GaujnBktsSczZZer1/9sTYMZfU+asdPxPCF1JrhWj4x5fOYftBW+dAKLwDK5t4783D
         LnUTlK2pE4fn6le2wvRNLYGoqmW094A1RaNvHsu+4xSufEk5/kzXc/KZgy2dHuY2KPVV
         w5DpLWU3cSbLUqsOg6EhDl206t+Qoz07E0MG8=
Received: by 10.210.131.6 with SMTP id e6mr1508857ebd.29.1250861475794;
        Fri, 21 Aug 2009 06:31:15 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126717>

MSVC lacks many of the header files included by git-compat-util.h,
so add blank header files for these instead of going ifdef crazy.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/vcbuild/include/arpa/inet.h   |    1 +
 compat/vcbuild/include/grp.h         |    1 +
 compat/vcbuild/include/inttypes.h    |    1 +
 compat/vcbuild/include/netdb.h       |    1 +
 compat/vcbuild/include/netinet/in.h  |    1 +
 compat/vcbuild/include/netinet/tcp.h |    1 +
 compat/vcbuild/include/pwd.h         |    1 +
 compat/vcbuild/include/sys/ioctl.h   |    1 +
 compat/vcbuild/include/sys/param.h   |    1 +
 compat/vcbuild/include/sys/poll.h    |    1 +
 compat/vcbuild/include/sys/select.h  |    1 +
 compat/vcbuild/include/sys/socket.h  |    1 +
 compat/vcbuild/include/sys/time.h    |    1 +
 compat/vcbuild/include/sys/wait.h    |    1 +
 14 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/include/arpa/inet.h
 create mode 100644 compat/vcbuild/include/grp.h
 create mode 100644 compat/vcbuild/include/inttypes.h
 create mode 100644 compat/vcbuild/include/netdb.h
 create mode 100644 compat/vcbuild/include/netinet/in.h
 create mode 100644 compat/vcbuild/include/netinet/tcp.h
 create mode 100644 compat/vcbuild/include/pwd.h
 create mode 100644 compat/vcbuild/include/sys/ioctl.h
 create mode 100644 compat/vcbuild/include/sys/param.h
 create mode 100644 compat/vcbuild/include/sys/poll.h
 create mode 100644 compat/vcbuild/include/sys/select.h
 create mode 100644 compat/vcbuild/include/sys/socket.h
 create mode 100644 compat/vcbuild/include/sys/time.h
 create mode 100644 compat/vcbuild/include/sys/wait.h

diff --git a/compat/vcbuild/include/arpa/inet.h b/compat/vcbuild/include/arpa/inet.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/arpa/inet.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/grp.h b/compat/vcbuild/include/grp.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/grp.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/inttypes.h b/compat/vcbuild/include/inttypes.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/inttypes.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netdb.h b/compat/vcbuild/include/netdb.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/netdb.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netinet/in.h b/compat/vcbuild/include/netinet/in.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/netinet/in.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/netinet/tcp.h b/compat/vcbuild/include/netinet/tcp.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/netinet/tcp.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/pwd.h b/compat/vcbuild/include/pwd.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/pwd.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/ioctl.h b/compat/vcbuild/include/sys/ioctl.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/ioctl.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/param.h b/compat/vcbuild/include/sys/param.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/param.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/poll.h b/compat/vcbuild/include/sys/poll.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/poll.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/select.h b/compat/vcbuild/include/sys/select.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/select.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/socket.h b/compat/vcbuild/include/sys/socket.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/socket.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/time.h b/compat/vcbuild/include/sys/time.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/time.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/wait.h b/compat/vcbuild/include/sys/wait.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/sys/wait.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
-- 
1.6.3.msysgit.0.18.gef407
