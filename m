From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (girocco) 0/3] Fix svn mirroring of branches + more...
Date: Sat, 18 Sep 2010 13:58:51 +0400
Message-ID: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
X-From: git-owner@vger.kernel.org Sat Sep 18 11:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwuAn-0005f1-Vk
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab0IRJ5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 05:57:22 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:42931 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab0IRJ5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 05:57:18 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id C2C9AFF66F; Sat, 18 Sep 2010 13:57:16 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1OwuC9-0002c2-9w; Sat, 18 Sep 2010 13:58:57 +0400
X-Mailer: git-send-email 1.7.3.rc2.1.g63647
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156445>

Petr, rorcz-admins,

Today I've spot that rorcz does not propagate svn branches to git namespace and
tried to fix it.

Please apply and thanks,
Kirill

Kirill Smelkov (3):
  taskd/clone: Store git-svn refs under svn-origin remote
  taskd/clone: ask git-svn to store branches under svn-origin/heads/*
    instead of svn-origin/*
  Revert "Finalized fix, we can't git fetch any longer."

 jobd/update.sh |    1 +
 taskd/clone.sh |   12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
1.7.3.rc2.1.g63647
