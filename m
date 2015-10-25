From: Christian Weiske <cweiske@cweiske.de>
Subject: git svn clone clone php/pear/Net_LDAP2 misses tags and branches
Date: Sun, 25 Oct 2015 15:43:25 +0100
Message-ID: <20151025154325.36eddb4c@bogo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/f4wlefEEp8NDy4cFiCA4sF4"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 15:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqMch-0003WB-1P
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 15:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbJYOuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 10:50:08 -0400
Received: from cweiske.de ([5.35.241.22]:50647 "EHLO mail.cweiske.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbbJYOuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 10:50:07 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2015 10:50:06 EDT
Received: by mail.cweiske.de (Postfix, from userid 65534)
	id 3D4632E570D; Sun, 25 Oct 2015 15:43:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ahso2
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=ham version=3.3.2
Received: from bogo (p5B09EA9E.dip0.t-ipconnect.de [91.9.234.158])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.cweiske.de (Postfix) with ESMTPSA id BEC512E567F
	for <git@vger.kernel.org>; Sun, 25 Oct 2015 15:43:27 +0100 (CET)
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280154>

--Sig_/f4wlefEEp8NDy4cFiCA4sF4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


Using git 2.6.2 to clone an SVN repository misses out branches and tags.

The clone command:

$ git svn clone --trunk=3Dtrunk --tags=3Dtags --branches=3Dbranches
  --prefix=3Dorigin/
  https://svn.php.net/repository/pear/packages/Net_LDAP2 -r 255346

The final repository's tag and branch list is empty.

There are tags and branches, though - see the web interface at
http://svn.php.net/viewvc/pear/packages/Net_LDAP2/

What am I doing wrong here?

--=20
Regards/Mit freundlichen Gr=C3=BC=C3=9Fen
Christian Weiske

-=3D=E2=89=A1 Geeking around in the name of science since 1982 =E2=89=A1=3D-

--Sig_/f4wlefEEp8NDy4cFiCA4sF4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlYs6o0ACgkQFMhaCCTq+CPK/ACfauviZ2UiU7SMLPMuDJ+XREHB
SGwAn3WAOVgl/E5ZgmLWwAlh9kEFKO50
=i3x0
-----END PGP SIGNATURE-----

--Sig_/f4wlefEEp8NDy4cFiCA4sF4--
