From: imyousuf@gmail.com
Subject: [JGIT PATCH] Change the POM file to take all the sources from the original location
Date: Fri,  6 Jun 2008 11:49:40 +0600
Message-ID: <1212731380-13221-1-git-send-email-imyousuf@gmail.com>
Cc: imran.yousuf@smartitengineering.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 07:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Ur1-0004Im-4P
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 07:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYFFFuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 01:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYFFFuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 01:50:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25786 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbYFFFuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 01:50:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so641054ugf.16
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sLdWOlLpATszLpMujbQ8SquK9E2OJ057uBbmGOuqWMA=;
        b=Of1bedGeXcCZgUs4upv2a7L+lmsVvCUrqhT5PTWoOFobSBqjbT8lQ+4LyU5Xq8LhcP
         oh1ifMM+7iSl9xoC6NjO4AHt1eof4XAHEHgsdRYWRHyGTtpKHu2gK6zC6hCKpQDbKre6
         Hcwuc9K0yQd+lmgAIJSRUTNgdm0GlndvKtqBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Mu8X9B1pcLDx3J9DoE2kZZXdPvkCgZ8dMlaAusGuK1dT/vUMOMXnbYAltv7cVI+S7P
         ElVGZTUxgGuiDOp+ihIgtcojP8DPHZjsr0EEdNmNQAI3cAX8UNG7RgKOXrY4H4WaDFU+
         1tQPaV+pcYvRHMBnFd/QkqxNeG5jjfZ05FTEY=
Received: by 10.67.88.12 with SMTP id q12mr905731ugl.54.1212731402879;
        Thu, 05 Jun 2008 22:50:02 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 18sm16988702ugk.44.2008.06.05.22.49.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 22:50:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84026>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Maven POM has the option of specifying the location of source and test
source codes, utilizing that the old source locations are now used to
configure maven, thus keeping the old structure as it is and increasing
project spectrum.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/.gitignore                              |    1 +
 jgit-maven/jgit/pom.xml                            |   38 ++++++++++++++++++++
 ...ck-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx |  Bin 0 -> 1256 bytes
 ...k-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack |  Bin 0 -> 7811 bytes
 ...ck-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx |  Bin 0 -> 1088 bytes
 ...k-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack |  Bin 0 -> 164 bytes
 ...ck-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx |  Bin 0 -> 2696 bytes
 ...k-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack |  Bin 0 -> 5956 bytes
 ...ck-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx |  Bin 0 -> 1112 bytes
 ...k-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack |  Bin 0 -> 1643 bytes
 jgit-maven/jgit/tst/packed-refs                    |   13 +++++++
 11 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 jgit-maven/.gitignore
 create mode 100644 jgit-maven/jgit/pom.xml
 create mode 100644 jgit-maven/jgit/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
 create mode 100644 jgit-maven/jgit/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
 create mode 100644 jgit-maven/jgit/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
 create mode 100644 jgit-maven/jgit/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
 create mode 100644 jgit-maven/jgit/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
 create mode 100644 jgit-maven/jgit/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
 create mode 100644 jgit-maven/jgit/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
 create mode 100644 jgit-maven/jgit/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
 create mode 100644 jgit-maven/jgit/tst/packed-refs

