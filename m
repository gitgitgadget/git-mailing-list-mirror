From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Problem with git-svnimport
Date: Thu, 18 Oct 2007 20:09:16 +0200
Message-ID: <20071018180916.GK26127@efreet.light.src>
References: <55DDB08CC9CD2941A70E8D626789A2C906A4031A@ec8l7ljvo9h5dde.hosting.exch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Cc: git@vger.kernel.org
To: VAUCHER Laurent <VAUCHER@fermat.eu>
X-From: git-owner@vger.kernel.org Thu Oct 18 20:09:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiZoU-00038N-Gq
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 20:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840AbXJRSJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758824AbXJRSJc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 14:09:32 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:48769 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758575AbXJRSJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 14:09:31 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E8BA357298;
	Thu, 18 Oct 2007 20:09:23 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id pGYlRpvjfa4P; Thu, 18 Oct 2007 20:09:21 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C57A757262;
	Thu, 18 Oct 2007 20:09:19 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IiZo4-0007mK-Bh; Thu, 18 Oct 2007 20:09:16 +0200
Content-Disposition: inline
In-Reply-To: <55DDB08CC9CD2941A70E8D626789A2C906A4031A@ec8l7ljvo9h5dde.hosting.exch>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61553>


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 14:30:30 +0200, VAUCHER Laurent wrote:
>   Hi.
>=20
>   Trying to convert a svn repository to git, I encountered the following
> error:
>=20
> Use of uninitialized value in hash element at /usr/bin/git-svnimport
> line 534.
>=20
>   Line 534 reads:
> 	my $gitrev =3D $branches{$srcbranch}{$therev};
>=20
>   I have installed packages git-core and git-svn on Ubuntu. These
> package have versions: "1:1.5.2.5-2-feisty1"
>=20
>   The tool seems to choke on tags or branches with special characters
> (underscore, for instance).

git-svnimport is obsoleted (or mostly so) by git-svn. Look at that, please.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHF6FMRel1vVwhjGURAjKLAJ43TtaQGvAh88Bzlxq/IE3lOV5vJQCfYSnd
N3XNrNnuJtb1PLM+WSXs9vw=
=14q7
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
