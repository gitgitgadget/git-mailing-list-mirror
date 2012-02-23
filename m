From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv5] git-p4: RCS keyword handling
Date: Thu, 23 Feb 2012 07:51:29 +0000
Message-ID: <1329983490-4033-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 08:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0TST-0008He-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 08:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab2BWHvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 02:51:16 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:52742 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab2BWHvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 02:51:16 -0500
Received: by werb13 with SMTP id b13so539261wer.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 23:51:15 -0800 (PST)
Received-SPF: pass (google.com: domain of luke@diamand.org designates 10.180.101.165 as permitted sender) client-ip=10.180.101.165;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of luke@diamand.org designates 10.180.101.165 as permitted sender) smtp.mail=luke@diamand.org
Received: from mr.google.com ([10.180.101.165])
        by 10.180.101.165 with SMTP id fh5mr701494wib.10.1329983475156 (num_hops = 1);
        Wed, 22 Feb 2012 23:51:15 -0800 (PST)
Received: by 10.180.101.165 with SMTP id fh5mr568619wib.10.1329983475000;
        Wed, 22 Feb 2012 23:51:15 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ga1sm2947688wib.5.2012.02.22.23.51.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 23:51:13 -0800 (PST)
X-Mailer: git-send-email 1.7.9.259.ga92e
X-Gm-Message-State: ALoCoQlCfm4aaXdmQXvTSOYxo3QDq1gGPJZ4y+6AV7lFupTQ34i54d70oZrPkxfdoXEpTbLgiCYb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191332>

Updated RCS keyword fix for git-p4, incorporating fixes to test cases
missed earlier.

Luke Diamand (1):
  git-p4: add initial support for RCS keywords

 Documentation/git-p4.txt   |    5 +
 contrib/fast-import/git-p4 |  118 ++++++++++++--
 t/t9810-git-p4-rcs.sh      |  388 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+), 10 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

-- 
1.7.9.259.ga92e
