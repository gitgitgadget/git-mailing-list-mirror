From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 0/4] git-p4: Improve branch support
Date: Fri, 19 Aug 2011 00:44:02 +0100
Message-ID: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:44:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCGc-0006hI-5w
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab1HRXou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:44:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33240 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1HRXot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:44:49 -0400
Received: by wwf5 with SMTP id 5so2583952wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Idt5bjZZWr21EwFiOw1D8B2sDahcNDhyJv2c3KXiZlk=;
        b=TUNNSyeagdtXdyVs91HEUi9uucXJ91PBaWjcsQzFU0q6qrkVTrbqm7bJqpKjvqvbEn
         mZ9Earu/wIw4ze1fUFwotT9/HxuaeW4WW9P1GWqao88CFqMgkJHt66hXS6708NQjGTIp
         iznRbHDtEwWKdIWdbHGHzNi7B8bme5JZL/Xr4=
Received: by 10.216.8.85 with SMTP id 63mr1146971weq.29.1313711088319;
        Thu, 18 Aug 2011 16:44:48 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u22sm1816046weq.15.2011.08.18.16.44.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179658>

Add missing test case from last version of this set of patches.

Vitor Antunes (4):
  git-p4: Correct branch base depot path detection
  git-p4: Allow filtering Perforce branches by user
  git-p4: Allow branch definition with git config
  git-p4: Add simple test case for branch import

 contrib/fast-import/git-p4     |   40 ++++++++++++++++++++++--
 contrib/fast-import/git-p4.txt |   13 ++++++++
 t/t9800-git-p4.sh              |   64 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 4 deletions(-)

-- 
1.7.5.4
