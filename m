From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/3] git p4: tag import/export bug fixes
Date: Fri, 11 May 2012 07:25:15 +0100
Message-ID: <1336717518-4214-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 08:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSjIA-0004Qx-1g
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 08:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318Ab2EKGZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 02:25:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48461 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab2EKGZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 02:25:24 -0400
Received: by weyu7 with SMTP id u7so167556wey.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 23:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=Ab3ZVwff0FCSuFTUB8qSGQya3Ckf+HasaoCGqOzoDMU=;
        b=MZ7u4jLO2waGyNi4b/kuI8VzbDCre/Lp5nqaXjryA3BHN89HxMGLmNI4md6D39ivkl
         /1fPQcKogcdzgQew5dfxS8vxp02eyiF58NdX4AyqJ4+TskyFIVRUNuw/sPIoJIJ+JGNO
         pd1RtTdvuMs//8AB6zhHgtn1TSZDwerh87mmUls74iH8PAp5E7X2pLoDAokfA292mvXU
         D2z3bA8ufZScb0lKTAhcUogmxtuZDX+ukHLbyn5Nt/enl7awzK3B7xBC1YeNTWLVMzCn
         NAJg8mjEJ/YKPVbhruI2rOapb+z9L+5MYwsufWN9ue1Va1/Ey/K0H6PDD+vOLjju9cr5
         uRXQ==
Received: by 10.180.109.197 with SMTP id hu5mr4455868wib.8.1336717522863;
        Thu, 10 May 2012 23:25:22 -0700 (PDT)
Received: from halilbut.local.diamand.org (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id h8sm13801629wix.4.2012.05.10.23.25.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 23:25:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.221.g3bf1d
X-Gm-Message-State: ALoCoQn37mzEWa+cnTjLnnITC7RbtdQaZiXR5z5+mihGgqBhXyCovnzEKY1c8k4BXLp8WZ/sYD9G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197658>

This patch series fixes two bugs in my git p4 import/export code, and
adds a test case for them.

Luke Diamand (3):
  git p4: add test for tag import/export enabled via config
  git p4: fix bug when verbose enabled with tag export
  git p4: fix bug when enabling tag import/export via config variables

 git-p4.py                      |    6 +++---
 t/t9811-git-p4-label-import.sh |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
1.7.10.282.g2120.dirty
