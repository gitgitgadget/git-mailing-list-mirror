From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Early HEAD resolution in push.default = current
Date: Thu, 30 May 2013 00:51:48 +0530
Message-ID: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 21:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhly2-0002Ay-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966257Ab3E2TXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:23:22 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37667 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965810Ab3E2TXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:23:19 -0400
Received: by mail-pb0-f52.google.com with SMTP id um15so9625049pbc.39
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OPuJePhcgrdLZzCOFKQ+bk5Fll8Mbp/xjchvm3TZnKc=;
        b=ZPSGhqFIJNycT+OFd+o3NwHp793VMWOS94mmxHJBlHNkWSa8iPLxgxisB5+rOzO8QE
         Qsuu9fIxERp4xC9DwXObl84lMpgbPO4Fm7fWpNTSsRFCnF06PE7NWT5qtFNVzrQxBCbE
         cArdP2I+yRJ+sTHHL5BzIeID/moYr6R4lCfKqkjyCCqQuSHQxDRtlQYgasiFcaFVLh7U
         roic3YjCj146svgCdhECIM/JmgoW+ggVA8/rTb8otr9oVARxtsV3TY7y6bvYW/xQWvvt
         sTV13mSKk8muepZGx+gMFeHzUcDOqkvGwYQgMMCUDIizk+TVm1f3SbYIO3MASW1Apf/q
         tosw==
X-Received: by 10.66.191.40 with SMTP id gv8mr5073197pac.19.1369855398797;
        Wed, 29 May 2013 12:23:18 -0700 (PDT)
Received: from localhost.localdomain ([122.164.41.150])
        by mx.google.com with ESMTPSA id xu10sm41059620pab.3.2013.05.29.12.23.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 12:23:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.12.gbd56588
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225869>

The commit message in [3/3] is rewritten although I've mentioned the
original motivation at the end.

No other changes.

Ramkumar Ramachandra (3):
  push: factor out the detached HEAD error message
  push: fail early with detached HEAD and current
  push: make push.default = current resolve HEAD early

 builtin/push.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
1.8.3.12.gbd56588
