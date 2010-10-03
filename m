From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 5/6] put die() messages to stderr
Date: Sun,  3 Oct 2010 23:25:56 +0200
Message-ID: <1286141157-30422-5-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
 <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2W4s-0003XG-Dm
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab0JCV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:26:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41867 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab0JCV0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:26:12 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3198195bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=3EN4I8MC0kbJ32QBZq2cUZ/4A+gTZZgzSlfArqr3tFY=;
        b=Jae5Gh1rwyltOWk3sYyOl59NOxo2xPYyP0M6fR2klsBtgfBFWUOgfrF5/X1lhJZC8e
         wg+DqMX+mcDNCZ+cb4cA0mqo3VMTJ5oUv5npTaJVjuYyOHjJ8rhaKs/dSab5ZgPdhrCU
         ywdb7CNIfwDUBGLStb0TeEg1OgCmS4cUY5B/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CKmYUDRzqHEJrkVTlqcsU7LXzTF3IRe452+bsQ+4/m8J2go8j/+EeHcBwRiGevcOCQ
         C1yWMN0lDHWPZ7blhKEFYbHtMmpbvie+/q2rlS1T4fXhorhDrXV5sNzZI675/IsE6kIA
         CcDZh5LhhxaLGO4EDlfCA7O/IpkG1N5Q691Yc=
Received: by 10.204.141.16 with SMTP id k16mr6186688bku.177.1286141171325;
        Sun, 03 Oct 2010 14:26:11 -0700 (PDT)
Received: from localhost (p5B0F7E04.dip.t-dialin.net [91.15.126.4])
        by mx.google.com with ESMTPS id x19sm3041381bkv.21.2010.10.03.14.26.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:26:09 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157932>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index 9d08d63..3925f49 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -14,7 +14,7 @@ info()
 
 die()
 {
-	info "fatal: $*"
+	info "fatal: $*" >&2
 	exit 1
 }
 
-- 
tg: (9404aa1..) bw/die-to-stderr (depends on: master)
