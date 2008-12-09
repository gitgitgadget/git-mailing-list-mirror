From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] Fix typos in documentation
Date: Tue,  9 Dec 2008 20:26:22 +0300
Message-ID: <1228843582-4829-1-git-send-email-aspotashev@gmail.com>
Cc: gitster@pobox.com, Alexander Potashev <aspotashev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 18:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA6Mt-0000D0-RV
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 18:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYLIR0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 12:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYLIRZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 12:25:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:9728 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYLIRZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 12:25:59 -0500
Received: by fg-out-1718.google.com with SMTP id 19so36281fgg.17
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ueOkYHQ5LZUx/yJYOsGc5p/3zbxcXPJfaOL5Tm+ki0U=;
        b=FgDYlha8+OXQnKOhwlD5Q7K1PQsUqSZmv6NC5dkykBFkrnYS4x9Yoe3wH7s44cgqfJ
         HixHHhmk7y01cDNdyPHwauEXDu94/GJ4jCOwvwg2ia/8dmEBFh2sqwhQXqO8V218TTpn
         3DX3YSS/OSSZYWbJu2gwpfc+GGkSfcClOJ7vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vjkj8aVooar5epcefebykxbS8VSFO1DsaZEmP0UrxOVLmornQqQEe5j61k4Y3H28j1
         C0htIgsxgg9bqVzkAY5dQI3lAlLIBntjfzUFsPeMxzi9L3Vc0qJ8DwJYzF5QwmOeY81x
         7NA/OFE47B7PHvelHZDCsKXff2Ro5MO7dRp9E=
Received: by 10.86.93.17 with SMTP id q17mr150654fgb.50.1228843557031;
        Tue, 09 Dec 2008 09:25:57 -0800 (PST)
Received: from localhost.localdomain ([91.78.103.177])
        by mx.google.com with ESMTPS id 4sm366744fge.40.2008.12.09.09.25.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 09:25:55 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102640>

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 Documentation/git-send-email.txt     |    2 +-
 Documentation/technical/racy-git.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index acf8bf4..1278866 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -46,7 +46,7 @@ The --cc option must be repeated for each user you want on the cc list.
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
 +
-When compose is in used, git send-email gets less interactive will use the
+When '--compose' is used, git send-email gets less interactive will use the
 values of the headers you set there. If the body of the email (what you type
 after the headers and a blank line) only contains blank (or GIT: prefixed)
 lines, the summary won't be sent, but git-send-email will still use the
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 6bdf034..48bb97f 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -135,7 +135,7 @@ them, and give the same timestamp to the index file:
 
 This will make all index entries racily clean.  The linux-2.6
 project, for example, there are over 20,000 files in the working
-tree.  On my Athron 64X2 3800+, after the above:
+tree.  On my Athlon 64 X2 3800+, after the above:
 
   $ /usr/bin/time git diff-files
   1.68user 0.54system 0:02.22elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
-- 
1.6.0.4
