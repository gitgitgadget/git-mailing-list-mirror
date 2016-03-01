From: larsxschneider@gmail.com
Subject: [PATCH v1] git-p4: fix AsciiDoc formatting
Date: Tue,  1 Mar 2016 12:05:20 +0100
Message-ID: <1456830320-40411-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 12:05:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aai7L-0008KU-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 12:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcCALFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 06:05:24 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33665 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcCALFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 06:05:23 -0500
Received: by mail-wm0-f46.google.com with SMTP id l68so30043425wml.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=j90qJmULsgYUbcCbi1n+FOQnQ3nRLI95OFHZDThCkPg=;
        b=j2BMqGS/GxkJi0Cfg2WcAjvj3wwKZypwuaWJI0zDYAaz8LkbuZS5CSYrMEgR/4o0Dp
         8V+0XJng1TKWoOSEEcNhe98J5SDWSTN3ohtQllcL4g1Oym+1lrkHvQFPq47aaoHXJsGf
         X+REMRn0+w/H4g2i3xWfrcj3HZY4fJCewbKwV4b8FcqsKpW5zzSoIAcPAW2mWXZPX+a7
         pmnG9tQPruSUbbeVYsH7eM/zo2dNS6ATSa/BcQ/Lr99pBk2M3gdCJfR8eKumT25NECNi
         4/ATo1H0UPgejqAXvca1PIbdYp86dfO9/meW8WnV4Pjp0hZR/3Z6TZ9vNIXRv9tTxmg6
         OP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j90qJmULsgYUbcCbi1n+FOQnQ3nRLI95OFHZDThCkPg=;
        b=hCv+4JHbr/BCZ1O4i1iYOEarjRfCYJPiqbv0+22EC+IzoFe9ZshNrQyjGeLEGYWDNQ
         p+GQDuQtK0XdTz5fuAOP90LmiK/a4L6kVdDs6tU7FmHS1vzE1sAG2/TdX41gSe6yecwU
         uyjNbTLGhz159FBq85fl8aDK2kEHEmEIAwXTjjnSd45Cb7aQTRokcNsjcSoLFUM2OE4Q
         m0wBy1xq5nyaGHjSvtBYkeWS5HDcqTUuoIn5y0QmOGrbIsaP5PVb2kzgvCRdSlHs1W2E
         AdDZeCyXs20lfmfEpxJE7BIAFZLUvlg1YycGKUc1CUYXfP3NT98OCg6jEVonTBALHZOZ
         E5Ug==
X-Gm-Message-State: AD7BkJL04rXRXtwR/N3tzc5Rw+aOJKBqYVHOd32rSg/H0cJQPPNHk7d8xPa42bAmEwozig==
X-Received: by 10.28.137.139 with SMTP id l133mr3301627wmd.1.1456830322329;
        Tue, 01 Mar 2016 03:05:22 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB539F.dip0.t-ipconnect.de. [93.219.83.159])
        by smtp.gmail.com with ESMTPSA id da6sm20863334wjb.24.2016.03.01.03.05.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 03:05:21 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288008>

From: Lars Schneider <larsxschneider@gmail.com>

Noticed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 738cfde..140fc12 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -528,7 +528,7 @@ git-p4.largeFileSystem::
 git config       git-p4.largeFileSystem GitLFS
 -------------
 +
-	[1] https://git-lfs.github.com/
+[1] https://git-lfs.github.com/

 git-p4.largeFileExtensions::
 	All files matching a file extension in the list will be processed
--
2.5.1
