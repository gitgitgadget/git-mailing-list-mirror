From: Astril Hayato <astrilhayato@gmail.com>
Subject: [PATCH v3] Documentation/gitk: Document new config file location
Date: Thu, 20 Mar 2014 13:33:49 +0000
Message-ID: <1395322429-1501-1-git-send-email-astrilhayato@gmail.com>
Cc: gitster@pobox.com, Astril Hayato <astrilhayato@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 14:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQd7G-00055h-3W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 14:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbaCTNed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 09:34:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61857 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaCTNec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 09:34:32 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi5so6234776wib.11
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nS5EJ06yignaFEFymafPZI4pgEmNb7Va+tBp8kSB4VQ=;
        b=wxYYj1qhZrfvmudBGN8z18gaINu682NLTtzPfENMEksYxmIV18go2+b5aaMujIbCH2
         snZ4HOjPKoWSZHNZ/j/P68xv6Vc09Hipf+CzFfTWTNuUpbi2uj/insdrTdFyJwQpUXJ1
         5Ohf6LM8GLDqd9GpSN1gsvBkw+eY1PhQXqYhSwQPyvyIXy2lPZohfemx//6iLLINxRGG
         wId/FfkugjQgA28AQvdTHITpEyHxhxALh7PIOLCn1eBTDZKVy6N31SXaC3ngD9/dShAt
         ZhoYMErjLugeCX30+DqRoKPudKggERjNvp6AqIi8qrGSJTkrWB2UftTCZ20ZMGHo9LpT
         Frsw==
X-Received: by 10.180.91.164 with SMTP id cf4mr3049754wib.37.1395322471042;
        Thu, 20 Mar 2014 06:34:31 -0700 (PDT)
Received: from localhost.localdomain (cpc4-blbn8-2-0-cust14.10-1.cable.virginm.net. [86.22.6.15])
        by mx.google.com with ESMTPSA id bm8sm5106775wjc.12.2014.03.20.06.34.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Mar 2014 06:34:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244548>

User config file location now complies with the XDG base directory specification

Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
---
 Documentation/gitk.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 1e9e38a..7e03fcc 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -166,8 +166,14 @@ gitk --max-count=100 --all \-- Makefile::
 
 Files
 -----
-Gitk creates the .gitk file in your $HOME directory to store preferences
-such as display options, font, and colors.
+User configuration and preferences are stored at:
+
+* '$XDG_CONFIG_HOME/git/gitk' if it exists, otherwise
+* '$HOME/.gitk' if it exists
+
+If neither of the above exist then '$XDG_CONFIG_HOME/git/gitk' is created and
+used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
+'$HOME/.config' in all cases.
 
 History
 -------
-- 
1.9.0
