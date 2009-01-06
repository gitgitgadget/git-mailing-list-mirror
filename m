From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (topgit) 0/2] tg-patch: fix pagination
Date: Tue,  6 Jan 2009 18:16:37 +0300
Message-ID: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 16:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDfq-0006PP-1K
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZAFPP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbZAFPPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:15:25 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1369 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbZAFPPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:15:25 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 8CF9817B65D; Tue,  6 Jan 2009 18:15:23 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKDfb-0003w7-Fs; Tue, 06 Jan 2009 18:16:39 +0300
X-Mailer: git-send-email 1.6.1.48.ge9b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104691>

Kirill Smelkov (2):
  Implement setup_pager just like in git
  tg-patch: fix pagination

 tg-patch.sh |    3 +++
 tg.sh       |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)
