From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 0/2] gitk: save only changed configuration on exit
Date: Mon, 10 Nov 2014 00:20:00 +0200
Message-ID: <1415571602-5858-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:21:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnar4-00065z-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 23:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbaKIWVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 17:21:01 -0500
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:36143
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751413AbaKIWVA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 17:21:00 -0500
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id DaLs1p0095B68XE01aLy9S; Sun, 09 Nov 2014 15:21:00 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 did not actually work for views.

Fix it (add global) and also set viewchanged in delview

Max Kirillov (2):
  gitk: write only changed configuration variables
  gitk: synchronize config write

 gitk | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 13 deletions(-)

-- 
2.0.1.1697.g73c6810
