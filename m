From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 03/28] git-remote-mediawiki: Replace :utf8 by :encoding(UTF-8)
Date: Mon, 10 Jun 2013 00:22:28 +0200
Message-ID: <1370816573-3808-4-git-send-email-celestin.matte@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:25:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo3b-0001nF-O1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab3FIWZg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:25:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41258 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab3FIWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:23:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNXU9021483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:33 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNaIM019425;
	Mon, 10 Jun 2013 00:23:36 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHQ008599;
	Mon, 10 Jun 2013 00:23:36 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 00:23:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNXU9021483
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421416.59646@zfV8O2tBFB7Xi+D7NmzQNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227202>

=46ollow perlcritic's InputOutput::RequireEncodingWithUTF8Layer policy

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 863ecc9..5e198e0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -18,8 +18,8 @@ use DateTime::Format::ISO8601;
 use warnings;
=20
 # By default, use UTF-8 to communicate with Git and the user
-binmode STDERR, ":utf8";
-binmode STDOUT, ":utf8";
+binmode STDERR, ":encoding(UTF-8)";
+binmode STDOUT, ":encoding(UTF-8)";
=20
 use URI::Escape;
 use IPC::Open2;
@@ -587,7 +587,7 @@ sub literal_data_raw {
 	utf8::downgrade($content);
 	binmode STDOUT, ":raw";
 	print STDOUT "data ", bytes::length($content), "\n", $content;
-	binmode STDOUT, ":utf8";
+	binmode STDOUT, ":encoding(UTF-8)";
 }
=20
 sub mw_capabilities {
--=20
1.7.9.5
