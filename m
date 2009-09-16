From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 13/15] Add README for MSVC build
Date: Wed, 16 Sep 2009 10:20:29 +0200
Message-ID: <260603a54845df34659d605fadaf663d0094c8cb.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com> <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com> <38f180f3899d1f7a6acc8cf8c65f5f0ffb61699a.1253088099.git.mstorm
 o@gmail.com> <e9ffbe6e71d7f27c4ee5d31f59f860827c5a2f94.1253088099.git.mstormo@gmail.com> <49b1712beea2ac9eb00c61c8d92c035a7c412d69.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:31 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplX-0004oA-Mz
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:27 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so12827760ywh.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=JLCdmQ/ep9ZJjqyhJrQUFm0gLSR9bl6/09YO5BDe7Tk=;
        b=Z46ygvCccq4kcudACuDsHmoYljMfo86HMPySuuRdFekqOke5HYDviWbiVkDhWuNpSJ
         oR+TqrHj1zi2/Ba9ypIJnnUa2CnPP/iehxghnnOhCaLtqvC47hM8bKp//5p57FtI0bTr
         Fl8cXCPiMyNhHUDvrrfXEF2O8z48AkJVp5Psw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ODqtvhhtn4DoEYYBAW50N3aSt1q0k1goCVR7/pPFETOkurV2QVfkOPx+mdpeZEgN5E
         3a2k3+kDJs7Yim5bn5UwqZY+fQN3+Z9RwumM1oo8HqPVOyR1/Iu8v3Q8T5EOZJ54V+dJ
         uTvthqIkNJ2osE6K6XTEy6x7M82oV7bRfd9Dk=
Received: by 10.101.67.1 with SMTP id u1mr1931956ank.10.1253089281458;
        Wed, 16 Sep 2009 01:21:21 -0700 (PDT)
Received: by 10.177.128.16 with SMTP id f16gr7048yqn.0;
	Wed, 16 Sep 2009 01:21:11 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.131.2 with SMTP id i2mr892987ebn.22.1253089269845; Wed, 16 Sep 2009 01:21:09 -0700 (PDT)
Received: by 10.211.131.2 with SMTP id i2mr892986ebn.22.1253089269815; Wed, 16 Sep 2009 01:21:09 -0700 (PDT)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215]) by gmr-mx.google.com with ESMTP id 15si1683167ewy.4.2009.09.16.01.21.08; Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.215 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f215.google.com with SMTP id 11so4248232ewy.11 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=CFxYT7oy4J/BS0SbXKuj2A7l8PaLP8vpnIAJzlX+wDQ=; b=dYJxYHOvYyhKJMwohujnD0DU01UzkXQzPKJhKRv75syhlvXEvQ+M5vn7HopJpqv9uf KvXgGEt6JpUj1Ao4VwEKRtqyyZ/2kavhxBtjBW0q6mNz37f3T9koSohkkwgF6PjgAmqW 6AdZGXNvUpoFwWPgEHKH2NTe3lA0V18uiB8GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=wxKUzHmpC6FASqaKSGETI4CoUgwGTtIq9geg4M+YGLf+ynsJirwgv8HCMRdm+Et7Kc gTslegyv1JfXJ7nsPb+71q6NNXj/Q03f+2S/wl7p4yfw9ovUuPWmAVj5s2A7ttXYhx0X mfFzTxaLwKC3XVFoOCp0Chjg7Gb9w8dXWH51s=
Received: by 10.210.96.23 with SMTP id t23mr2034895ebb.11.1253089268729; Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.21.07 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <49b1712beea2ac9eb00c61c8d92c035a7c412d69.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128629>


Based on original README patch from Frank Li

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/vcbuild/README |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/README

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
new file mode 100644
index 0000000..354526a
--- /dev/null
+++ b/compat/vcbuild/README
@@ -0,0 +1,39 @@
+The Steps of Build Git with VS2008
+
+1. You need the build environment, which contains the Git dependencies
+   to be able to compile, link and run Git with MSVC.
+
+   You can either use the binary repository:
+
+       WWW: http://repo.or.cz/w/msvcgit.git
+       Git: git clone git://repo.or.cz/msvcgit.git
+       Zip: http://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
+
+   and call the setup_32bit_env.cmd batch script before compiling Git,
+   (see repo/package README for details), or the source repository:
+
+       WWW: http://repo.or.cz/w/gitbuild.git
+       Git: git clone git://repo.or.cz/gitbuild.git
+       Zip: (None, as it's a project with submodules)
+
+   and build the support libs as instructed in that repo/package.
+
+2. Ensure you have the msysgit environment in your path, so you have
+   GNU Make, bash and perl available.
+
+       WWW: http://repo.or.cz/w/msysgit.git
+       Git: git clone git://repo.or.cz/msysgit.git
+       Zip: http://repo.or.cz/w/msysgit.git?a=snapshot;h=master;sf=zip
+
+   This environment is also needed when you use the resulting
+   executables, since Git might need to run scripts which are part of
+   the git operations.
+
+3. Inside Git's directory run the command:
+       make common-cmds.h
+   to generate the common-cmds.h file needed to compile git.
+
+4. Then build Git with the GNU Make Makefile in the Git projects root
+       make MSVC=1
+
+Done!
-- 
1.6.2.1.418.g33d56.dirty
