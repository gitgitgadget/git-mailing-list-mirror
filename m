From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 08/22] git-remote-mediawiki: Add newline in the end of die() error messages
Date: Fri,  7 Jun 2013 23:42:09 +0200
Message-ID: <1370641344-4253-9-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:44:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4Rz-00009l-NY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab3FGVnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55297 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756423Ab3FGVnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:13 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lh1Lf003260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:01 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57Lh44N029579;
	Fri, 7 Jun 2013 23:43:04 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRj019409;
	Fri, 7 Jun 2013 23:43:04 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lh1Lf003260
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246182.91573@7zd+kcbuLS2gwbtRsUtSgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226734>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   26 +++++++++++++------=
-------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 482cd95..4baad95 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -136,16 +136,16 @@ while (<STDIN>) {
 	if (defined($cmd[0])) {
 		# Line not blank
 		if ($cmd[0] eq "capabilities") {
-			die("Too many arguments for capabilities") unless (!defined($cmd[1]=
));
+			die("Too many arguments for capabilities\n") unless (!defined($cmd[=
1]));
 			mw_capabilities();
 		} elsif ($cmd[0] eq "list") {
-			die("Too many arguments for list") unless (!defined($cmd[2]));
+			die("Too many arguments for list\n") unless (!defined($cmd[2]));
 			mw_list($cmd[1]);
 		} elsif ($cmd[0] eq "import") {
-			die("Invalid arguments for import") unless ($cmd[1] ne "" && !defin=
ed($cmd[2]));
+			die("Invalid arguments for import\n") unless ($cmd[1] ne "" && !def=
ined($cmd[2]));
 			mw_import($cmd[1]);
 		} elsif ($cmd[0] eq "option") {
-			die("Too many arguments for option") unless ($cmd[1] ne "" && $cmd[=
2] ne "" && !defined($cmd[3]));
+			die("Too many arguments for option\n") unless ($cmd[1] ne "" && $cm=
d[2] ne "" && !defined($cmd[3]));
 			mw_option($cmd[1],$cmd[2]);
 		} elsif ($cmd[0] eq "push") {
 			mw_push($cmd[1]);
@@ -242,7 +242,7 @@ sub get_mw_tracked_categories {
 			cmtitle =3D> $category,
 			cmlimit =3D> 'max' } )
 			|| die $mediawiki->{error}->{code} . ': '
-				. $mediawiki->{error}->{details};
+				. $mediawiki->{error}->{details} . "\n";
 		foreach my $page (@{$mw_pages}) {
 			$pages->{$page->{title}} =3D $page;
 		}
@@ -767,7 +767,7 @@ sub get_more_refs {
 		} elsif ($line eq "\n") {
 			return @refs;
 		} else {
-			die("Invalid command in a '$cmd' batch: ". $_);
+			die("Invalid command in a '$cmd' batch: $_\n");
 		}
 	}
 	return;
@@ -879,7 +879,7 @@ sub mw_import_revids {
 		my $result =3D $mediawiki->api($query);
=20
 		if (!$result) {
-			die "Failed to retrieve modified page for revision $pagerevid";
+			die "Failed to retrieve modified page for revision $pagerevid\n";
 		}
=20
 		if (defined($result->{query}->{badrevids}->{$pagerevid})) {
@@ -888,7 +888,7 @@ sub mw_import_revids {
 		}
=20
 		if (!defined($result->{query}->{pages})) {
-			die "Invalid revision $pagerevid.";
+			die "Invalid revision $pagerevid.\n";
 		}
=20
 		my @result_pages =3D values(%{$result->{query}->{pages}});
@@ -999,7 +999,7 @@ sub mw_upload_file {
 			}, {
 				skip_encoding =3D> 1
 			} ) || die $mediawiki->{error}->{code} . ':'
-				 . $mediawiki->{error}->{details};
+				 . $mediawiki->{error}->{details} . "\n";
 			my $last_file_page =3D $mediawiki->get_page({title =3D> $path});
 			$newrevid =3D $last_file_page->{revid};
 			print STDERR "Pushed file: $new_sha1 - $complete_file_name.\n";
@@ -1079,7 +1079,7 @@ sub mw_push_file {
 				# Other errors. Shouldn't happen =3D> just die()
 				die 'Fatal: Error ' .
 				    $mediawiki->{error}->{code} .
-				    ' from mediwiki: ' . $mediawiki->{error}->{details};
+				    ' from mediwiki: ' . $mediawiki->{error}->{details} . "\n";
 			}
 		}
 		$newrevid =3D $result->{edit}->{newrevid};
@@ -1101,7 +1101,7 @@ sub mw_push {
 	my $pushed;
 	for my $refspec (@refsspecs) {
 		my ($force, $local, $remote) =3D $refspec =3D~ /^(\+)?([^:]*):([^:]*=
)$/
-		    or die("Invalid refspec for push. Expected <src>:<dst> or +<src>=
:<dst>");
+		    or die("Invalid refspec for push. Expected <src>:<dst> or +<src>=
:<dst>\n");
 		if ($force) {
 			print STDERR "Warning: forced push not allowed on a MediaWiki.\n";
 		}
@@ -1173,7 +1173,7 @@ sub mw_push_revision {
 					$local_ancestry{$parent} =3D $child;
 				}
 			} elsif (!$line =3D~ /^([a-f0-9]+)/) {
-				die "Unexpected output from git rev-list: $line";
+				die "Unexpected output from git rev-list: $line\n";
 			}
 		}
 		while ($parsed_sha1 ne $HEAD_sha1) {
@@ -1227,7 +1227,7 @@ sub mw_push_revision {
 				return error_non_fast_forward($remote);
 			}
 			if ($status ne "ok") {
-				die("Unknown error from mw_push_file()");
+				die("Unknown error from mw_push_file()\n");
 			}
 		}
 		unless ($dumb_push) {
--=20
1.7.9.5
