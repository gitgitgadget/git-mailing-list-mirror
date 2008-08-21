From: imyousuf@gmail.com
Subject: [JGit Patch v2 1/7] Add a POM file for setting JGit library as a Maven project
Date: Thu, 21 Aug 2008 09:13:08 +0600
Message-ID: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0dT-0007ZL-PV
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbYHUDNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbYHUDNa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:13:30 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:19238 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbYHUDN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:13:28 -0400
Received: by ik-out-1112.google.com with SMTP id c28so587180ika.5
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UEm0ZFivlI/3MFuY8f6K3B0QGiGNVsMatCHT5uAhnKQ=;
        b=Lu21e4iuQX+mTQLhCom5jQIhtlmQ0NwKrJyZiS9OWU0F0vYSxbLzqlDEjNjot3LEP+
         mif9T0JCZM3KZA9GBfTty6xDRC/xDZ27oRh4txrTKQlrxOREi8IjREhmBP6/ZL66H0xo
         BEaq6PJTXZN52MmurLPNdnETOqT/fXpQpVf3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Sz986SUwwexeXloNuBrG7VE8rPitruu6QVlpBRLfoWQGaR6rddJO4TAkAYUzEV047p
         S4BTc2dKJ7OX7/VW34Q+Kp3Fh3et+a50HQSMVaK4qrN1PxkCm5PQYwbC1pg+qv3XotOn
         NqkDU6MldbIsBgSiLECeAEbfPVKVtn8FHuszM=
Received: by 10.210.25.18 with SMTP id 18mr1146326eby.152.1219288406660;
        Wed, 20 Aug 2008 20:13:26 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id h7sm3703093nfh.4.2008.08.20.20.13.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:13:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93100>

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
