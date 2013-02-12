From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 20:17:47 +0000
Message-ID: <cover.1360700102.git.john@keeping.me.uk>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 21:24:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MPF-0000Ma-A7
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab3BLUYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:24:20 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:47151 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3BLUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:24:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E8479161E388;
	Tue, 12 Feb 2013 20:18:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yaUON-Kknhln; Tue, 12 Feb 2013 20:18:10 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CAF1C161E3CF;
	Tue, 12 Feb 2013 20:18:03 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216189>

When using the top-level install-doc target the html, info and man
target directories are inherited from the top-level Makefile by the
documentation Makefile as relative paths, which is not expected and
results in the files being installed in an unexpected location.

The first two patches are simple style fixes.  The third one fixes the
issue described above.

John Keeping (3):
  Documentation/Makefile: fix spaces around assignments
  Documentation/Makefile: move infodir to be with other '*dir's
  Documentation/Makefile: fix inherited {html,info,man}dir

 Documentation/Makefile | 88 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 32 deletions(-)

-- 
1.8.1.2
