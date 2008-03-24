From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 1/4] Add private modifier for private variables in the FindToolbar.
Date: Sun, 23 Mar 2008 22:57:14 -0400
Message-ID: <1206327434-6480-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 02:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdbxl-0004xP-GM
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYCXB6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbYCXB6V
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:58:21 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1380 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753368AbYCXB6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:58:20 -0400
Received: (qmail 4316 invoked by uid 0); 23 Mar 2008 23:00:47 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.821569 secs); 24 Mar 2008 02:00:47 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.228.249)
  by cvxbsd.convex.com.br with SMTP; 24 Mar 2008 02:00:47 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77990>

I overlooked this when doing the find toolbar. Fixing now.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Hi Robin,

Here goes some more patches for your review. Currently they are on top of the last
patches I sent you.

Patch 4/4 is the one that shows only the commits in the current branch. I don't see me
going through Shawn's new machinery soon, so I'm just sending what I have today as a 
starting point for the feature.

[]s,
Roger.

 .../src/org/spearce/egit/ui/FindToolbar.java       |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
index 5527453..3d2472c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
@@ -65,27 +65,27 @@ public class FindToolbar extends Composite {
 	 */
 	public final FindResults findResults = new FindResults();
 
-	Preferences prefs = Activator.getDefault().getPluginPreferences();
+	private Preferences prefs = Activator.getDefault().getPluginPreferences();
 
-	List<Listener> eventList = new ArrayList<Listener>();
+	private List<Listener> eventList = new ArrayList<Listener>();
 
 	private Image nextIcon;
 
 	private Image previousIcon;
 
-	Table historyTable;
+	private Table historyTable;
 
-	List<IFileRevision> fileRevisions;
+	private List<IFileRevision> fileRevisions;
 
-	Text patternField;
+	private Text patternField;
 
-	Button nextButton;
+	private Button nextButton;
 
-	Button previousButton;
+	private Button previousButton;
 
-	Label currentPositionLabel;
+	private Label currentPositionLabel;
 
-	ProgressBar progressBar;
+	private ProgressBar progressBar;
 
 	private String lastErrorPattern;
 
-- 
1.5.4.1
