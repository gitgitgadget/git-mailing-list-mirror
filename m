From: imyousuf@gmail.com
Subject: [JGIT PATCH 3/3] Add a POM file for setting JGit library as a Maven project
Date: Mon,  8 Sep 2008 09:07:36 +0600
Message-ID: <1220843256-1243-3-git-send-email-imyousuf@gmail.com>
References: <1220843256-1243-1-git-send-email-imyousuf@gmail.com>
 <1220843256-1243-2-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 05:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcX7y-0000Bt-55
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 05:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYIHDIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 23:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbYIHDIN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 23:08:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6647 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbYIHDIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 23:08:12 -0400
Received: by nf-out-0910.google.com with SMTP id d3so294795nfc.21
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 20:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=apRwymcHwBBqpFB9Ch0knn3LE2gVpioCY6NpUQ5seoA=;
        b=uxY4OTWeGWaZ3SkZio/vPsAZO10AypC/r6asWs/ChJiiI7empO0vxNbv4tImot5d3Y
         Km5d99F9vAcVuFVrjx2aYao25l5GfSTvrKjPqXQBIwz7vAkRj9UG32celJSlAhVCKTSr
         jj8MOpbPbBH5VgbKJ0pcCp99WPPXzdXF1gLxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DzZv9QqY00aqLpgM/ehb7EyLmxdN3E0iNovIp6DoCyzxktjQ758BEQhIR/cru8IsJ4
         O2gabTgTXnBt3fiqwdrcfrHqkv6rqiZAv/+tjDaacBSzZ84HRb96cGFawsxKkE+7ahIA
         u4yO5FnBwDu96QI/b2PylgTMTkO0CfdZAaPpE=
Received: by 10.210.48.14 with SMTP id v14mr18060808ebv.71.1220843291095;
        Sun, 07 Sep 2008 20:08:11 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id i4sm18761500nfh.1.2008.09.07.20.08.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 20:08:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1220843256-1243-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95211>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Add ignore list for mavenized JGit's artifacts directory.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/.gitignore   |    1 +
 jgit-maven/jgit/pom.xml |  169 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 0 deletions(-)
 create mode 100644 jgit-maven/.gitignore
 create mode 100644 jgit-maven/jgit/pom.xml

diff --git a/jgit-maven/.gitignore b/jgit-maven/.gitignore
new file mode 100644
index 0000000..eb5a316
--- /dev/null
+++ b/jgit-maven/.gitignore
@@ -0,0 +1 @@
+target
diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
new file mode 100644
index 0000000..c4d7c24
--- /dev/null
+++ b/jgit-maven/jgit/pom.xml
@@ -0,0 +1,169 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!--
+All rights reserved.
+Redistribution and use in source and binary forms, with or
+without modification, are permitted provided that the following
+conditions are met:
+
+Redistributions of source code must retain the above copyright
+notice, this list of conditions and the following disclaimer.
+
+Redistributions in binary form must reproduce the above
+copyright notice, this list of conditions and the following
+disclaimer in the documentation and/or other materials provided
+with the distribution.
+
+Neither the name of the Git Development Community nor the
+names of its contributors may be used to endorse or promote
+products derived from this software without specific prior
+written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+-->
+<project xmlns="http://maven.apache.org/POM/4.0.0" 
+        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
+        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+    <modelVersion>4.0.0</modelVersion>
+    <groupId>org.spearce</groupId>
+    <artifactId>jgit</artifactId>
+    <packaging>jar</packaging>
+    <version>0.4-SNAPSHOT</version>
+    <name>jgit</name>
+    <url>http://repo.or.cz/w/egit.git</url>
+    <mailingLists>
+        <mailingList>
+            <name>GIT Mailing List</name>
+            <post>git@vger.kernel.org</post>
+            <archive>http://marc.info/?l=git</archive>
+        </mailingList>
+    </mailingLists>
+    <description>Pure Java implementation of Git</description>
+    <developers>
+        <developer>
+            <name>Shawn O. Pearce</name>
+            <email>spearce@spearce.org</email>
+            <roles>
+                <role>Maintainer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Robin Rosenberg</name>
+            <email>robin.rosenberg@dewire.com</email>
+            <roles>
+                <role>Maintainer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Dave Watson</name>
+            <email>dwatson@mimvista.com</email>
+            <roles>
+                <role>Developer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Roger C. Soares</name>
+            <email>rogersoares@intelinet.com.br</email>
+            <roles>
+                <role>Developer</role>
+            </roles>
+	</developer>
+	<developer>
+            <name>Marek Zawirski</name>
+            <email>marek.zawirski@gmail.com</email>
+            <roles>
+                <role>Developer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Imran M Yousuf</name>
+            <email>imyousuf@smartitengineering.com</email>
+            <organization>Smart IT Engineering</organization>
+            <roles>
+                <role>Contributor</role>
+            </roles>
+        </developer>
+    </developers>
+    <licenses>
+        <license>
+            <name>3-clause (new-style) BSD license.</name>
+            <comments>
+                All rights reserved.
+                Redistribution and use in source and binary forms, with or
+                without modification, are permitted provided that the following
+                conditions are met:
+
+                Redistributions of source code must retain the above copyright
+                notice, this list of conditions and the following disclaimer.
+
+                Redistributions in binary form must reproduce the above
+                copyright notice, this list of conditions and the following
+                disclaimer in the documentation and/or other materials provided
+                with the distribution.
+
+                Neither the name of the Git Development Community nor the
+                names of its contributors may be used to endorse or promote
+                products derived from this software without specific prior
+                written permission.
+
+                THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+                CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+                INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+                OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+                ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+                CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+                SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+                NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+                LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+                CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+                STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+                ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+                ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+            </comments>
+        </license>
+    </licenses>
+    <build>
+        <sourceDirectory>../../org.spearce.jgit/src/</sourceDirectory>
+        <testResources>
+            <testResource>
+                <directory>../../org.spearce.jgit.test/tst-rsrc/</directory>
+            </testResource>
+        </testResources>
+        <testSourceDirectory>../../org.spearce.jgit.test/tst/</testSourceDirectory>
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
+    <dependencies>
+        <dependency>
+            <groupId>junit</groupId>
+            <artifactId>junit</artifactId>
+            <version>3.8.1</version>
+            <scope>test</scope>
+        </dependency>
+        <dependency>
+            <groupId>com.jcraft</groupId>
+            <artifactId>jsch</artifactId>
+            <version>0.1.38</version>
+            <scope>compile</scope>
+        </dependency>
+    </dependencies>
+</project>
-- 
1.5.6