diff --git a/jgit-maven/.gitignore b/jgit-maven/.gitignore
new file mode 100644
index 0000000..eb5a316
--- /dev/null
+++ b/jgit-maven/.gitignore
@@ -0,0 +1 @@
+target
diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
new file mode 100644
index 0000000..281b64c
--- /dev/null
+++ b/jgit-maven/jgit/pom.xml
@@ -0,0 +1,38 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+  <modelVersion>4.0.0</modelVersion>
+  <groupId>org.spearce</groupId>
+  <artifactId>jgit</artifactId>
+  <packaging>jar</packaging>
+  <version>1.0-SNAPSHOT</version>
+  <name>jgit</name>
+  <url>http://maven.apache.org</url>
+  <build>
+      <sourceDirectory>../../org.spearce.jgit/src/</sourceDirectory>
+      <testSourceDirectory>../../org.spearce.jgit.test/tst/</testSourceDirectory>
+        <plugins>
+            <plugin>
+                <artifactId>maven-compiler-plugin</artifactId>
+                <version>2.0.2</version>
+                <configuration>
+                    <source>1.5</source>
+                    <target>1.5</target>
+                </configuration>
+            </plugin>
+        </plugins>
+    </build>
+  <dependencies>
+    <dependency>
+      <groupId>junit</groupId>
+      <artifactId>junit</artifactId>
+      <version>3.8.1</version>
+      <scope>test</scope>
+    </dependency>
+    <dependency>
+            <groupId>com.jcraft</groupId>
+            <artifactId>jsch</artifactId>
+            <version>0.1.38</version>
+            <scope>compile</scope>
+        </dependency>
+  </dependencies>
+</project>
diff --git a/jgit-maven/jgit/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx b/jgit-maven/jgit/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
new file mode 100644
index 0000000000000000000000000000000000000000..84a6c0fbeae2b03eb6f8541a168b09504fde1cba
GIT binary patch
literal 1256
zcmZQz7zHGR03%Q>A<P6+g9|eQ<*12SfaXyPvjWW`2eSe7(F3ys?V%Uu0NOP|uw0sV
zQ|vLP(|J1=Bs}&0acxq^?{}WSG{qPk!ew^R?7X9$H=B<(AD8bo{_=mTfk~SsI<F?}
zP}%cDUa#Wgd<PePKgeJd2^81K|54+XGDFUJdQ$kr6R)gy$17DX28JU~)3F_`{}Z^M
zsBU>R?cVd)Q>xLK&lwoxEGFoNl>JhfUA1R!%Q3<5szwWWW_6&w*H-P<|Mh0JXFX?t
zskU8&ZZUI=f+^6PO-H9kesumV|42r%vhjZD@^=iH>@!`y8&2M~PjfQ&!G?2Fq;5?8
eX%jmw|NVt;D;2)|H+DQ*d;M_xp&!SeJpcfaylR~Q

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack b/jgit-maven/jgit/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
new file mode 100644
index 0000000000000000000000000000000000000000..99f4fdf23241e246452a248e16e06fe61a25caa0
GIT binary patch
literal 7811
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
VF_X5wDU%DqfX<W}*p>M_U6$l%8F&By

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx b/jgit-maven/jgit/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
new file mode 100644
index 0000000000000000000000000000000000000000..cf58d5baa11824217bb0c5eab7444fb406219885
GIT binary patch
literal 1088
zcmZQzpebMknm&q0!(cQG4Bj-rBVN|fu*k6I#_U}_-R;dTjE^|OnT@$;L<KU;I;(5&
j?04Gxtk_GkE3duSzFw<E`CW}`!gtH2lI+N+ZF^b)CtDqp

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack b/jgit-maven/jgit/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
new file mode 100644
index 0000000000000000000000000000000000000000..0b0001020a4a6bab7070f8eb407d14d49358bc13
GIT binary patch
literal 164
zcmV;V09*f1K|@Ob000620005Z2zZ<oj6n{<AP@lWykb9K!&0O)F~<4^eZT@s)wIww
zYofmwFOxY;riK?sf#e+-qC_Sid5AH)jOe`%IgAvnw(QA!XO(<6hFI72DN1OD>z_04
zFu@&ekGjK&x_2kdF8rZ&Texfa84%Ho*kj+rK@VChH5H&zs*rGkc2PeLbt>003z%9_
S0GiD$Fy{Ma?`mDr9jVq<)ko3*

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx b/jgit-maven/jgit/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
new file mode 100644
index 0000000000000000000000000000000000000000..2579301b8447e4d55480f65ae6c27fe1eb99bf4d
GIT binary patch
literal 2696
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
HTI2a2M6U-_

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack b/jgit-maven/jgit/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
new file mode 100644
index 0000000000000000000000000000000000000000..bb47c90d93b0b2276fc36b96bc8734085bde6007
GIT binary patch
literal 5956
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
Lym|>qET!-tbFbD2

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx b/jgit-maven/jgit/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
new file mode 100644
index 0000000000000000000000000000000000000000..d515f905f2c6791f9d2b78d9913f294f0f0ace85
GIT binary patch
literal 1112
zcmZQz7zLvtKy(N&0#%OUp&tfJz<7jWmc`wBpRYP!E;Z|S<|Jo-sVBk@1diPR%Jck9
z=--zVrR|zKU-Zz%JC2`%SZlBMIp}zZn!Il}cK;iH?;H2b&#cLYH#!dR+iqL`v;R*`
OBF{Gt!wD-lIsyQS%PGA8

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack b/jgit-maven/jgit/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
new file mode 100644
index 0000000000000000000000000000000000000000..72712b20beaf82edd5c4ff0f1630db9f24b45ba0
GIT binary patch
literal 1643
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

literal 0
HcmV?d00001

diff --git a/jgit-maven/jgit/tst/packed-refs b/jgit-maven/jgit/tst/packed-refs
new file mode 100644
index 0000000..f67a3ef
--- /dev/null
+++ b/jgit-maven/jgit/tst/packed-refs
@@ -0,0 +1,13 @@
+# pack-refs with: peeled 
+6db9c2ebf75590eef973081736730a9ea169a0c4 refs/heads/a
+7f822839a2fe9760f386cbbbcb3f92c5fe81def7 refs/heads/b
+6e1475206e57110fcef4b92320436c1e9872a322 refs/heads/c
+f73b95671f326616d66b2afb3bdfcdbbce110b44 refs/heads/d
+d0114ab8ac326bab30e3a657a0397578c5a1af88 refs/heads/e
+d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
+49322bb17d3acc9146f98c97d078513228bbf3c0 refs/heads/master
+6db9c2ebf75590eef973081736730a9ea169a0c4 refs/tags/A
+17768080a2318cd89bba4c8b87834401e2095703 refs/tags/B
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+8bbde7aacf771a9afb6992434f1ae413e010c6d8 refs/tags/spearce-gpg-pub
+^fd608fbe625a2b456d9f15c2b1dc41f252057dd7
-- 
1.5.5.GIT
