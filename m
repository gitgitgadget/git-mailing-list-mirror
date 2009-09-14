From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 16/17] Add README for MSVC build
Date: Mon, 14 Sep 2009 15:11:29 +0200
Message-ID: <686c174b95c6e20977cbb43e462f6d280a228035.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
 o@gmail.com> <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com> <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com> <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com> <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com> <abaa803c30801c570f4b8e1baf6648a482bf295d.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:32 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f157.google.com ([209.85.210.157])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBN5-0004Ql-8T
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:31 +0200
Received: by mail-yx0-f157.google.com with SMTP id 29so6077722yxe.16
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Bdm2UldpKTKpXp4jyLP8FGvd2nq5qj9gDOHIlqitBE0=;
        b=AlsW0JmdbemVG81LuY8SrEQiRGNEKKvxs7dNMfc7/dylHk/9q8RKTQXluYy5gYY1Mj
         jHgFctcpjDh/mNjZcLZPx7Swrrk17LZiW5Kx6tBbrqAByvLFqpBBIkKNtRQDBOx5ctur
         +oOQmobv1vBufGhn/HbR+ZJyIAbnA5QqWjUNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=GBY4kR9Qq0XY1LmifgSV9alQkLEUYEu+lFbT7Jc29zMWCGirLJVpRMu3jwXIxnzKZG
         GlgcoJOxDmLlQ+UOFXOmaBrHAMe5KwpP1+tKpFHmQ4wctVkVIRHRfZ5A1D1ZRJoV+GD3
         +o+DkhreefnKWGWE0Ljv2z8OFIWLyphBrJoIk=
Received: by 10.150.168.4 with SMTP id q4mr1951174ybe.24.1252934005047;
        Mon, 14 Sep 2009 06:13:25 -0700 (PDT)
Received: by 10.176.168.4 with SMTP id q4gr6973yqe.0;
	Mon, 14 Sep 2009 06:13:12 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.146.33 with SMTP id y33mr696227ebn.6.1252933991676; Mon, 14 Sep 2009 06:13:11 -0700 (PDT)
Received: by 10.211.146.33 with SMTP id y33mr696226ebn.6.1252933991633; Mon, 14 Sep 2009 06:13:11 -0700 (PDT)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214]) by gmr-mx.google.com with ESMTP id 13si1273811ewy.2.2009.09.14.06.13.10; Mon, 14 Sep 2009 06:13:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f214.google.com with SMTP id 10so3192606ewy.13 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=FKql8wibHUlpN9Y8TkruBOPnRfaIH1lADZQccHg553s=; b=nkICbroLXiqh394EXLbPiNnXW1pHYpzMoy/9nMjYvSB2V5FSpRgkY02rvAt1/Qa0Zf zjWKkGiMIhWmr1ZkzhEHiuilzpuVZCTzkHdriOjtq0M2syiGpysvy1eFa68VBe3jiGoA mBEIDiM/S1ooIQ+Wwa0wGHuz29NfITVFnzeWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=aNAYqN6BWHNjV6QMiz06ZQlPKz1EZnl3INsC+/VNisent5LGU/dg1aj76nuri5X30p 6Hhd8SkxTrmAzN6ych8Un/nFUyJw3OaYt3fTfUmanG497IrKO/3DhZu+xiQyPcW5DG0j qArQmsap9GLFG4pg9DZg29/AXZ671zq5aHPt4=
Received: by 10.211.174.10 with SMTP id b10mr6977464ebp.39.1252933990411; Mon, 14 Sep 2009 06:13:10 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.13.08 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:13:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <abaa803c30801c570f4b8e1baf6648a482bf295d.1252925290.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128475>


Based on original README patch from Frank Li

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/vcbuild/README |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/README

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
new file mode 100644
index 0000000..5d7a07a
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
+4. Inside Git's directory run the command:
+       make common-cmds.h
+   to generate the common-cmds.h file needed to compile git.
+
+5. Then build Git with the GNU Make Makefile in the Git projects root
+       make MSVC=1
+
+Done!
-- 
1.6.2.1.418.g33d56.dirty
