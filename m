From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Documentation: mention conflict marker size argument (%L) for merge driver
Date: Tue, 23 Feb 2010 21:11:12 +0100
Message-ID: <1266955872-4795-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:11:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk16Q-0004dz-4H
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 21:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab0BWULZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 15:11:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:58829 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0BWULY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 15:11:24 -0500
Received: by fg-out-1718.google.com with SMTP id e21so922216fga.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 12:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=73TtO8wsxGd4pPkZDByJuI1jFUV1wxqEEttJBUCmB3E=;
        b=nbJ9sLekEXWM2O1Foj2Om972O/WSWi3SeW2IXAwete5BO3JcMkL9pY0+vKXiPHh3MB
         wSn/iu7oR2genLgjarmJ3s+/2g2lmtCCjmQIMNenzqL8wIkKaVYjSEvI/u9GUj0pVWhe
         u6ASW2Pi2gVaIT33Oz+kRNq5RpdzvZqprth8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WEdrP0bF5WJ8PHFqd2fpsD88A08tapeBfw5mgzOPpkdMyP1tMmk2p9x4iTzlaM+Ow3
         CBf7gi3Zs9N1MGxCZXmR/ow41elTTvZeq3mnC7HtrX5k1MBAwjlChAd+BUVb6dMv+x/F
         nEXjGvZwFQJUzDT6CgAyM9gzLz/CbOIoi5mws=
Received: by 10.87.55.31 with SMTP id h31mr433064fgk.32.1266955883173;
        Tue, 23 Feb 2010 12:11:23 -0800 (PST)
Received: from localhost (drsd-4dbd880b.pool.mediaWays.net [77.189.136.11])
        by mx.google.com with ESMTPS id e3sm701334fga.4.2010.02.23.12.11.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 12:11:22 -0800 (PST)
X-Mailer: git-send-email 1.7.0.500.ge51cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140828>

23a64c9e (conflict-marker-size: new attribute, 2010-01-16) introduced the
new attribute and also pass the conflict marker size as %L to merge driver
commands. This documents the substitution.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/gitattributes.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b396a87..d892e64 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -511,7 +511,8 @@ command to run to merge ancestor's version (`%O`), current
 version (`%A`) and the other branches' version (`%B`).  These
 three tokens are replaced with the names of temporary files that
 hold the contents of these versions when the command line is
-built.
+built. Additionally, %L will be replaced with the conflict marker
+size (see below).
 
 The merge driver is expected to leave the result of the merge in
 the file named with `%A` by overwriting it, and exit with zero
-- 
1.7.0.500.ge51cb
