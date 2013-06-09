From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 14/28] git-remote-mediawiki: Change the name of a variable
Date: Mon, 10 Jun 2013 00:22:39 +0200
Message-ID: <1370816573-3808-15-git-send-email-celestin.matte@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo2P-0001Ca-I2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab3FIWX6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:23:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37820 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab3FIWX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:23:57 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNg3u010978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:42 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNieg019469;
	Mon, 10 Jun 2013 00:23:44 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHb008599;
	Mon, 10 Jun 2013 00:23:44 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 00:23:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNg3u010978
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421426.52904@xJTmJYe+h6c4aONgSEyMSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227192>

Local variable $url has the same name as a global variable. Changing th=
e name
of the local variable prevents future possible misunderstanding.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 44c5e0e..63d1530 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -454,14 +454,14 @@ sub get_mw_mediafile_for_page_revision {
 }
=20
 sub download_mw_mediafile {
-	my $url =3D shift;
+	my $download_url =3D shift;
=20
-	my $response =3D $mediawiki->{ua}->get($url);
+	my $response =3D $mediawiki->{ua}->get($download_url);
 	if ($response->code =3D=3D 200) {
 		return $response->decoded_content;
 	} else {
 		print STDERR "Error downloading mediafile from :\n";
-		print STDERR "URL: $url\n";
+		print STDERR "URL: $download_url\n";
 		print STDERR "Server response: " . $response->code . " " . $response=
->message . "\n";
 		exit 1;
 	}
--=20
1.7.9.5
