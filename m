From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add maven distribution management info for the new
	snapshot repository
Date: Wed, 12 Nov 2008 00:48:58 +0100
Message-ID: <20081111234858.GA17662@diku.dk>
References: <4919EECB.7070408@wellfleetsoftware.com> <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com> <20081111214434.GS2932@spearce.org> <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com> <20081111231106.GT2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Farrukh Najmi <farrukh@wellfleetsoftware.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:50:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L02zx-0006si-E1
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 00:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYKKXtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYKKXtF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 18:49:05 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:51026 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbYKKXtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 18:49:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 1140019BBDB;
	Wed, 12 Nov 2008 00:49:01 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20746-01; Wed, 12 Nov 2008 00:48:58 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id B086719BBAA;
	Wed, 12 Nov 2008 00:48:58 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 75EAF6DF823; Wed, 12 Nov 2008 00:47:12 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 9602B39A355; Wed, 12 Nov 2008 00:48:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081111231106.GT2932@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100696>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 jgit-maven/jgit/pom.xml |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

 Shawn O. Pearce <spearce@spearce.org> wrote Tue, Nov 11, 2008:
 > Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
 > > I don't think admin rights are necessary as long as I have
 > > "commit"/webdav access. And no svn or git-svn interaction should be
 > > needed to upload to the maven repository.
 > 
 > Then have at it.  It sounds like it would be worthwhile setting up.

 Instructions at http://code.google.com/p/egit/wiki/ConfiguringMaven

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index a123470..c370783 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -185,4 +185,12 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
             <scope>compile</scope>
         </dependency>
     </dependencies>
+    <distributionManagement>
+        <snapshotRepository>
+            <id>jgit-maven-snapshot-repository</id>
+            <name>JGit Maven Snapshot Repository</name>
+            <url>dav:https://egit.googlecode.com/svn/maven/snapshot-repository/</url>
+            <uniqueVersion>true</uniqueVersion>
+        </snapshotRepository>
+    </distributionManagement>
 </project>
-- 
1.6.0.3.866.gc189b

-- 
Jonas Fonseca
