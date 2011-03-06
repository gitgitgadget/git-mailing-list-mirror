From: A.J.Delaney@brighton.ac.uk
Subject: Re: [Patch] Error message grammar
Date: Sun, 06 Mar 2011 15:21:28 +0000
Message-ID: <1299424888.4990.13.camel@SillyFace>
References: <1299101838.2807.54.camel@SillyFace>
	 <vpqd3m9yycf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-TNTS+T4OHVvHUKD7BOH1"
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Mar 06 16:21:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwFm8-0006kn-JZ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 16:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab1CFPVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 10:21:32 -0500
Received: from mail207.messagelabs.com ([85.158.136.67]:22568 "EHLO
	mail207.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab1CFPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 10:21:31 -0500
X-VirusChecked: Checked
X-Env-Sender: A.J.Delaney@brighton.ac.uk
X-Msg-Ref: server-9.tower-207.messagelabs.com!1299424889!16889779!1
X-StarScan-Version: 6.2.9; banners=-,-,-
X-Originating-IP: [194.81.203.230]
Received: (qmail 1419 invoked from network); 6 Mar 2011 15:21:29 -0000
Received: from msa1.bton.ac.uk (HELO msa1.bton.ac.uk) (194.81.203.230)
  by server-9.tower-207.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 6 Mar 2011 15:21:29 -0000
Received: from [87.127.55.57] (port=40580 helo=[10.0.1.35])
	by msa1.bton.ac.uk with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <A.J.Delaney@brighton.ac.uk>)
	id 1PwFlx-0007oO-8Z; Sun, 06 Mar 2011 15:21:29 +0000
In-Reply-To: <vpqd3m9yycf.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
X-UoB-Sender: A.J.Delaney@brighton.ac.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168519>


--=-TNTS+T4OHVvHUKD7BOH1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu,
On Wed, 2011-03-02 at 23:03 +0100, Matthieu Moy wrote:
> Please, read
> http://repo.or.cz/w/git.git/blob_plain?f=3DDocumentation/SubmittingPatche=
s
> in particular the Signed-off-by part and the "don't attach patches"
> one.
Thanks for the pointer.

Based on master f70f736bcbb22cfe434eaf20089d9713b991ee31

Trivial changes to grammar on some error messages reported by
git-commit.

I certify conformance to Developer's Certificate of Origin 1.1.

Signed-off-by: Aidan Delaney <a.j.delaney@brighton.ac.uk>
---
 builtin/commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 355b2cb..d56ddeb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -991,9 +991,9 @@ static int parse_and_validate_options(int argc,
const char *argv[],
 	handle_untracked_files_arg(s);
=20
 	if (all && argc > 0)
-		die("Paths with -a does not make sense.");
+		die("Using paths with -a does not make sense.");
 	else if (interactive && argc > 0)
-		die("Paths with --interactive does not make sense.");
+		die("Using paths with --interactive does not make sense.");
=20
 	if (null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
--=20
1.7.4


--=20
Aidan Delaney

--=-TNTS+T4OHVvHUKD7BOH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1zpm8ACgkQ60Apq5Qz4PupIwCaA3oxi3U3UCltjsePG/WrOe57
z6MAnA6R+2Mey21RC7thAX80lJogUavh
=jeqW
-----END PGP SIGNATURE-----

--=-TNTS+T4OHVvHUKD7BOH1--
