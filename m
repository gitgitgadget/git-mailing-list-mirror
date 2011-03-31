From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Remove old binaries from .gitignore
Date: Wed, 30 Mar 2011 21:26:01 -0500
Message-ID: <1301538361-15541-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 04:26:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q57aS-0000l3-Jn
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 04:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab1CaC0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 22:26:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42105 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755Ab1CaC0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 22:26:05 -0400
Received: by yxs7 with SMTP id 7so802348yxs.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 19:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=IcM3YrboE7n65O2soQCcycetYA0bmKFGR/FnA/vbxCY=;
        b=VKv7Ht1x5tV0wSjp0Tb6X74pkKQs3xA6ESoUYLV/rCgGgo8caIRA+3vjvUc9G87Bmu
         Ox8+NucOlQCXOd0IE4r88orMrSvPHKdvEkxCQS2upoPIcHBE2V5mi/4CNnZnaFMv9xkB
         2lKyqmoyUXgN7gl7HHhXgneQt1WPwwWZEorsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UvYGBuf8/4AZZti1Kx/FuVuHGinYhR73uQxGeb6+/5MWjqgdMieA5hgqKfsv3Fw0gU
         pMHvmh5afaSr/XnTJDy0yJo/KvqVx/e3IDY4rjIYc6hHPlJaB0IOw37okUhNutn1zrxf
         3uEIcgomPUfLajzWJprWh0ol94yxPPtneC+lc=
Received: by 10.91.67.1 with SMTP id u1mr1562621agk.191.1301538364926;
        Wed, 30 Mar 2011 19:26:04 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id e24sm704599ana.2.2011.03.30.19.26.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 19:26:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170450>

These two programs were dumped a while ago.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 .gitignore |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index c460c66..2cf3ca5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -43,7 +43,6 @@
 /git-fast-export
 /git-fast-import
 /git-fetch
-/git-fetch--tool
 /git-fetch-pack
 /git-filter-branch
 /git-fmt-merge-msg
@@ -107,7 +106,6 @@
 /git-reflog
 /git-relink
 /git-remote
-/git-remote-curl
 /git-remote-http
 /git-remote-https
 /git-remote-ftp
-- 
1.7.4.2
