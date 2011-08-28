From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v4 0/4] git-p4: Improve branch support
Date: Sun, 28 Aug 2011 22:58:26 +0100
Message-ID: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxnNf-0002rI-LA
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 23:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab1H1V6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 17:58:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49150 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab1H1V6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 17:58:49 -0400
Received: by wwf5 with SMTP id 5so5126411wwf.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8F5+neiTc0bfZFgg55QjRX4B1JfVBksBB7raMoi+Yog=;
        b=v+O6ufYzgeVef2wSmKpPd23Uf/vBnOs30YtegQ70OM98BLtkpE7sxKm7qyHd9IkEM6
         5VGZCznzuoM31oPoGXNjaA8rsVm0thcc7p26l92SAugDa4xRMgShcs4LGVGZxZCaoIbf
         4ePWHScU/KsaMU0WCyokhfnWa7GDzCaJ+8kzc=
Received: by 10.216.210.201 with SMTP id u51mr78970weo.43.1314568728269;
        Sun, 28 Aug 2011 14:58:48 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fh17sm3211909wbb.3.2011.08.28.14.58.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 14:58:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180283>

Include test case patches from Pete Wyckoff.

Vitor Antunes (4):
  git-p4: Correct branch base depot path detection
  git-p4: Allow filtering Perforce branches by user
  git-p4: Allow branch definition with git config
  git-p4: Add simple test case for branch import

 contrib/fast-import/git-p4     |   40 +++++++++++++++++++++++--
 contrib/fast-import/git-p4.txt |   13 ++++++++
 t/t9800-git-p4.sh              |   61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 4 deletions(-)

-- 
1.7.5.4
