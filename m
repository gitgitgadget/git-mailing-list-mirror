From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 0/2] git-p4 support for older python
Date: Fri, 25 Jan 2013 12:43:59 -0800
Message-ID: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pw@padd.com, esr@thyrsus.com, john@keeping.me.uk,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 21:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyq8h-0006Cl-6j
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3AYUoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:44:21 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8959 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab3AYUoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:44:20 -0500
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B5102ef9a0000>; Fri, 25 Jan 2013 12:48:26 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2013 12:43:52 -0800
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Fri, 25 Jan 2013 12:43:52 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Fri, 25 Jan 2013
 12:44:07 -0800
X-Mailer: git-send-email 1.8.1.1.297.gad3d74e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214579>

Offered for consideration.

These two patches allow git-p4 to run on python 2.4 which is shipped on
RHEL 5.X.  The changes are minor and unintrusive in my opinion, but please
feel free to reject one or both of them for any reason (in which case the
version check at the top of git-p4.py should be updated).

Brandon Casey (2):
  git-p4.py: support Python 2.5
  git-p4.py: support Python 2.4

 INSTALL                    |  2 +-
 git-p4.py                  | 30 ++++++++++++++++++++++++++----
 t/t9802-git-p4-filetype.sh | 11 ++++++-----
 3 files changed, 33 insertions(+), 10 deletions(-)

-- 
1.8.1.1.297.gad3d74e


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
