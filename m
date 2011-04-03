From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] Documentation: Allow custom diff tools to be specified in 'diff.tool'
Date: Sun,  3 Apr 2011 19:55:22 +0530
Message-ID: <1301840722-24344-4-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1301840722-24344-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Helped-by: Michael J Gruber" <git@drmicha.warpmail.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 16:26:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6OGV-0002ct-3S
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 16:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab1DCO0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 10:26:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1DCO0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 10:26:46 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so5118848iyb.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JhMvUSTmFc9tGUklf4m7GSFt1XKgx3zXzZC+Z8d7pqA=;
        b=eu2+rzdWFZ1lwD/7wiunkJcpbB40+6TucfgEU/DbEKcdmjmNTjGBxTib9X7zsK2Djd
         bQPeIhuriHRCJpXqwgKehq3Br9xxW1xBVE4OrPArFBIzWTi1TQFV/JrWl/oa0z5FPDAc
         Gtr5GOxMRZLH/IOfKpEw0aUyPgty5kSAMfgqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S1grztTjp/pR3C+xF3aO9bsa9P0rVc/Fu3NsuDUS7ah4ag2ZkT2PnIEiQxIbARd37f
         v6OKrYnR9F6Uj2yMPdmbbIQQ6WVANURvM0Rvvx/tOyCNdlJXqmXiqgHEmf9b0ys7dNqS
         EzxbHpBjGfmbzncgxZTRkzj+a5uMH6wihZIXQ=
Received: by 10.231.185.105 with SMTP id cn41mr6334361ibb.72.1301840805890;
        Sun, 03 Apr 2011 07:26:45 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i3sm3011074iby.40.2011.04.03.07.26.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 07:26:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301840722-24344-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170695>

Apart from the list of "valid values", 'diff.tool' can take any value,
provided there is a corresponding 'difftool.<tool>.cmd' option.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 8c1732f..7f985a3 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -59,7 +59,9 @@ diff.tool::
 	Controls which diff tool is used.  `diff.tool` overrides
 	`merge.tool` when used by linkgit:git-difftool[1] and has
 	the same valid values as `merge.tool` minus "tortoisemerge"
-	and plus "kompare".
+	and plus "kompare".  Any other value is treated is custom
+	diff tool and there must be a corresponding
+	'difftool.<tool>.cmd' option.
 
 diff.<driver>.command::
 	Defines the command that implements the custom diff driver.
-- 
1.7.4.rc1.7.g2cf08.dirty
