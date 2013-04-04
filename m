From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/13] remote-hg: add missing config variable in doc
Date: Thu,  4 Apr 2013 09:30:11 -0600
Message-ID: <1365089422-8250-3-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm8z-0003uy-5W
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762502Ab3DDPb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:28 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39942 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762537Ab3DDPb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:26 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so2689565obb.13
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IRdlnoSYQjUg72E63/HMAOwHjomhZsyEAMNKdcOv1z0=;
        b=XQorlUwukDW8QFhLrUhGsEfl2/3QSHGeVH4IEbnPvpAuMvPnKJNHgrmxpSFNHTTUBc
         cFM/MZBeG08TrhNsvKhyoy56YPX46qtHs7hsyEZgtCSs2xG2hfmDSgRyNO/HgVmP+qBu
         yxXFX5DJ01CXhjB/Jha3U8zhxk/kgVu+SUKYY6jxwoQWaJ4noBuDZLiQ9HAsE1Bgwntd
         PAbfKKCV0FCaAZnk6X4MBfAv5Ord/BYv/UnKXvsr+n0Upw7E8msiC86PJI7HPjZ7JS5j
         JEKL3/KD/HVeA6B1jTV754f5ntWq92kVFXtoF7IOCzzM6QOBKFUlWHXGPZuS4zgL1a0s
         PkIA==
X-Received: by 10.182.112.202 with SMTP id is10mr4219575obb.8.1365089485513;
        Thu, 04 Apr 2013 08:31:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id j10sm6787170obg.4.2013.04.04.08.31.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220005>

From: Dusty Phillips <dusty@linux.ca>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d0dfb1e..844ec50 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -23,6 +23,10 @@ import urllib
 # If you want to switch to hg-git compatibility mode:
 # git config --global remote-hg.hg-git-compat true
 #
+# If you are not in hg-git-compat mode and want to disable the tracking of
+# named branches:
+# git config --global remote-hg.track-branches false
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
-- 
1.8.2
