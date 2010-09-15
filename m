From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] git-ls-files.txt: clarify -x/--exclude option
Date: Wed, 15 Sep 2010 19:56:48 -0400
Message-ID: <1284595008-36464-1-git-send-email-jaysoffian@gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 01:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1qX-00078v-Sf
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab0IOX45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:56:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58029 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0IOX44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 19:56:56 -0400
Received: by ywh1 with SMTP id 1so237963ywh.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tVXqzvuzilJDB+jbO0OvHI7oUyDu05cZL/sMcYkACTs=;
        b=N+zkTYX6eggaE2R+X+oTRMSQPJbVI0s5tG0UdkyCo8VmUGjxfY6Gj/6emZjiaa+hs/
         FTTiej0ABuRNCtxwyggz8oZPgKM/LD2oRCadQWMUxW0bdJKBWMbF+FKhSIHM3m35eG0V
         jxzlHcgqGApL+X2Jhb6gZzNaSALpTpDP4kvXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LSUftEkf/6hi18pho3OvR2TBVTGbTY/QPlNHkRZ0FirCHj02jL48HsPoYdqYs5fucX
         j08RZHWgwA73YJMitpvwadlxi9nJInXnEmDBgrpLm0sv38nyhb/HM9gH1sQ5H47Ts4+C
         0YSgqivWCJbZ3vsE7/DryTMWSogbYePXkmlS4=
Received: by 10.151.112.18 with SMTP id p18mr2663864ybm.339.1284595015525;
        Wed, 15 Sep 2010 16:56:55 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id c2sm6729723ybi.21.2010.09.15.16.56.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 16:56:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.5.g95127
In-Reply-To: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156279>

Since b5227d8, -x/--exclude does not apply to cached files.
This is easy to miss unless you read the discussion in the
EXCLUDE PATTERNS section. Clarify that the option applies
to untracked files and direct the reader to EXCLUDE PATTERNS.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-ls-files.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Well, at least we can clarify the man page to reduce likelihood
of future confusion.

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 15aee2f..f52b06a 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -79,8 +79,9 @@ OPTIONS
 
 -x <pattern>::
 --exclude=<pattern>::
-	Skips files matching pattern.
-	Note that pattern is a shell wildcard pattern.
+	Skips untracked files matching pattern.
+	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
+	below for more information.
 
 -X <file>::
 --exclude-from=<file>::
-- 
1.7.3.rc1.5.g95127
