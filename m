From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 09/17] Add empty header files for MSVC port
Date: Mon, 14 Sep 2009 15:11:22 +0200
Message-ID: <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:06 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMf-0004Dd-Ro
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:06 +0200
Received: by mail-qy0-f158.google.com with SMTP id 30so3476534qyk.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=YRiZOmIGIBuYcLiwbvSfqzcKTVf7Wqc18dfXYtFtrTM=;
        b=NeP+QBN+prDCrdhV46Nrh0Exj8RcYNN4ibSsKxnVdx6L8UuYX+TB/PdBBmsm8/zFje
         K++W9Fk7JVO/NVCfzRxhOH0phIge362NWg+uloEpQYdh5t+XVxEBU6mrP5Uu1ipbZJw3
         u1CK6EuJMrF9xfIsrF6rNA3t06lYJTujwTYH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=I2GBcgnWs4PouN+hSDLivfc5Bt2jEWZ3PhycnJwYaqFtcGlXpaMXtZ6sT7y19RzveI
         VC6eJp3Zspg4/08aOrVG/Jp+PHOvVdQcg4qSyvK30iaD2Ut2jvyh+PArV5bsZCIT+r4o
         GO4vMpINJoh9UYUI63+hkemSqQbhBdpFcWhWM=
Received: by 10.229.106.24 with SMTP id v24mr505855qco.24.1252933979563;
        Mon, 14 Sep 2009 06:12:59 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr6966yqi.0;
	Mon, 14 Sep 2009 06:12:49 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.2.19 with SMTP id 19mr678721ebb.14.1252933968873; Mon, 14 Sep 2009 06:12:48 -0700 (PDT)
Received: by 10.210.2.19 with SMTP id 19mr678720ebb.14.1252933968839; Mon, 14 Sep 2009 06:12:48 -0700 (PDT)
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com [209.85.219.217]) by gmr-mx.google.com with ESMTP id 14si1297352ewy.1.2009.09.14.06.12.47; Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.217 as permitted sender) client-ip=209.85.219.217;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.217 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy17 with SMTP id 17so2872729ewy.39 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=v5yGyN3tEJLteFxeXVXhfOlytP5nQ6R5nD1vBz+6zAc=; b=sLR3qvSM7ATbUEFATxakucd+IL+w1nFXSiwpYqDNdz7FgJkOA5tgjFnXiia+Cu5SNZ ztnTXC5qkIfg/dWt9TgI3g1occhzMqEeVbYVrOG4HUb2sBc522lVUJ/g3YtCodG1yqRV bAxoxAHkUQETb4z+YDDVMtApdYv4JNpHKMk08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=A4EUfi3L7ZeERp3Sy4v7EO89aKvw9HNCE7FO+kt0TN0C77N5Kp4IIpl5P5MUdWL7SI 8mZUOA99J11zoAydrwY57H04Mabfmu8jnw25zaoYx/go+fJMC+5Ib3Cvbd1MmKTOQ8kb 3IV8z0fvpDv9mZ2QmKAWneHFjHEiYDej0AfaQ=
Received: by 10.211.159.19 with SMTP id l19mr6895841ebo.83.1252933967699; Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.46 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128465>


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
