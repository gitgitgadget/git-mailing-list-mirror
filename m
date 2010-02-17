From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 16:27:57 +0300
Message-ID: <201002171627.57599.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1596306.SfMsAsWxmp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 14:28:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhjwv-0002E2-4K
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 14:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212Ab0BQN2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 08:28:11 -0500
Received: from mx39.mail.ru ([94.100.176.53]:64901 "EHLO mx39.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602Ab0BQN2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 08:28:09 -0500
Received: from [91.77.129.7] (port=46412 helo=cooker.localnet)
	by mx39.mail.ru with asmtp 
	id 1Nhjwj-000AUW-00
	for git@vger.kernel.org; Wed, 17 Feb 2010 16:28:05 +0300
User-Agent: KMail/1.13.0 (Linux/2.6.33-desktop-0.rc8.1mnb; KDE/4.4.0; x86_64; ; )
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140234>

--nextPart1596306.SfMsAsWxmp
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a feeling that documentation is not up to date.

{pts/1}% git --version
git version 1.6.6.2

Reading man git-push:

       --all
           Instead of naming each ref to push, specifies that all refs=20
under
           $GIT_DIR/refs/heads/ be pushed.

OK, so

{pts/1}% git push -n --all
To ssh://git.mandriva.com/projects/networkmanager.git
 * [new branch]      local-mdv -> local-mdv
 * [new branch]      local-mdv.stgit -> local-mdv.stgit
 * [new branch]      tmp -> tmp
 * [new branch]      tmp.stgit -> tmp.stgit

so far so good, but

{pts/1}% l .git/refs/heads
local-mdv  local-mdv.stgit

Apparently $GIT/refs/heads is not the only place?

--nextPart1596306.SfMsAsWxmp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkt77t0ACgkQR6LMutpd94zgHwCcCp/xd1r1CV5/bZ798UxATc72
v/QAn1Lu9uO/JedRd8eEMFRzH4YX+nDI
=d9i5
-----END PGP SIGNATURE-----

--nextPart1596306.SfMsAsWxmp--
