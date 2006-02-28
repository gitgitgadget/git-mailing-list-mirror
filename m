From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Set the default width  of graph cell
Date: Tue, 28 Feb 2006 20:10:28 +0530
Message-ID: <440460DC.7080307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060809010208030002030705"
X-From: git-owner@vger.kernel.org Tue Feb 28 15:40:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE61p-0006YQ-4j
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 15:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWB1Oki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 09:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWB1Okh
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 09:40:37 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:43872 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750965AbWB1Okh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 09:40:37 -0500
Received: by wproxy.gmail.com with SMTP id 57so1113479wri
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 06:40:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=mVrxGTssFcA3GSv0jQPhjBA/EfntwYVaXgVo9fuaxydqBvt249+kKEmq0SC+LVs79jHT+gdcvaDxCusXjUf4JcYLreVKj/5F2pp70cf0lFwWCUbSmFmIWA8HK2eyfdVSayMBtn3gFqlDwgdvXIqRHNsHjxcEKQ4+UH72CGCaLFA=
Received: by 10.35.78.13 with SMTP id f13mr678394pyl;
        Tue, 28 Feb 2006 06:40:36 -0800 (PST)
Received: from ?192.168.2.39? ( [59.92.150.81])
        by mx.gmail.com with ESMTP id n78sm2386980pyf.2006.02.28.06.40.34;
        Tue, 28 Feb 2006 06:40:36 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16937>

This is a multi-part message in MIME format.
--------------060809010208030002030705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060809010208030002030705
Content-Type: text/plain;
 name="0003-gitview-Set-the-default-width-of-graph-cell.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-gitview-Set-the-default-width-of-graph-cell.txt"

Subject: gitview: Set the default width  of graph cell

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

b298aa0ee1d98b263fe3d493f2911164a4488693
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 47ecaa3..ea05cd4 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -526,6 +526,9 @@ class GitView:
 		self.treeview.show()
 
 		cell = CellRendererGraph()
+		#  Set the default width to 265
+		#  This make sure that we have nice display with large tag names
+		cell.set_property("width", 265)
 		column = gtk.TreeViewColumn()
 		column.set_resizable(True)
 		column.pack_start(cell, expand=True)
-- 
1.2.3.gc55f-dirty


--------------060809010208030002030705--
