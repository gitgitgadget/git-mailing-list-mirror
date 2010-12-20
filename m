From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 1/3] gitweb: add extensions to highlight feature
Date: Mon, 20 Dec 2010 20:01:19 +0100
Message-ID: <1292871681-4818-2-git-send-email-sylvain@abstraction.fr>
References: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 20:01:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUkzK-0007Tv-8E
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 20:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755Ab0LTTBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 14:01:32 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40065 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab0LTTBb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 14:01:31 -0500
Received: by wyb28 with SMTP id 28so3175777wyb.19
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 11:01:30 -0800 (PST)
Received: by 10.216.17.201 with SMTP id j51mr5192706wej.44.1292871690450;
        Mon, 20 Dec 2010 11:01:30 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n1sm2038948weq.31.2010.12.20.11.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 11:01:29 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
In-Reply-To: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164003>

added: sql, php5, phps, bash, zsh, ksh, mk, make

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d521c93..a37094e 100755
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
