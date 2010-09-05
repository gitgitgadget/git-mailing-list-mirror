From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Documentation: document the string-list macros.
Date: Sun,  5 Sep 2010 14:51:17 -0300
Message-ID: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
Cc: jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 19:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJNK-0006R5-3e
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab0IERvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:51:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38985 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab0IERvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:51:25 -0400
Received: by gxk23 with SMTP id 23so1396315gxk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=maWVlT4SSN4QT3US2eQ7UEf/0ZtWCsolYVEMvKH/1To=;
        b=h5XqNW9KzRykBeUdzm/T2U52QEoijPvX4L9w4ENPInB24M+DS5DiNhBqFkMzO2Y3/f
         T1gF7SzbFFsikqiGlg6BZaanuu0n8fT0nKVbKpTcMbTEiqypfWaEzBJneq6P4wg3SsSF
         0R9r/ygEFfJeZUQskRPiXe8cKvX35aTEUBOQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CSx2c49Oo3Y6mPwZO8xJhzTtAWhNF6+OzS9qi2Bq2iZwbAMW8r+Nwl+6BhoOO+NMNx
         DPE4gnuyh20i/vRO4L88uZH0SMQcN80wXITNMX07phusCRD5aRSp2XcPrYlbH8G1l6cr
         EIhBqTgqtqGLzqi0r4nvF0r4+cgBUo3jI4g7o=
Received: by 10.100.126.11 with SMTP id y11mr523448anc.115.1283709084298;
        Sun, 05 Sep 2010 10:51:24 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id x33sm7407626ana.13.2010.09.05.10.51.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 10:51:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155471>

Add basic documentation about the string-list.h macros
that can be used to initialize the string_list structure.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Documentation/technical/api-string-list.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3f575bd..cec11b5 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -52,6 +52,18 @@ However, if you use the list to check if a certain string was added
 already, you should not do that (using unsorted_string_list_has_string()),
 because the complexity would be quadratic again (but with a worse factor).
 
+Macros
+------
+
+`STRING_LIST_INIT_NODUP`::
+
+	Initialize the members and set the `strdup_strings` member to 0.
+
+`STRING_LIST_INIT_DUP`::
+
+	Initialize the members and set the `strdup_strings` member to 1.
+
+
 Functions
 ---------
 
-- 
1.7.2.3.313.gcd15
