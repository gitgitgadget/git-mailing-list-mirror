From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/3] bisect: document that --no-checkout is the default for bare repositories
Date: Sun,  7 Aug 2011 20:50:40 +1000
Message-ID: <1312714240-23647-4-git-send-email-jon.seymour@gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 12:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq0wv-0006pu-Is
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 12:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab1HGKvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 06:51:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50269 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab1HGKvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 06:51:03 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6576739pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OaF8gE7upFJuMlE1/mE9AsK7DogZePijhb9IEAMmpAI=;
        b=cDJmje+HiJBn2yzeHKprBHXUayJAdnklavsaetcU57hMrbgfk1QYi/c7IJwf9YBJAC
         g8tWecE8BLb4vuH1KOt0LVxi3UPyBDroFwJOwgiTuZrU3k+B5jinp8miibgodWMloAHS
         B5V0LhF6rd8btdp+e5s2gfQjJ16s9ZejDk5qg=
Received: by 10.142.170.15 with SMTP id s15mr4616272wfe.168.1312714262989;
        Sun, 07 Aug 2011 03:51:02 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id m3sm2740179pbm.28.2011.08.07.03.50.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 03:51:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178901>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 41e6ca8..e4f46bc 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -273,6 +273,8 @@ it point to the commit that should be tested.
 +
 This option may be useful when the test you would perform in each step
 does not require a checked out tree.
++
+If the repository is bare, `--no-checkout` is assumed.
 
 EXAMPLES
 --------
-- 
1.7.6.363.g9b380.dirty
