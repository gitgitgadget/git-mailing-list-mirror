From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Remove trailing white space
Date: Mon, 27 Feb 2006 22:42:07 +0530
Message-ID: <440332E7.70201@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070508070700050205080904"
X-From: git-owner@vger.kernel.org Mon Feb 27 18:13:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDlv4-00070O-Th
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 18:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWB0RMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 12:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWB0RMT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 12:12:19 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:47318 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751500AbWB0RMS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 12:12:18 -0500
Received: by wproxy.gmail.com with SMTP id i32so881496wra
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 09:12:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=sOsrvxCqunusNM2FQdvGVQMjerp4tTMPbuoHdRC4fpLqfJ0cIdMS5/hD1ZRa+K4W+mj+2NI8n52Xh3ctTvNW4n4/W3BUyH6UATKv7EgeHTCjyqJhjfWhYoE+xtJi44Nzn74DJUDAvy92ixytzKOBxE/cDn/49trtJhx5fxs4WOk=
Received: by 10.35.111.7 with SMTP id o7mr2350759pym;
        Mon, 27 Feb 2006 09:12:16 -0800 (PST)
Received: from ?192.168.2.39? ( [59.92.140.66])
        by mx.gmail.com with ESMTP id i64sm1534381pye.2006.02.27.09.12.13;
        Mon, 27 Feb 2006 09:12:15 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16865>

This is a multi-part message in MIME format.
--------------070508070700050205080904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070508070700050205080904
Content-Type: text/plain;
 name="0002-gitview-Remove-trailing-white-space.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-gitview-Remove-trailing-white-space.txt"

Subject: gitview: Remove trailing white space

Do the cleanup using Dave jones vim script

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

69e8209d5152b187dbcf2c09c5db5ae7534a80d5
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 1d042e3..048caf6 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -162,7 +162,7 @@ class CellRendererGraph(gtk.GenericCellR
 			for item in names:
 				names_len += len(item)
 
-		width = box_size * (cols + 1 ) + names_len 
+		width = box_size * (cols + 1 ) + names_len
 		height = box_size
 
 		# FIXME I have no idea how to use cell_area properly
@@ -261,11 +261,11 @@ class Commit:
 	children_sha1 = {}
 
 	def __init__(self, commit_lines):
-		self.message 		= ""
+		self.message		= ""
 		self.author		= ""
-		self.date 		= ""
-		self.committer 		= ""
-		self.commit_date 	= ""
+		self.date		= ""
+		self.committer		= ""
+		self.commit_date	= ""
 		self.commit_sha1	= ""
 		self.parent_sha1	= [ ]
 		self.parse_commit(commit_lines)
@@ -426,7 +426,7 @@ class GitView:
 
 	def __init__(self, with_diff=0):
 		self.with_diff = with_diff
-		self.window =  	gtk.Window(gtk.WINDOW_TOPLEVEL)
+		self.window =	gtk.Window(gtk.WINDOW_TOPLEVEL)
 		self.window.set_border_width(0)
 		self.window.set_title("Git repository browser")
 
@@ -878,15 +878,15 @@ class GitView:
 
 		# Reset nodepostion
 		if (last_nodepos > 5):
-			last_nodepos = -1 
+			last_nodepos = -1
 
 		# Add the incomplete lines of the last cell in this
 		try:
 			colour = self.colours[commit.commit_sha1]
 		except KeyError:
 			self.colours[commit.commit_sha1] = last_colour+1
-			last_colour = self.colours[commit.commit_sha1] 
-			colour =   self.colours[commit.commit_sha1] 
+			last_colour = self.colours[commit.commit_sha1]
+			colour =   self.colours[commit.commit_sha1]
 
 		try:
 			node_pos = self.nodepos[commit.commit_sha1]
@@ -918,7 +918,7 @@ class GitView:
 				self.colours[parent_id] = last_colour+1
 				last_colour = self.colours[parent_id]
 				self.nodepos[parent_id] = last_nodepos+1
-				last_nodepos = self.nodepos[parent_id] 
+				last_nodepos = self.nodepos[parent_id]
 
 			in_line.append((node_pos, self.nodepos[parent_id],
 						self.colours[parent_id]))
@@ -954,7 +954,7 @@ class GitView:
 			try:
 				next_commit = self.commits[index+1]
 				if (next_commit.commit_sha1 == sha1 and pos != int(pos)):
-				# join the line back to the node point 
+				# join the line back to the node point
 				# This need to be done only if we modified it
 					in_line.append((pos, pos-0.5, self.colours[sha1]))
 					continue;
-- 
1.2.3.g2cf3-dirty


--------------070508070700050205080904--
