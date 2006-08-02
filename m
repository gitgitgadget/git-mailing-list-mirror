From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Wed, 2 Aug 2006 15:21:50 +0200
Message-ID: <20060802132149.GG16364@admingilde.org>
References: <00c201c6b5cf$8089a580$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 15:22:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Gfh-0002A1-5M
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 15:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWHBNVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 09:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWHBNVv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 09:21:51 -0400
Received: from admingilde.org ([213.95.32.146]:46243 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751027AbWHBNVu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 09:21:50 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G8GfW-0003PU-3w; Wed, 02 Aug 2006 15:21:50 +0200
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Content-Disposition: inline
In-Reply-To: <00c201c6b5cf$8089a580$c47eedc1@ramsay1.demon.co.uk>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24647>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Aug 02, 2006 at 02:03:44AM +0100, Ramsay Jones wrote:
>  builtin-help.c |   54
> +++++++++++++++++++++++-------------------------------
>  builtin.h      |    7 ++-----
>  git.c          |    7 +++++--
>  3 files changed, 30 insertions(+), 38 deletions(-)

this patch is at the tip of "master" now, but with one more change:
builtin-help.c           |   54 ++++++++++++++++++++-----------------------=
---
builtin.h                |    7 ++----
git.c                    |    7 ++++--
t/t9100-git-svn-basic.sh |    7 +++---
4 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index bf1d638..34a3ccd 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -170,7 +170,7 @@ then
             test -L $SVN_TREE/exec-2.sh"

        name=3D'modify a symlink to become a file'
-       git help > help || true
+       echo git help > help || true
        rm exec-2.sh
        cp help exec-2.sh
        git update-index exec-2.sh

this looks strange.

--=20
Martin Waitz

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE0Kbtj/Eaxd/oD7IRAsQmAJ98LqH8wTHRkRGxKDqRXDmzcy2gdwCfSXW4
9dXIgS5xccooVud9B5Z0LJI=
=zWxJ
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
