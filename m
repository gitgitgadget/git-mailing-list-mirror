From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCH 2/3] gitweb: update INSTALL regarding specific snapshot settings
Date: Thu, 6 Aug 2009 10:27:26 -0400
Message-ID: <E4954DAB-6EA1-461F-8698-AAEC1E8F455F@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 16:28:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ3wz-0001Ka-IV
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 16:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbZHFO1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 10:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZHFO1e
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 10:27:34 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:62077 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751509AbZHFO1e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 10:27:34 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n76ERVKM000290
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 6 Aug 2009 10:27:34 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Thu, 06 Aug 2009 10:27:34 -0400 (EDT)
X-Miltered: at mailchk-w02 with ID 4A7AE853.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m01
X-Virus-Status: Clean
X-UUID: 74b04b62-99ea-43bc-99b8-5bda9b6c0b01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125071>

This includes instructions on how to disable a snapshot format and how
to add options to a snapshot format (e.g. setting the compression
level).

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/INSTALL |    9 +++++++++
  1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 18c9ce3..3d267da 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -123,6 +123,15 @@ GITWEB_CONFIG file:
  	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
  	$feature{'snapshot'}{'override'} = 1;

+If you allow overriding for the snapshot feature, you can specify which
+snapshot formats are globally disabled. You can also add any command  
line
+options you want (such as setting the compression level). For instance,
+you can disable Zip compressed snapshots and set GZip to run at level  
6 by
+adding the following lines to your $GITWEB_CONFIG:
+
+	$known_snapshot_formats{'zip'}{'disabled'} = 1;
+	$known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
+

  Gitweb repositories
  -------------------
-- 
1.6.4
