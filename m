From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Documentation/pretty-{formats,options}: better reference for "format:<string>"
Date: Wed,  2 Jun 2010 01:54:46 +0800
Message-ID: <1275414886-942-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 01 19:55:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVgx-0006qL-6D
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab0FARxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 13:53:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:56338 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab0FARxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:53:50 -0400
Received: by pxi18 with SMTP id 18so2058929pxi.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kM4yd2JL4lgBQify+t5WNZy8TNS9A/u5OPXhMGnjiTY=;
        b=biEacAoANsGv/rGzx0I1X0sNn2p56tiZTJeg5IEqboF5fKlsIjmIbvyEPSNdjd0rp3
         RGpeHtyLpoU4XK3U006h156y62HIahBpg4sSCTxyy8mNeONmH0e8+hze4wdHq76S5Gvw
         +LrFPI7ooZHjd5oJg+T8WkStMfK7bXpxD8nck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OVqMC9JpNF4iXzIkQU/nYBvghgjJ2lHIEcLlbaoKGP+uypsfq/dcxIAs/QnB72Qmkj
         NldrDGHpDoxLU0tERbjRMQukSA5NEotdwPNZFifvFyj4+QEBdX8wTKWVavFxv+eD8gQQ
         wl3rmZRZsqXe95aik++LJEml+v04dS2WTl5ag=
Received: by 10.114.236.2 with SMTP id j2mr5254009wah.110.1275414830277;
        Tue, 01 Jun 2010 10:53:50 -0700 (PDT)
Received: from localhost.localdomain ([115.134.154.164])
        by mx.google.com with ESMTPS id f11sm61207433wai.23.2010.06.01.10.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 10:53:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.226.g770c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148149>

In "git help log" (and friends) it's not easy to find the possible
placeholder for <string> for the "--pretty=format:<string>" option
to git log.

This patch makes the placholder easier to find by adding a reference
to the "PRETTY FORMATS" section and repeating the "format:<string>"
phrase.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 Documentation/pretty-formats.txt |    4 ++--
 Documentation/pretty-options.txt |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..c85a52c 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -76,9 +76,9 @@ displayed in full, regardless of whether --abbrev or
 true parent commits, without taking grafts nor history
 simplification into account.
 
-* 'format:'
+* 'format:<string>'
 +
-The 'format:' format allows you to specify which information
+The 'format:<string>' format allows you to specify which information
 you want to show. It works a little bit like printf format,
 with the notable exception that you get a newline with '%n'
 instead of '\n'.
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index af6d2b9..d78e121 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,8 +3,9 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
-	When omitted, the format defaults to 'medium'.
+	'full', 'fuller', 'email', 'raw' and 'format:<string>'.  See
+	the "PRETTY FORMATS" section for some additional details for each
+	format.  When omitted, the format defaults to 'medium'.
 +
 Note: you can specify the default pretty format in the repository
 configuration (see linkgit:git-config[1]).
-- 
1.7.1.226.g770c5
