From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3] git-p4: RCS keyword handling
Date: Tue, 14 Feb 2012 22:33:54 +0000
Message-ID: <1329258835-17223-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 23:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQwg-0001Vg-1d
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597Ab2BNWdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:33:53 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63523 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab2BNWdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:33:53 -0500
Received: by wics10 with SMTP id s10so147557wic.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:33:52 -0800 (PST)
Received: by 10.180.96.8 with SMTP id do8mr4772004wib.21.1329258832044;
        Tue, 14 Feb 2012 14:33:52 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ec3sm29765151wib.1.2012.02.14.14.33.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 14:33:51 -0800 (PST)
X-Mailer: git-send-email 1.7.9.259.ga92e
X-Gm-Message-State: ALoCoQl2B1X/1d+kXW1TM0IjM6AUBMw+DLbXE6g4t3IUnqNVhFM6C2gLqM13+WzPtXEZtWnkHGo/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190781>

Updated patch to handle RCS keyword expansion performed by perforce
in git-p4. This incorporates Pete Wyckoff's suggestions and test
cases, and also adds a test for handling deletion of a file containing
RCS keywords.

Eric - could I ask you to take a look at this and see if it
solves your particular problem.

Thanks.

Luke Diamand (1):
  git-p4: add initial support for RCS keywords

 Documentation/git-p4.txt   |    5 +
 contrib/fast-import/git-p4 |  116 +++++++++++++++--
 t/t9810-git-p4-rcs.sh      |  304 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+), 10 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

-- 
1.7.9.259.ga92e
