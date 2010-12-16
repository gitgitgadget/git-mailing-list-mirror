From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 1/3] gitweb: add extensions to highlight feature
Date: Thu, 16 Dec 2010 22:43:19 +0100
Message-ID: <1292535801-7421-2-git-send-email-sylvain@abstraction.fr>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 22:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLbq-0005V0-Q2
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501Ab0LPVnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:43:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41499 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495Ab0LPVn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:43:29 -0500
Received: by wwa36 with SMTP id 36so14560wwa.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 13:43:28 -0800 (PST)
Received: by 10.216.150.164 with SMTP id z36mr2918245wej.43.1292535808234;
        Thu, 16 Dec 2010 13:43:28 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n11sm297651wej.43.2010.12.16.13.43.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 13:43:27 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163817>

added: sql, php5, phps, bash, zsh, mk

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d521c93..db18d06 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -250,13 +250,14 @@ our %highlight_ext = (
 	# main extensions, defining name of syntax;
 	# see files in /usr/share/highlight/langDefs/ directory
 	map { $_ => $_ }
-		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
+		qw(py c cpp rb java css php pl js tex bib xml awk bat ini spec tcl sql),
 	# alternate extensions, see /etc/highlight/filetypes.conf
 	'h' => 'c',
+	map { $_ => 'sh'  } qw(bash zsh),
 	map { $_ => 'cpp' } qw(cxx c++ cc),
-	map { $_ => 'php' } qw(php3 php4),
+	map { $_ => 'php' } qw(php3 php4 php5 phps),
 	map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
-	'mak' => 'make',
+	map { $_ => 'make'} qw(mak mk),
 	map { $_ => 'xml' } qw(xhtml html htm),
 );
 
-- 
1.7.3.2
