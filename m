From: Ehsan Akhgari <ehsan@mozilla.com>
Subject: [PATCH] INSTALL: Add docs on how to use custom Python paths.
Date: Mon, 31 Aug 2015 09:22:38 -0400
Message-ID: <1441027358-27245-1-git-send-email-ehsan@mozilla.com>
Cc: Ehsan Akhgari <ehsan@mozilla.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 15:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWP4F-0003Hv-91
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 15:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbHaNYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 09:24:07 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34346 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbHaNYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 09:24:05 -0400
Received: by ioeu67 with SMTP id u67so15268535ioe.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=DakF38K9b3cvKE+EnQLYn363CFs3gNMdJv2KS3+9DIo=;
        b=SbyF6uhdhs3y5N9BXBp6gZyNw4cu5gaBwiICIrwMuBpz861c/1sPc4vDl68D9F6Cj7
         VqyOrwHkS9vASKmsMP3QufwfuZuurfC4+FFw3ldebjVh12ixL1MiJ/2Asa/1Ck0exs4K
         8tLhHGf/BhFBEPtfRAjbRoOg4jNnbGjQwVbadS5bnCndIfc0NgvTYKPcXcWw9txrj1Zw
         PekM+VYHyR/WJiumuZG5wnZ5V4S4p4k2Q3BXPBTVHZBTEOPY3VolPiIM08MuF5kNMCLO
         t5gaJfsvhcPEq0dpRCxoIXSNbPTf1sLD71rl+qTI/aG1iZlcXPWeiBWHMyhET1COXJ/0
         gz3g==
X-Received: by 10.107.148.10 with SMTP id w10mr10633716iod.74.1441027444492;
        Mon, 31 Aug 2015 06:24:04 -0700 (PDT)
Received: from localhost.localdomain (ip-162-250-172-168.fibre.fibrestream.ca. [162.250.172.168])
        by smtp.gmail.com with ESMTPSA id v3sm10727254igb.3.2015.08.31.06.24.03
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 06:24:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276876>

Signed-off-by: Ehsan Akhgari <ehsan@mozilla.com>
---
 INSTALL | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/INSTALL b/INSTALL
index ffb071e..5b7fe91 100644
--- a/INSTALL
+++ b/INSTALL
@@ -148,6 +148,11 @@ Issues of note:
 	  supported by Perforce) is needed to use the git-p4 interface
 	  to Perforce.
 
+	  By default, git looks for Python installed in /usr/bin/python.
+	  On systems with a different Python installation path, pass the
+	  --with-python argument to configure, or set the PYTHON_PATH
+	  environment variable when using make to build.
+
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
-- 
2.4.0
