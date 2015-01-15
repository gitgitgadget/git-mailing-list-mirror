From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] stash: added short option '-p' to git stash usage synopsis
Date: Thu, 15 Jan 2015 23:41:34 +0600
Message-ID: <1421343694-3905-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:41:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoQb-0003Uf-LX
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbbAORlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 12:41:49 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60898 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbAORls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:41:48 -0500
Received: by mail-lb0-f174.google.com with SMTP id 10so14533995lbg.5
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mFdhQSUsKKxCr2qiAf4wkC/4K4WR29sc8B6kJPmZyP0=;
        b=o706Ck5kXfhcaSOaPo3s11R7DBb5A1lP7YaNcw46ASZv6vetKVvNURmfNPKK+e7dpH
         vb/UWDiAlbmX/n9u180E3NUo0yKprf/YAfVw4EHt94hKlMwNK4Fy6r7lxr63Llhz6YB+
         tImx5zKgNjCdwFfcG1JluE3n/MAOX+2DTrpjvICXmvVYTEjKju6XGcmCyA6pHT3TucGo
         I3H/Csg8jfSBqoH2KvE9a1jbkvfxk2jbpvnF3KJiFxmGfjUNI6aAH59oGEhkYD6+Zo7u
         kzp/RQs3jroDu3yig2HQCoXRdBVRZoxh9fXu46MDBJ5yG17n4hxMKsI2a06/owrigJyj
         WrKA==
X-Received: by 10.112.55.199 with SMTP id u7mr10955282lbp.74.1421343706035;
        Thu, 15 Jan 2015 09:41:46 -0800 (PST)
Received: from localhost.localdomain ([95.59.93.191])
        by mx.google.com with ESMTPSA id az15sm787857lab.30.2015.01.15.09.41.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jan 2015 09:41:45 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.315.g0e14eda
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262490>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 6e30380..dc101f9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+   or: $dashless [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
    or: $dashless clear
    or: $dashless create [<message>]
-- 
2.3.0.rc0.315.g0e14eda
