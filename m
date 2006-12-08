X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] Fix documentation copy&paste typo
Date: Fri,  8 Dec 2006 12:44:31 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 11:45:09 +0000 (UTC)
Cc: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
X-Mailer: git-send-email 1.4.4.2.gb772
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33688>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gse9z-000116-Cy for gcvg-git@gmane.org; Fri, 08 Dec
 2006 12:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425409AbWLHLom (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 06:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425416AbWLHLom
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 06:44:42 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:52697 "EHLO
 atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1425409AbWLHLol (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8
 Dec 2006 06:44:41 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6]) by
 atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60) (envelope-from
 <zeisberg@informatik.uni-freiburg.de>) id 1Gse9g-00038t-En; Fri, 08 Dec 2006
 12:44:40 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1]) by
 login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id
 kB8BiXu7013153; Fri, 8 Dec 2006 12:44:33 +0100 (MET)
Received: (from zeisberg@localhost) by login.informatik.uni-freiburg.de
 (8.13.6/8.12.11/Submit) id kB8BiWsd013152; Fri, 8 Dec 2006 12:44:32 +0100
 (MET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

=46rom: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

This was introduced in 45a3b12cfd3eaa05bbb0954790d5be5b8240a7b5

Signed-off-by: Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.=
de>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 093bd72..ed40810 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -120,7 +120,7 @@ our %feature =3D (
 	# To disable system wide have in $GITWEB_CONFIG
 	# $feature{'snapshot'}{'default'} =3D [undef];
 	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'blame'}{'override'} =3D 1;
+	# $feature{'snapshot'}{'override'} =3D 1;
 	# and in project config gitweb.snapshot =3D none|gzip|bzip2;
 	'snapshot' =3D> {
 		'sub' =3D> \&feature_snapshot,
--=20
1.4.4.2.gb772
