From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCHv2 0/2] git-p4: possible RCS keyword fixes
Date: Thu,  9 Feb 2012 23:17:20 +0000
Message-ID: <1328829442-12550-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdF2-0003ko-6H
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429Ab2BIXRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 18:17:23 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33026 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab2BIXRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:17:23 -0500
Received: by wics10 with SMTP id s10so1618287wic.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 15:17:22 -0800 (PST)
Received: by 10.180.106.33 with SMTP id gr1mr5726800wib.6.1328829442103;
        Thu, 09 Feb 2012 15:17:22 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id q7sm9809903wix.5.2012.02.09.15.17.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 15:17:21 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.128.gfce41.dirty
X-Gm-Message-State: ALoCoQn1PUX/+Qs/Ha2XjMrakv8Xi1XzOkBFhVfxnU2YdSRyNwOQXZcWaI3eTltDMqv0MplIQ0Yg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190337>

Re-rolled with elementary shell coding errors fixed as per comments
from Junio - thanks!

I said before I wouldn't try to fix this, but maybe it could be
made to work after all. If nothing else, the failing test
case would be useful.

Luke Diamand (2):
  git-p4: add test case for RCS keywords
  git-p4: initial demonstration of possible RCS keyword fixup

 contrib/fast-import/git-p4 |   43 ++++++++++++++++++++++-
 t/t9810-git-p4-rcs.sh      |   81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 2 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

-- 
1.7.9.rc2.128.gfce41.dirty
