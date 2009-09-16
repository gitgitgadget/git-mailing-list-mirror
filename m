From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 07/15] Add empty header files for MSVC port
Date: Wed, 16 Sep 2009 10:20:23 +0200
Message-ID: <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:29 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f140.google.com ([209.85.212.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplR-0004pS-40
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:21 +0200
Received: by mail-vw0-f140.google.com with SMTP id 4so3156651vws.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=YRiZOmIGIBuYcLiwbvSfqzcKTVf7Wqc18dfXYtFtrTM=;
        b=yePwWVNaW4HGcZXvZdiCymiLepPPc2wR72dcloaXiBoXalzY++BOCNMgzxcM4hPby0
         h/BgIxndQBMiV7IyProPQwScNXEh00qQMj6TNFyqi+CuTUcq6JRwiUufH7w7aGypI/jZ
         cBRiNNUk40YNIPg+I98P+zD93d0HsqUJ3levg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=cffErjUFtx4tR+mV+ah8MAl5gGNyD/doywAY5EDBoJMoUtye6Lzhg9xXqA0iW2TArT
         oWBbHtnwNx+n2sJccPvN4WuEPmCnKG8hSpS0jX/dFPsiD4VWO/8KIu5OoN8wRNaMptJh
         UsgDK3K4Y8TrcVwOcCjA0/R6U54fbORAvf4+M=
Received: by 10.150.87.6 with SMTP id k6mr1106226ybb.35.1253089274800;
        Wed, 16 Sep 2009 01:21:14 -0700 (PDT)
Received: by 10.176.58.28 with SMTP id g28gr7042yqa.0;
	Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.32.6 with SMTP id f6mr1242558ebf.11.1253089260887; Wed, 16 Sep 2009 01:21:00 -0700 (PDT)
Received: by 10.210.32.6 with SMTP id f6mr1242557ebf.11.1253089260851; Wed, 16 Sep 2009 01:21:00 -0700 (PDT)
Received: from mail-ew0-f208.google.com (mail-ew0-f208.google.com [209.85.219.208]) by gmr-mx.google.com with ESMTP id 15si1687102ewy.0.2009.09.16.01.20.59; Wed, 16 Sep 2009 01:20:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.208 as permitted sender) client-ip=209.85.219.208;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.208 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy4 with SMTP id 4so4839587ewy.36 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=v5yGyN3tEJLteFxeXVXhfOlytP5nQ6R5nD1vBz+6zAc=; b=BOFdBANdSzEUIhZ96LV378uu2KQ7GwPWlmUm7XnL1vWIi8RFmJKnOk7P/LERKKmSvG CyVt4pEzK/UV8lbxUCSc2jAXIN2XsBkMJcfkDghX/SgM6muxKBMusSf8Uklp3Jucg2Zm NVSu6BjUMFZihpj9C5aXFkUWVIVj8r+ZMLSuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=PbFURAT2viKs/pb814joTxjD8rLOEEW2Mbm8XZ4LV8GHE/xKb4Lg3FuG437hC6ZaK6 +fIwVStlMuP28t2BELax+xZhhaf+Jf9GQyILfH+sfRuT8G61U1+b/pDA9nP5rWdjzrIA D28qK3VF+d5m+1MZekcGtkk8sHBnW5O++4iMI=
Received: by 10.210.3.21 with SMTP id 21mr9559005ebc.40.1253089259702; Wed, 16 Sep 2009 01:20:59 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.58 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128628>


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
