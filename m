From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 13/14] Add README for MSVC build
Date: Tue, 15 Sep 2009 15:44:16 +0200
Message-ID: <22e0abb5a1e91c3ca95f8538d8396c167bb1028d.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com> <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com> <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com> <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com> <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstorm
 o@gmail.com> <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com> <9fc49662e1ec00388adb3d50c41d20561ed58939.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:14 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLI-0007Fa-EP
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:12 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so11220463ywh.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Bdm2UldpKTKpXp4jyLP8FGvd2nq5qj9gDOHIlqitBE0=;
        b=f9nXOOZJjss5FcTTQZAQOw3dnJgKV0oJ6ugRVD5UT0cb4h3FwK0bTkt4t6xO7/HjzS
         2rm1fkY4ak6HKCbwkYqibqY/nlkvfLs7V3TYRrMpW4V+z/5bkJfbPlFeJUnM//fkFizH
         gaQLDCp30en2yPOJ+jkc4xuvzZpHXloHWrOA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=nW6KEYfT7sOao7R1Gc+NaGL9NeTCYJ7+jZy3HVWa94ewF8h3JsPDK17hbMMby0p+qv
         skFadfrcrFBnjSzdS7wU6OP20psXNqpinXH6iig4wQKdRVslTZ4xuuRZXfPjPb12Ldi4
         CAHskepMfb/HlhxU15rSBXuS0pRbwSO2vOQEs=
Received: by 10.150.68.1 with SMTP id q1mr95716yba.1.1253022302792;
        Tue, 15 Sep 2009 06:45:02 -0700 (PDT)
Received: by 10.176.145.38 with SMTP id s38gr7020yqd.0;
	Tue, 15 Sep 2009 06:44:58 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.161.31 with SMTP id n31mr1131750ebo.5.1253022297071; Tue, 15 Sep 2009 06:44:57 -0700 (PDT)
Received: by 10.211.161.31 with SMTP id n31mr1131748ebo.5.1253022296138; Tue, 15 Sep 2009 06:44:56 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146]) by gmr-mx.google.com with ESMTP id 16si1531026ewy.7.2009.09.15.06.44.55; Tue, 15 Sep 2009 06:44:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.146 as permitted sender) client-ip=74.125.78.146;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.146 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 5so733538eyb.6 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=FKql8wibHUlpN9Y8TkruBOPnRfaIH1lADZQccHg553s=; b=pPhwVwBYLNPc5sqrsd52BGxR/kBRCoKxHnmgqNjA7mOYe/Y/fSPlrFvB2IGPDP6Szp Sj4kHKkw4kyQ7etMBxs7QhozonPsqTHtzo87W1vLwh4n2n95bGjZPYTTMA7YD6Zt/bGO Qc+qcf9qCqrLTbERmXubkDlrPiLiqy0+HvQS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=XoW2aFDmGq3KK4RsHvRNC2Y/vOjg6b2NFY2hur2OdhJMxN24q035j+j8CJihOcaNdM XklvOXZWDYmOMeRqaUxy99NhFKhXsoBq95T6QewKbnCK1sT4f5MmlADXbt/jnC3dwdOP pypdWon9lD+LOhZFpqsf6+bGzddvv4CAmM3bk=
Received: by 10.210.3.14 with SMTP id 14mr877441ebc.61.1253022295039; Tue, 15 Sep 2009 06:44:55 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.53 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <9fc49662e1ec00388adb3d50c41d20561ed58939.1253021728.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128552>


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
