From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 1/3] MSVC: Remove vcbuild/include/sys/poll.h
Date: Fri, 18 Nov 2011 17:44:28 +0100
Message-ID: <1321634670-4968-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, kusmabite@gmail.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 17:45:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRRZR-0006Tu-Hk
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 17:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab1KRQpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 11:45:35 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61269 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab1KRQpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 11:45:32 -0500
Received: by eye27 with SMTP id 27so3544688eye.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 08:45:30 -0800 (PST)
Received: by 10.213.31.147 with SMTP id y19mr1023228ebc.137.1321634730534;
        Fri, 18 Nov 2011 08:45:30 -0800 (PST)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id z58sm4088253eea.3.2011.11.18.08.45.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 08:45:29 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185666>

In v1.7.7.1-432-g0f77dea (Oct 24 2011; Erik Faye-Lund; mingw: move
poll out of sys-folder) poll.h was moved out of the compat/win32/sys
folder. As the change in the Makefile also affects the MSVC build,
this file was no longer used.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/vcbuild/include/sys/poll.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 compat/vcbuild/include/sys/poll.h

diff --git a/compat/vcbuild/include/sys/poll.h b/compat/vcbuild/include/sys/poll.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/poll.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
-- 
1.7.4.1
