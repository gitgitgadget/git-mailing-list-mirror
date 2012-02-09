From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCHv1 0/2] git-p4: possible RCS keyword fixes
Date: Thu,  9 Feb 2012 11:03:27 +0000
Message-ID: <1328785409-30936-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 12:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvRmo-0004rO-Pv
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 12:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab2BILD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 06:03:29 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53160 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2BILD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 06:03:28 -0500
Received: by wics10 with SMTP id s10so1114565wic.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 03:03:27 -0800 (PST)
Received: by 10.181.11.231 with SMTP id el7mr37337924wid.0.1328785407527;
        Thu, 09 Feb 2012 03:03:27 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id er8sm4432794wib.9.2012.02.09.03.03.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 03:03:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.128.gfce41.dirty
X-Gm-Message-State: ALoCoQlklAd0bb1Rb1kFX0KBgR7DoP9iu3WK4bRc4ecwdxxTlMfk4yiYhQN04xPARc1MgZBtCqPt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190285>

This contains a possible way to fixup RCS keyword woes in git-p4.

The first patch adds a test case to demonstrate the problem. It would
be useful to get this into git proper.

The second patch shows a possible way to solve the problem, by
patching up the RCS keywords in the p4 checked-out tree. This
patch does not cover all cases and is poorly tested. I'd like to
see if this seems like a plausible approach.

Luke Diamand (2):
  git-p4: add test case for RCS keywords
  git-p4: initial demonstration of possible RCS keyword fixup

 contrib/fast-import/git-p4 |   43 ++++++++++++++++++++++-
 t/t9810-git-p4-rcs.sh      |   82 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

-- 
1.7.9.rc2.128.gfce41.dirty
