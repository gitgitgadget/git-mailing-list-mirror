From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/2] pack-protocol.txt: fix spelling
Date: Sun,  4 Apr 2010 21:12:16 +0800
Message-ID: <1270386737-1424-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 15:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyPcw-0004Nm-5g
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab0DDNM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:12:29 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:61292 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0DDNM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 09:12:28 -0400
Received: by qyk9 with SMTP id 9so224129qyk.1
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Khmz+uRLSlQx4rR7ltXI2/rKj+aGM81NReLW9ib1cfM=;
        b=CLBqxgeRy+msksxU9YJJxi7CzrzHRohlU+7cMwvJw2vhjkIXpT4ugdx++qAvqWuu9z
         lO+k6F9kUFo1MoENhWBF9dQioi30sg53Asf13iFT4XzPcwMoy9UYoayopADXQuq5T6MU
         dCVLIzzYcwhnBJvyUeTayBNaGAi6Bfepy8K1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uaefhmzWTilG3TUOOYuoU4PGz1I4KJo16ntNNfAqwxkdgWy5ipDg/sMQA5fCtYtQMv
         /eY949Ds+kWQb7+IIFugC2pExdwbEenZdxTogVLyXusXDtBcmhSKT3aayt1BqCZDxTwA
         mXcRgLA5b3Ev37k2Px3LnSQY/rNXOBBDHzdn4=
Received: by 10.229.213.140 with SMTP id gw12mr7232867qcb.96.1270386747173;
        Sun, 04 Apr 2010 06:12:27 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id w30sm3582239qce.16.2010.04.04.06.12.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Apr 2010 06:12:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143923>

s/paramater/parameter/.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/pack-protocol.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 9a5cdaf..f9468a1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -36,7 +36,7 @@ Git Transport
 
 The Git transport starts off by sending the command and repository
 on the wire using the pkt-line format, followed by a NUL byte and a
-hostname paramater, terminated by a NUL byte.
+hostname parameter, terminated by a NUL byte.
 
    0032git-upload-pack /project.git\0host=myserver.com\0
 
-- 
1.7.0.20.gcb44ed
