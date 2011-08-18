From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/4] Support threshold in copy/rename detection
Date: Thu, 18 Aug 2011 02:04:15 +0100
Message-ID: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 03:04:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtr2L-00037C-8A
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 03:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab1HRBEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 21:04:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50548 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab1HRBEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 21:04:39 -0400
Received: by wwf5 with SMTP id 5so1539887wwf.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 18:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OFEKEjCOgK910G42x6WDRYD1stU2cDWKpw9v0jMAE10=;
        b=TeRhNViXOU6slgNo5NUn1ZkapzjjQZ0/Nxivxef3wNpueDijbFIi0ULnv1WEV7Ixrf
         K4cfnKCxe8fUlGuQbf4HG6OEnmDIglyKM5X7IFYP4cuJL3C6/ogyobp7U7/xZum2CHaw
         o8l9YmDRoRA0/WfQ0vkXP/RFp/y0svSYJvCg8=
Received: by 10.227.201.81 with SMTP id ez17mr99763wbb.3.1313629478304;
        Wed, 17 Aug 2011 18:04:38 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fm9sm1343282wbb.27.2011.08.17.18.04.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 18:04:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179546>

Add possibility of configuring a threshold in the copy and rename detections.
Copy and rename detection options were not documented and no test cases existed
for it. This is corrected in this set of patches.

Vitor Antunes (4):
  git-p4: Allow setting rename/copy detection threshold.
  git-p4: Add description of rename/copy detection options.
  git-p4: Add test case for rename detection.
  git-p4: Add test case for copy detection.

 contrib/fast-import/git-p4     |   18 ++++--
 contrib/fast-import/git-p4.txt |   25 ++++++++
 t/t9800-git-p4.sh              |  121 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 5 deletions(-)

-- 
1.7.5.4
