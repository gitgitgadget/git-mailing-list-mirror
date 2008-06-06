From: imyousuf@gmail.com
Subject: [JGIT PATCH/RFC] Add project information to maven pom
Date: Fri,  6 Jun 2008 17:57:21 +0600
Message-ID: <1212753441-27063-1-git-send-email-imyousuf@gmail.com>
Cc: imran.yousuf@smartitengineering.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 13:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4aaY-0006IG-GL
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 13:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbYFFL5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 07:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbYFFL5k
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 07:57:40 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:23660 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbYFFL5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 07:57:38 -0400
Received: by mu-out-0910.google.com with SMTP id w8so627525mue.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EdDUWuoRxiDRuIAD2t1xf7X340ENN0QvJSv2gW/3beQ=;
        b=CPf7Sq78Z1dNuUkvIJQ7MYQXQjLmksGJhWvys+saTo6oWTalBmpRNhFjd4/ZLSkUwl
         405G5WjVURyJDGjlymF0+NtG4uNE7yNwdSNSkRWch4dby7LiYsamQJfR65hbKU9lBeWb
         iDbpLFCB+ogOoZudakhI6VpOR5EhWvpy5Qx4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OLL2DbucZJNPE3x2h5AYpsWUNpGS5tYgEiBK7Gh36jk5wEbZ2jiLeK5IsY/XFuYcC5
         8u1Cl/a58ne5aLsl+gZ4f5GqjdPghjIGfAZ3ay8ye1vYqvouNbCMYtu1lHv4ik30yRs1
         JYkmp7zHWEdlYDxxZFIWDpiQQSLIzerkxoXSw=
Received: by 10.102.253.6 with SMTP id a6mr1471660mui.92.1212753456982;
        Fri, 06 Jun 2008 04:57:36 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id t10sm7101258muh.17.2008.06.06.04.57.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 04:57:35 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84050>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Project information such as URL, mailing list, developer information, license
is added to the pom file.

The pom file is also reformatted for better view.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/jgit/pom.xml |  155 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 137 insertions(+), 18 deletions(-)

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index a694353..4326f26 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -1,13 +1,132 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
-  <modelVersion>4.0.0</modelVersion>
-  <groupId>org.spearce</groupId>
-  <artifactId>jgit</artifactId>
-  <packaging>jar</packaging>
-  <version>1.0-SNAPSHOT</version>
-  <name>jgit</name>
-  <url>http://maven.apache.org</url>
-  <build>
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
         <plugins>
             <plugin>
                 <artifactId>maven-compiler-plugin</artifactId>
@@ -19,18 +138,18 @@
             </plugin>
         </plugins>
     </build>
-  <dependencies>
-    <dependency>
-      <groupId>junit</groupId>
-      <artifactId>junit</artifactId>
-      <version>3.8.1</version>
-      <scope>test</scope>
-    </dependency>
-    <dependency>
+    <dependencies>
+        <dependency>
+            <groupId>junit</groupId>
+            <artifactId>junit</artifactId>
+            <version>3.8.1</version>
+            <scope>test</scope>
+        </dependency>
+        <dependency>
             <groupId>com.jcraft</groupId>
             <artifactId>jsch</artifactId>
             <version>0.1.38</version>
             <scope>compile</scope>
         </dependency>
-  </dependencies>
+    </dependencies>
 </project>
-- 
1.5.5.GIT
