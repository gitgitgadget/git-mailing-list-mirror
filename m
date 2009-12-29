From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 14:08:42 +0000
Message-ID: <20091229140842.GB6154@bit.office.eurotux.com>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
 <20091229123127.GA6154@bit.office.eurotux.com>
 <9cf5f850c0c5ea8054e9bebc810ea6d3@192.168.1.222>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Cc: git@vger.kernel.org
To: Jorge Bastos <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPckl-0002Ja-CY
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 15:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbZL2OIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 09:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZL2OIr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 09:08:47 -0500
Received: from os.eurotux.com ([216.75.63.6]:51616 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbZL2OIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 09:08:47 -0500
Received: (qmail 26289 invoked from network); 29 Dec 2009 14:08:46 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 29 Dec 2009 14:08:46 -0000
Content-Disposition: inline
In-Reply-To: <9cf5f850c0c5ea8054e9bebc810ea6d3@192.168.1.222>
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135798>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2009 at 12:38:15PM +0000, Jorge Bastos wrote:
> Hi Luciano,
>=20
> >> [Tue Dec 29 12:12:25 2009] [error] [client 192.168.1.3] [cgit] Unable
> to
> >> lock slot /var/cache/cgit/53200000.lock: No such file or directory (2)
> >=20
> > Does the directory /var/cache/cgit/ exist?
>=20
> Yap, with 777.
> But the parent dirs don't, they have 755 the debian default, and both /var
> & /var/log owner by root.

That's what they're supposed to be.

> I also tryed to make /var & /var/log/ be owner by apache's user (www-data)
> but nothing, and also tried make them 777 aswell, the same.
> This lock dir can't be configureable?

Probably, don't know much about cgit. One thing, are you using selinux?
What does sestatus show?

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAks6DWoACgkQinSul6a7oB8ppgCglf6xCbwaBSUvXNC3IRukzCV7
XdUAn3BxGZI9Z7/w0BQY3YBExYxFr3D4
=YelW
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
