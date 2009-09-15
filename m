From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 07/14] Add empty header files for MSVC port
Date: Tue, 15 Sep 2009 15:44:10 +0200
Message-ID: <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:10 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLF-0007Gg-0c
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:09 +0200
Received: by yxe1 with SMTP id 1so7426774yxe.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=YRiZOmIGIBuYcLiwbvSfqzcKTVf7Wqc18dfXYtFtrTM=;
        b=qCrEFJxdkzgLd8XT2Hh8B8hu3PTvZOC8qXJu1U1mM7sqi49zTvyPgA+y00b6U9JNAT
         EzezRS3z3WzkJkW57Wjcbnce8BM9nPzUzyi5WD5G/hIJpoaK5kf+wO5VAxdzfustzyzh
         KYwmT1Qr6uh9amNNkO0tbPeBTaM/VCzBqFYW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=fBnvixA+8b8JsWelU4PYjvPu5vZIFB7BgQhrrT/76ArOdwiiNveQaZD/Sky7JZeoZ1
         TTGOIIVzMqBX/g2pRLth/qmNG19MY+tN9n/cOrlT04kdHbxaP12W9ihS9kDmzZd9+Eov
         eLfKq9jZoQ75vbMNuumEgb7t6jD+nWFX4DNNw=
Received: by 10.150.5.1 with SMTP id 1mr2291677ybe.18.1253022294471;
        Tue, 15 Sep 2009 06:44:54 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7014yqh.0;
	Tue, 15 Sep 2009 06:44:48 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.6.21 with SMTP id 21mr119423ebf.9.1253022287927; Tue, 15 Sep 2009 06:44:47 -0700 (PDT)
Received: by 10.210.6.21 with SMTP id 21mr119422ebf.9.1253022287884; Tue, 15 Sep 2009 06:44:47 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144]) by gmr-mx.google.com with ESMTP id 14si1551369ewy.1.2009.09.15.06.44.46; Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.144 as permitted sender) client-ip=74.125.78.144;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.144 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 13so720204eye.46 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=v5yGyN3tEJLteFxeXVXhfOlytP5nQ6R5nD1vBz+6zAc=; b=MWIZjJNCiWgcn2NtXJKvLSGg8n/g3VUfd6A+DGPcmCPmzjJWhlmbOaZl5peDbUb25T JFsPCxovhyXzPnIoDFMKw7EekFY4gSjBcr0/o7QqqUIE3/mOiCmZVRv8M5mOruJ1Xxb9 zw0WVWVE1zoRGRHbC0kaUOeg6qHjpbN1MPWls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=BiW0l9AfcbXjpukpzk60jtU+/75wAiIgV85AAyK/2xfAsqHV00IaJbz52Q2/UtJlBy 2yvGHsb/9sCqFhhTNYY4PUMvOMj/Ue6NgdNjSv64y0XY7DV+Cf7wxxEgwZG+ew+/skbv 9U2/IFHtYO4nNxhuKgslxwxNAO9n75uZIvY/U=
Received: by 10.216.8.2 with SMTP id 2mr1517306weq.90.1253022286634; Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.45 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128551>


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
1.6.2.1.418.g33d56.dirty
