From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 0/4] Emacs: git-blame.el fixes and enhancements
Date: Tue,  2 Jul 2013 19:34:33 +0200
Message-ID: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Lawrence Mitchell <wence@gmx.li>,
	=?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 19:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu4c2-0007wY-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab3GBRnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 13:43:17 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:55266 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069Ab3GBRnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:43:15 -0400
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 61A5E19F3640;
	Tue,  2 Jul 2013 19:36:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id HGwQMj49pt7E; Tue,  2 Jul 2013 19:35:57 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id DBE5D19F35D2;
	Tue,  2 Jul 2013 19:35:55 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.80)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Uu4Ud-0003VN-19; Tue, 02 Jul 2013 19:35:55 +0200
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229407>

Hi all,

following are a few fixes and enhancements to Emacs' git-blame-mode
(contrib/emacs/git-blame.el).

Michal Sojka (4):
  git-blame.el: Fix buffer local declaration
  git-blame.el: Make all line prefixes to have the same length
  git-blame.el: Allow displaying author/commit times
  git-blame.el: Change the default prefix format

 contrib/emacs/git-blame.el | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

-- 
1.8.3.1
