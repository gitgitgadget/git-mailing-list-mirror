From: imyousuf@gmail.com
Subject: [JGit Patch 1/6] Add a POM file for setting JGit library as a Maven project
Date: Thu, 21 Aug 2008 08:47:23 +0600
Message-ID: <1219286848-22758-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 04:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0EW-0002Fb-Do
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYHUCsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbYHUCsC
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:48:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63077 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYHUCsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:48:00 -0400
Received: by nf-out-0910.google.com with SMTP id d3so366908nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 19:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UEm0ZFivlI/3MFuY8f6K3B0QGiGNVsMatCHT5uAhnKQ=;
        b=kasv59D4wCqf3gfbOolYZfnfHSohMLwXNGT8luImh/5eePFuR1DMVvmp9BdGJLsFxP
         bPlj8DZAXd2etTXhkpEUYgjgvaP3wDEByemQhNk1/Ekf2Q1JJfFcxWnj8ZjtEhjJ8Iu6
         7ZN1loMs0p29rlPMsS7i3MtjdPTgdXIx+106E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=axd0GEc6JiIt7PRnSORAfjmoDgDQKHfCb/7aOJ/jqJpODxCRlQdF82edNwOQI07mkN
         6xvCu/k9UzERbX0+jfMfiNUGxVoZkTZDgMo9c1FuClzGKmvTlPcM0QhglsebhuD6Tav/
         tawaOev6Ul8FbkCC1BlfswdDsa1kunFg2pd5k=
Received: by 10.210.46.12 with SMTP id t12mr1118228ebt.64.1219286878709;
        Wed, 20 Aug 2008 19:47:58 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id d23sm3337879nfh.11.2008.08.20.19.47.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 19:47:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93092>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/jgit/pom.xml |  169 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 169 insertions(+), 0 deletions(-)
 create mode 100644 jgit-maven/jgit/pom.xml

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
