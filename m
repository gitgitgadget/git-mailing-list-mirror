From: =?UTF-8?q?Gunnlaugur=20=C3=9E=C3=B3r=20Briem?= 
	<gunnlaugur@gmail.com>
Subject: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Tue, 23 Oct 2012 10:33:26 +0000
Message-ID: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Gunnlaugur=20=C3=9E=C3=B3r=20Briem?= 
	<gunnlaugur@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 12:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQbnv-0001mf-5E
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 12:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2JWKdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 06:33:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62296 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab2JWKde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 06:33:34 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1948692wey.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=f5VJqEcaEWCcK5WyOMwPZTEpkRaybSBYfwt1oyFivDk=;
        b=aNhYNpHrAxEw2ghAR+13CAT7sbBlSOEery9uHDFwfoTMvLY60RD5segsKvQZmvyEA5
         cUwKWEYod437eItwmmgkQAGiBrCdYW5M4UKYCGHq7+vTdOX49C5HjIclWL2Ywr/cYx0U
         LGrlbJdsJkEArjGr9LdP68xQoBpo3jIjH8DSige3t+epoZZdMxg3h+ZmHDr7vzLMYmM+
         qCQNxcQ+SjrLHtxmtOLsJQ4uCNZUthWN+JgYy3ateFsFJn17o6CHuLTUIE04CKkxNWiW
         w02utueUeFI1HZpjGne2c9eMhLbuO0E12Yh/HeT15jIdhn59Q4/8AjYApskF1D0jMEZK
         KdPQ==
Received: by 10.216.134.145 with SMTP id s17mr7596177wei.127.1350988413624;
        Tue, 23 Oct 2012 03:33:33 -0700 (PDT)
Received: from localhost.localdomain (85-220-16-193.dsl.dynamic.simnet.is. [85.220.16.193])
        by mx.google.com with ESMTPS id b7sm55622014wiz.3.2012.10.23.03.33.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 03:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208221>

The --log-window-size parameter to git-svn fetch is undocumented.

Minimally describe what it does and why the user might change it.

Signed-off-by: Gunnlaugur =C3=9E=C3=B3r Briem <gunnlaugur@gmail.com>
---
 Documentation/git-svn.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cfe8d2b..64756c9 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -146,6 +146,12 @@ Skip "branches" and "tags" of first level director=
ies;;
 ----------------------------------------------------------------------=
--
 --
=20
+--log-window-size=3D<n>;;
+    Fetch <n> log entries per request when scanning Subversion history=
=2E
+    The default is 100. For very large Subversion repositories, larger
+    values may be needed for 'clone'/'fetch' to complete in reasonable
+    time. But overly large values may lead to request timeouts.
+
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
 	directory based on the basename of the URL passed to it;
--=20
1.7.12.3
