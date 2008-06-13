From: Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?= 
	<alejandro.riveira@gmail.com>
Subject: Patch to add  git-help--browse to .gitignore
Date: Sat, 14 Jun 2008 00:30:39 +0200
Message-ID: <1213396239.12920.2.camel@Varda>
Reply-To: alejandro.riveira@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EcVGhk347GOlDB+F8TnD"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 00:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Ho4-0001Sb-Io
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 00:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbYFMWaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 18:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbYFMWaq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 18:30:46 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:31644 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbYFMWap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 18:30:45 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3154979ika.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to
         :content-type:date:message-id:mime-version:x-mailer;
        bh=fUlHqAKUw9G+epOHHLVhAegX46DyFo1viEanmcPl5wg=;
        b=kPqZWQ06wTisYQYewmTvzUnkl4SI2pWWK6aUgx/7VvXt794URSLjvAN8rhE4gp3GQO
         mAE5o9L9GhDet0rs9GRD3O1/ajpnYoblxFo1EwRyAZJ9nUi/lPLJ17I0l1AqW3+hkkas
         g5R5qCL2eIenpd9aa2WSquzoC7TgC4deG8J1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:content-type:date:message-id:mime-version
         :x-mailer;
        b=wa4Vi2Lr/NChc1LpgqtSWUypPzclsRjtyBquBPG4N2fRgzuIXgZEABqZuaMRMZMM5u
         FP1GoYNhYa7QQ65nd6Unf+AhoBLWEJhCcgZFMeaBP8+4eT7S9X/gEHBCYsfMN9L+BaBa
         G48S1vph7t+ANdq16u5Y+npTAVv8vB8eGMUf8=
Received: by 10.210.131.6 with SMTP id e6mr3155877ebd.10.1213396241677;
        Fri, 13 Jun 2008 15:30:41 -0700 (PDT)
Received: from ?10.0.0.2? ( [83.37.199.169])
        by mx.google.com with ESMTPS id q9sm5654872gve.5.2008.06.13.15.30.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 15:30:40 -0700 (PDT)
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84946>


--=-EcVGhk347GOlDB+F8TnD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When i run =C2=ABgit status=C2=BB on a cloned git repo with
build files around i get

$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       git-help--browse
nothing added to commit but untracked files present (use "git add" to track=
)

So i think something like this is needed

Thanks for your time.

---

diff --git a/.gitignore b/.gitignore
index 4ff2fec..8c77234 100644
--- a/.gitignore
+++ b/.gitignore
@@ -51,6 +51,7 @@ git-gc
 git-get-tar-commit-id
 git-grep
 git-hash-object
+git-help--browse
 git-http-fetch
 git-http-push
 git-imap-send


--=20
The idea that Bill Gates has appeared like a knight in shining armour to
lead all customers out of a mire of technological chaos neatly ignores
the fact that it was he who, by peddling second-rate technology, led
them into it in the first place.=20
                                     Douglas Adams

--=-EcVGhk347GOlDB+F8TnD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEABECAAYFAkhS9Q8ACgkQ3GEkiSnUSOH6pwCfb8hUoYMMI3EtTmD3d/6gTeBs
D/EAmQE7dTTt7mS/4tUbyVAE+ICuh/Sx
=T8w4
-----END PGP SIGNATURE-----

--=-EcVGhk347GOlDB+F8TnD--
