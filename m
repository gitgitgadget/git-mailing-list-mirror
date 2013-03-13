From: Ismail Tabtabai <itabtabai@me.com>
Subject: Deletion of git repo causes incorrect block count on HFS+
 case-sensitive
Date: Wed, 13 Mar 2013 21:45:37 +0300
Message-ID: <B6ED348A-2168-42F5-B6EC-81D7E62805ED@me.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 20:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFrd1-0001k3-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934188Ab3CMTpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 15:45:50 -0400
Received: from nk11p04mm-asmtpout001.mac.com ([17.158.236.236]:58768 "EHLO
	nk11p04mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934180Ab3CMTpt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 15:45:49 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2013 15:45:49 EDT
Received: from [192.168.1.5] ([188.236.229.0]) by nk11p04mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-26.01(7.0.4.26.0) 64bit (built Jul
 13 2012)) with ESMTPSA id <0MJM00M9Y441Y230@nk11p04mm-asmtp001.mac.com> for
 git@vger.kernel.org; Wed, 13 Mar 2013 18:45:48 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8626,1.0.431,0.0.0000
 definitions=2013-03-13_08:2013-03-13,2013-03-13,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=38 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=6.0.2-1302030000
 definitions=main-1303130122
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218085>

Hello,

When I delete a git repo that I have cloned on my machine using 'rm -rf repo-name' I get an incorrect block count when I attempt a Disk Repair.

I am running OS X 10.8.2 on a user installed SSD. The git version is 1.8.1.5.


Checking file systemChecking Journaled HFS Plus volume.
Detected a case-sensitive volume.
Checking extents overflow file.
Checking catalog file.
Incorrect block count for file pack-8c0dc1a398a22c58ea1eba09de3ee9d935ad1ea3.pack
(It should be 4865 instead of 12244)
Incorrect block count for file pack-db61a037ad0e043e801d8ba1db98b1af14d466af.pack
(It should be 5889 instead of 12245)
Incorrect block count for file pack-db61a037ad0e043e801d8ba1db98b1af14d466af.pack
(It should be 6220 instead of 12245)
Incorrect block count for file pack-286c1444bc32ee2ed0af1d15070e0e31f22ba0a8.pack
(It should be 7937 instead of 12246)
Checking multi-linked files.
Checking catalog hierarchy.
Checking extended attributes file.
Checking volume bitmap.
Volume bitmap needs minor repair for orphaned blocks
Checking volume information.
Invalid volume free block count
(It should be 85306183 instead of 85282114)
Repairing volume.
Rechecking volume.
Checking Journaled HFS Plus volume.
Detected a case-sensitive volume.
Checking extents overflow file.
Checking catalog file.
Checking multi-linked files.
Checking catalog hierarchy.
Checking extended attributes file.
Checking volume bitmap.
Checking volume information.
The volume avicenna was repaired successfully.
Volume repair complete.Updating boot support partitions for the volume as required.
