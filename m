From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 0/3] git-p4: Search for parent commit on branch creation
Date: Wed, 25 Jan 2012 23:48:21 +0000
Message-ID: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 00:48:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqCa7-0002NW-MH
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 00:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab2AYXsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 18:48:42 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40436 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2AYXsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 18:48:41 -0500
Received: by wics10 with SMTP id s10so4225293wic.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 15:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6/G8xoS6XiDAFHhx0rxvlv/Wy0c5YQc0SiNndYo9GbI=;
        b=bqT1rOwe+kkaxkXYOR2sLSXX8kk0ldIrI7R4WmEoSOYWPqrpEBNF2zUxQdUj7EUxSE
         5WYkKHQ2Pz/Ow5PRbwxzxWw6jhgYlN0zOiL+DLfsyNDgZ5uX82d+O9yAK1IIaLckHpqu
         Z48PedI51OOQNdugAL2nlp72yj84ImFogvBgw=
Received: by 10.180.24.105 with SMTP id t9mr31553568wif.19.1327535320590;
        Wed, 25 Jan 2012 15:48:40 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id df2sm2551041wib.4.2012.01.25.15.48.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 15:48:39 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189134>

I think this will, hopefully, be the final version of this series of
patches. This version includes the following changes since v2:

 - Move search algorithm into its own function.
 - Use lists instead of strings on shell commands.
 - Some small (almost cosmetic) updates to test cases.

Pete Wyckoff (1):
  git-p4: Change p4 command invocation

Vitor Antunes (2):
  git-p4: Search for parent commit on branch creation
  git-p4: Add test case for complex branch import

 contrib/fast-import/git-p4 |   48 +++++++++++++++++++++-
 t/t9801-git-p4-branch.sh   |   94 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 133 insertions(+), 9 deletions(-)

-- 
1.7.8.3
