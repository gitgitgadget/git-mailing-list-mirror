From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] some test fixes for msysGit
Date: Thu,  3 Feb 2011 15:31:41 +0000
Message-ID: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 16:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl1AQ-0005sD-OP
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 16:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab1BCPcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 10:32:11 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:40464 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751880Ab1BCPcK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 10:32:10 -0500
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pl1AG-0005MC-EK; Thu, 03 Feb 2011 15:32:08 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <pat@patthoyts.tk>)
	id 1Pl1A7-0005zf-1s; Thu, 03 Feb 2011 15:31:59 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 56C1323190; Thu,  3 Feb 2011 15:31:58 +0000 (GMT)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165975>

The following patches resolve some issues for msysGit running the v1.7.4 tests

 t/t3509-cherry-pick-merge-df.sh |    6 ++++--
 t/t4120-apply-popt.sh           |    9 +++++++--
 t/t5526-fetch-submodules.sh     |   32 ++++++++++++++++++--------------
 t/t7407-submodule-foreach.sh    |    4 ++++
 4 files changed, 33 insertions(+), 18 deletions(-)
