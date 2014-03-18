From: Astril Hayato <astrilhayato@gmail.com>
Subject: [PATCH v2] Documentation/gitk: Document new config file location
Date: Tue, 18 Mar 2014 17:53:07 +0000
Message-ID: <1395165187-3629-1-git-send-email-astrilhayato@gmail.com>
Cc: gitster@pobox.com, Astril Hayato <astrilhayato@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 18:53:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPyCz-0001dR-0e
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 18:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbaCRRxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 13:53:44 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:39332 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbaCRRxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 13:53:43 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so6071129wes.40
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fQYaoUZQ5Fdz1PAwg9Xvv3VWjAV8tzsiuO8lpeqOKnQ=;
        b=ZJaTqQY5iDIJxxAEs7zd4hY9M494oG+3V1b1Un0J3MKDWtMgPXNvU1pxHy2cYInegs
         JWpx/Cc3ENfzKoLw9f9mMXRFTOtLNOYkbhOOR7JJyYgl1qFW56unN4aibjcxnRn8F42x
         XHG3AXT93BbKupBAM5iHMeaN4Nk+FTOMlNxdwwLFSKtAIE0f6c97epRz3hJOGzvkzWi1
         iictPhLwhVcHo4Om9fqNh7PBAKNMBajrPb+JmK6TtmwQ9ku36vGeDyipcx/yGGLHCMOj
         9B/3UGXZDSR5AWEbS7F99Z3z734SvOd4+VT8vl6X6FgBMLnY1Ra8ePieBTJ6CS/n9D/j
         umnA==
X-Received: by 10.180.37.178 with SMTP id z18mr15938507wij.46.1395165222784;
        Tue, 18 Mar 2014 10:53:42 -0700 (PDT)
Received: from localhost.localdomain (cpc4-blbn8-2-0-cust14.10-1.cable.virginm.net. [86.22.6.15])
        by mx.google.com with ESMTPSA id at10sm43598990wjc.6.2014.03.18.10.53.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Mar 2014 10:53:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244363>

User config file location now complies with XDG base directory specification

Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
---
 Documentation/gitk.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 1e9e38a..c2aa514 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -166,8 +166,13 @@ gitk --max-count=100 --all \-- Makefile::
 
 Files
 -----
-Gitk creates the .gitk file in your $HOME directory to store preferences
-such as display options, font, and colors.
+User configuration and preferences are stored at (in order of priority):
+
+* '$XDG_CONFIG_HOME/git/gitk' if it exists and '$XDG_CONFIG_HOME' is set
+* '$HOME/.config/git/gitk' if it exists
+* '$HOME/.gitk' if it exists
+
+If none of the above exist then '$HOME/.config/git/gitk' is created and used by default.
 
 History
 -------
-- 
1.9.0
