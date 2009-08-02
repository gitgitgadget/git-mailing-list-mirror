From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv3 3/3] gitweb
Date: Sat, 1 Aug 2009 22:53:26 -0400
Message-ID: <045A5E91-831A-4135-AC9B-D5D14A6B1D9C@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 04:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXRCg-00008K-2l
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 04:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbZHBCxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 22:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZHBCxa
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 22:53:30 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:40071 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751769AbZHBCx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 22:53:27 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n722rGjU019601
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 1 Aug 2009 22:53:27 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 01 Aug 2009 22:53:27 -0400 (EDT)
X-Miltered: at mailchk-m01 with ID 4A74FF9D.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-x02
X-Virus-Status: Clean
X-UUID: 1d9d9c45-fea4-469a-8812-9cc546092873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124657>

Comments?

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca

------->8---------
From: Mark Rada <marada@uwaterloo.ca>
Date: Sat, 1 Aug 2009 22:36:54 -0400
Subject: [PATCH 3/3] gitweb: update documentation w.r.t. snapshot  
format disabling

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/INSTALL |    5 +++++
  1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 18c9ce3..ea22615 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -123,6 +123,11 @@ GITWEB_CONFIG file:
  	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
  	$feature{'snapshot'}{'override'} = 1;

+Furthermore, if you enable overriding of the snapshot feature you can
+still disable specific comrpession formats from being used by adding
+lines such as the following to your GITWEB_CONFIG file:
+
+	$known_snapshot_formats{'txz'}{'disabled'} = 1;

  Gitweb repositories
  -------------------
-- 
1.6.4
