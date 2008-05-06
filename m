From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Accessing a single repository with different addresses?
Date: Tue, 6 May 2008 17:58:32 +0100
Message-ID: <20080506165832.GA20228@bit.office.eurotux.com>
References: <8c0610ed0805060951x70ede89bq5a93e69aece8c8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: git@vger.kernel.org
To: Paul Holbrook <paul.holbrook@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtQVk-0007jN-VR
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764060AbYEFQ6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764129AbYEFQ6l
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:58:41 -0400
Received: from os.eurotux.com ([216.75.63.6]:59867 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763799AbYEFQ6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 12:58:39 -0400
Received: (qmail 17750 invoked from network); 6 May 2008 16:58:37 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@82.102.23.9)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 6 May 2008 16:58:37 -0000
Content-Disposition: inline
In-Reply-To: <8c0610ed0805060951x70ede89bq5a93e69aece8c8c7@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81370>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2008 at 12:51:13PM -0400, Paul Holbrook wrote:
> I have two machines at home that I've been using to play with git: a
> desktop box and a laptop.  I set up a repository on the desktop, and
> cloned it to the laptop via ssh, but using just a local 192.168.x.x
> address.  However, when I leave the house, I'd still like to be able
> to talk to the desktop repository, which I can still do via ssh back
> to the house - but now the address for that very same repository is
> not a 192 address, but a DNS name.   What's the best way to handle
> this?

Why not add a local dns server and use the same dns name?

Otherwise, I use a host declaration in .ssh/config, and switch as
needed:

host desktop
hostname 192....
user ...

But that was with svn. With git you can just add a new remote with the
other address:
git remote add rem host:....

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkggjjgACgkQinSul6a7oB/syACfW+fc+/KT6sVpj9FFFaAUiOCO
Q5UAniMbJONqFjFx3L+2eUADewj1OYVY
=NK+Q
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
