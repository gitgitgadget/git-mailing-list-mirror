From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 1/3] gitweb: add extensions to highlight feature
Date: Wed, 29 Dec 2010 20:33:33 +0100
Message-ID: <1293651215-4924-2-git-send-email-sylvain@abstraction.fr>
References: <1293651215-4924-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 20:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY1mN-0007QP-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 20:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab0L2Tdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 14:33:45 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46465 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab0L2Tdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 14:33:43 -0500
Received: by wwi17 with SMTP id 17so10721375wwi.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 11:33:42 -0800 (PST)
Received: by 10.216.28.74 with SMTP id f52mr10993289wea.26.1293651222035;
        Wed, 29 Dec 2010 11:33:42 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id p4sm7300204wer.5.2010.12.29.11.33.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 11:33:41 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
In-Reply-To: <1293651215-4924-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164326>

added: sql, php5, phps, bash, zsh, ksh, mk, make

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4779618..ea984b9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -250,13 +250,14 @@ our %highlight_ext = (
 	# main extensions, defining name of syntax;
 	# see files in /usr/share/highlight/langDefs/ directory
 	map { $_ => $_ }
-		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
+		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
 	# alternate extensions, see /etc/highlight/filetypes.conf
 	'h' => 'c',
+	map { $_ => 'sh'  } qw(bash zsh ksh),
 	map { $_ => 'cpp' } qw(cxx c++ cc),
-	map { $_ => 'php' } qw(php3 php4),
+	map { $_ => 'php' } qw(php3 php4 php5 phps),
 	map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
-	'mak' => 'make',
+	map { $_ => 'make'} qw(mak mk),
 	map { $_ => 'xml' } qw(xhtml html htm),
 );
 
-- 
1.7.3.4.523.g72f0d.dirty
