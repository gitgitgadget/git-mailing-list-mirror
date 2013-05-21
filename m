From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-hg: fix order of configuration comments
Date: Mon, 20 May 2013 22:47:53 -0500
Message-ID: <1369108073-29275-3-git-send-email-felipe.contreras@gmail.com>
References: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 05:49:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueda2-0000nP-6n
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 05:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab3EUDth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 23:49:37 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:55305 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3EUDtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 23:49:35 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so205143oag.25
        for <git@vger.kernel.org>; Mon, 20 May 2013 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ECXhEUMBYNEgPQ36qwtsGJy6U5vxDnYEYa+Sb4lxpoY=;
        b=W+r4h9/Q3T0HC7L1BYz+ZxrOZdJLJvyhvs8GfWbGgLF6YmXHNgCIA43KYx/xvwoxMf
         u9MnnnPBdPgheaHZyJ3dBLjKDjm5MSq/Nh5C7wmW83OenU3SDbt/hxdC8R/NCLBCIrNb
         5eJIQ/vjKDfsERl6zG8Gv8UnOW/DNVyg6IiwqKLeWSmOEclMoLZHxZMysEh3bFlZtTmX
         4V9O6OYK0DcXA3UWKO9OkdjDxCpw7wHJaCcAa6uWwdPX0q0q1TdiFovFB9Pq+91DQzHk
         Coh2JhB/+hpHiDDPLYi28M743v72sJ8xdlEpxU0M5tNi7qcXKQr74nVVS7FRMGLCwS78
         TPgA==
X-Received: by 10.182.128.106 with SMTP id nn10mr264404obb.72.1369108175347;
        Mon, 20 May 2013 20:49:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm969701oeb.3.2013.05.20.20.49.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 20:49:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.1.gf11a2b7.dirty
In-Reply-To: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225016>

The other configurations were added in the wrong place.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 88db7c4..198b962 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -25,9 +25,6 @@ import atexit
 import urlparse, hashlib
 
 #
-# If you want to switch to hg-git compatibility mode:
-# git config --global remote-hg.hg-git-compat true
-#
 # If you are not in hg-git-compat mode and want to disable the tracking of
 # named branches:
 # git config --global remote-hg.track-branches false
@@ -38,6 +35,9 @@ import urlparse, hashlib
 # If you want the equivalent of hg's clone/pull--insecure option:
 # git config --global remote-hg.insecure true
 #
+# If you want to switch to hg-git compatibility mode:
+# git config --global remote-hg.hg-git-compat true
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
-- 
1.8.3.rc3.1.gf11a2b7.dirty
