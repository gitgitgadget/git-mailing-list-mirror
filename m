From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 4/9] gitweb: right-align date cell in shortlog
Date: Sat, 27 Jun 2009 14:05:00 +0200
Message-ID: <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfi-0007Dq-Ch
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbZF0MFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbZF0MFU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbZF0MFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:07 -0400
Received: by fg-out-1718.google.com with SMTP id e12so183147fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C1lhLhoNrmKHi7TfzcO2u7+K9ES5hJpirDTYuoRsmvQ=;
        b=qcCkHZG7QXDmga3dPasjDLpvH3TwLq4uVhW5tzvsFWpb/d6X0W0nGi3nh8JYW+Bs/Q
         IClSWOEUydbBJschf48/zzZEWSEw08ReKHWkmm5k3fa0IM1Zfb9JcnT0HqwydDI7DiDd
         KUupc4jbN/rqx4PYH2+mdMCrKLmXJAKtc8HeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rQ5Na9tl9j8gIc0enlWu2lIPvLd/hSkreSBIFDq3PVlhmky0AjGW3xxvyqV9e1p+bK
         sSZ51qNMEQIHCKYUU4Qz0+5mEzQr30k7ajBhksARNcbA91uChTqSaGmAAgBsvsTRWdOy
         epM9vcEhJKxfyF9ZZwLn5dJMnYWcSmYnByvo0=
Received: by 10.86.74.1 with SMTP id w1mr4507460fga.53.1246104309870;
        Sat, 27 Jun 2009 05:05:09 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id l12sm6956785fgb.9.2009.06.27.05.05.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122357>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 68b22ff..ef24a1b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -180,6 +180,10 @@ table {
 	border-spacing: 0;
 }
 
+table.shortlog td:first-child {
+	text-align: right;
+}
+
 table.diff_tree {
 	font-family: monospace;
 }
-- 
1.6.3.rc1.192.gdbfcb
