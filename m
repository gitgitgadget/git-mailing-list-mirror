From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/2] git-p4: remove test bash-isms
Date: Sun, 26 Feb 2012 10:37:25 -0500
Message-ID: <1330270647-8817-1-git-send-email-pw@padd.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 16:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1gAk-0004sC-P2
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 16:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab2BZPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 10:37:31 -0500
Received: from honk.padd.com ([74.3.171.149]:34118 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab2BZPha (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 10:37:30 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id D727B24A6;
	Sun, 26 Feb 2012 07:37:29 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 835E5313D8; Sun, 26 Feb 2012 10:37:27 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.288.g74b75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191564>

Two fixes to make the t98* tests run in dash.

Pete Wyckoff (2):
  git-p4: remove bash-ism in t9809
  git-p4: remove bash-ism in t9800

 t/t9800-git-p4-basic.sh       |   25 ++++++++++++++++---------
 t/t9809-git-p4-client-view.sh |    2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.7.9.2.288.g74b75
