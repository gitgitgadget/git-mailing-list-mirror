From: imyousuf@gmail.com
Subject: [Sample-Conversion-PATCH 1/2] Add JGit IO module as dependency to the main module
Date: Sun, 11 Oct 2009 21:10:12 +0700
Message-ID: <1255270213-14514-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwzAI-00016h-Rv
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbZJKOLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbZJKOLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:11:09 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54566 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbZJKOLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:11:08 -0400
Received: by ewy4 with SMTP id 4so1832269ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EFOrg8/kkDGiNAt8ncTxgpzzkGvQryllpdiUvuNaBUA=;
        b=h2kVocvxvjb4mP87j2iRWnQ8YlgrGq3JX3qRVAd4/MtAIVaygM8XfdvbuN2q7u5OQe
         Klm6QiYX0CSsXIcgSsFGltYPC6oWjCOKPpJVuLtGnrk/E9Q5N5dzms4strrhrpd0uzWv
         CmS/N7QJ1HxccibXq2DjvkX9SQVRVgOomiOgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pKe/s6niyR9yQsHuCfXknXN2g9z0Bp+GJ5gVDD9UhAcFua3gmkT5u3deJsXhIuMuKE
         sYezOKwrgn8jp5Uvz/llN7kr1Vz2bUdgh6Wa5IsFWv6p4Tt9JqQsPLVHq7XMHNNj6Tvn
         BVeJH/ZM+vmvGIV8E9e6NgrpTfMYY9RXH6FxI=
Received: by 10.211.144.7 with SMTP id w7mr2892247ebn.90.1255270231032;
        Sun, 11 Oct 2009 07:10:31 -0700 (PDT)
Received: from localhost.localdomain ([119.30.36.8])
        by mx.google.com with ESMTPS id 5sm37635eyh.10.2009.10.11.07.10.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:10:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129931>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/jgit/pom.xml |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index 9eb5758..7176db9 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -62,6 +62,12 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
             <scope>test</scope>
         </dependency>
         <dependency>
+            <groupId>org.eclipse</groupId>
+            <artifactId>jgit-io</artifactId>
+            <version>${project.version}</version>
+            <scope>compile</scope>
+        </dependency>
+        <dependency>
             <groupId>com.jcraft</groupId>
             <artifactId>jsch</artifactId>
             <version>0.1.41</version>
-- 
1.6.2.1
