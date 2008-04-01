From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: URL Syntax Question
Date: Tue, 1 Apr 2008 11:06:06 +0200
Message-ID: <20080401090606.GD3264@genesis.frugalware.org>
References: <E1JgUp6-0002Sc-Ts@jdl.com> <7vej9qgl44.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 11:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgcSG-0002Sg-Ua
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 11:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYDAJGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 05:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbYDAJGN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 05:06:13 -0400
Received: from virgo.iok.hu ([193.202.89.103]:17592 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbYDAJGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 05:06:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AB23B1B24F0;
	Tue,  1 Apr 2008 11:06:07 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1C6DD446A8;
	Tue,  1 Apr 2008 11:02:57 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DC5CD1190A3B; Tue,  1 Apr 2008 11:06:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vej9qgl44.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78638>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2008 at 11:11:39PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Personally, I'd prefer the scp syntax, which tends to be shorter and
> sweeter, though:
>=20
> 	host.xz:path/in/my/home/directory/repo.git
>         host.xz:/absolute/path/to/repo.git

Same here, but it seems I'm forced to use ssh:// if there is a custom
port:

        ssh://host:2222/home/vmiklos/git/repo

works fine, but I can't omit ssh:// nor the absolute path. Not sure if
this is intentional or a bug.

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfx+v4ACgkQe81tAgORUJYXngCgnWkWMArTBYPKnaNcgynNfJZF
oOEAnR8Xeae0d7Aap2l3j3/54hjGX3mw
=I7PD
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
