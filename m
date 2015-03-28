From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/2] git-p4: Improve client path detection
Date: Sat, 28 Mar 2015 12:28:48 +0000
Message-ID: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 13:29:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybpru-0004Yl-In
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 13:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbbC1M3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 08:29:33 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36173 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbC1M3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 08:29:32 -0400
Received: by wgra20 with SMTP id a20so124732281wgr.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ai5RW8CPh13f2s0CGXL4CTYeIIZdTbvYKZD6vb/Hfr8=;
        b=depB7WZF776hqVryAiIT1Bsj3BdzM4qHMheecPk+u/kQ3qsDCqSeM25x9Z9x8V0mkh
         XUee6mfaiW3eJv4I7VXInzhCIbdUjuOUUxAN9efQUB0o8yc1/ihx5SsnAFNtWNXUyYKR
         aDlj3Pa7X3z39j9spgtGjv/DoErZ/STSkHop8ax/gslHccyHFdTWL5oc4hupJMbxDOf7
         1oKWLE+HKLk33HSPMWpyVH05b4wses3Pvak2FAT9opQXY8JwKB85X7LA1mOunRVWzdQj
         ir2daIkYGQwLRSN2mMz5jf4iAl6m92cCq3JZmqqYnDnE2mlaBFhIXOvuClFFoQTyhSSG
         1/Wg==
X-Received: by 10.180.228.36 with SMTP id sf4mr5030973wic.19.1427545771607;
        Sat, 28 Mar 2015 05:29:31 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id e2sm6948133wjy.46.2015.03.28.05.29.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2015 05:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266414>

I'm adding a test case for a scenario I was confronted with when using branch
detection and a client view specification. It is possible that the implemented
fix may not cover all possible scenarios, but there is no regression in the
available tests.

Vitor Antunes (2):
  git-p4: Check branch detection and client view together
  git-p4: Improve client path detection when branches are used

 git-p4.py                |   11 ++++--
 t/t9801-git-p4-branch.sh |   98 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 4 deletions(-)

-- 
1.7.10.4
