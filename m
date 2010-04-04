From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] pack-protocol.txt: fix spelling
Date: Sun,  4 Apr 2010 19:42:32 +0800
Message-ID: <1270381352-2892-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 13:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyOED-0003eV-Ae
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 13:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0DDLmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 07:42:46 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62200 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0DDLmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 07:42:44 -0400
Received: by vws13 with SMTP id 13so1049604vws.19
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0JVEvETLUObuYYK5qjLXXOdqqLWAXJlLhxwYcnP156o=;
        b=J66cbmO77hMn5Wfq6Pa3+TmIilRqFBest8GbHk16BXwonCbMUQBaaf+vLwzKhUYIwO
         9DL+DF1e9BDNcHBI6dlE/LPMh+jPb6IdtVx3CWS9sQ0flzwx6FQmu996a5axp019WLUz
         BX+okp8ZjJR5+vvVtqhmae7kyE5F7n/FLxWBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z+ouUy78uSA+bw50BHE51KsNfEdoIQGe9iW3Hc7ohreAsR5CPvsAExYSSA5372a3F2
         fq4nH6YuuRc29/lAMYSoaX1Iwx3d8sLorqIRwXZFOlmtvT/UXjvhcYwu+T6Wk1HJyHBi
         bcROXNogZXRWJtnnhQH42EQxXZaW8Q7l9ocLY=
Received: by 10.220.63.74 with SMTP id a10mr1973971vci.116.1270381363246;
        Sun, 04 Apr 2010 04:42:43 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 22sm3074444vws.3.2010.04.04.04.42.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Apr 2010 04:42:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143918>

s/paramater/parameter/.
---

Spotted this while perusing protocol doc.

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
