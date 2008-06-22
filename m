From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Exec format error when using gitweb
Date: Sun, 22 Jun 2008 15:42:40 +0100
Message-ID: <20080622144240.GA18324@bit.office.eurotux.com>
References: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 16:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQmx-0000DI-TR
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYFVOmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYFVOmg
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:42:36 -0400
Received: from os.eurotux.com ([216.75.63.6]:44368 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbYFVOmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:42:36 -0400
Received: (qmail 16896 invoked from network); 22 Jun 2008 14:42:33 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES256-SHA encrypted SMTP; 22 Jun 2008 14:42:33 -0000
Content-Disposition: inline
In-Reply-To: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85779>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2008 at 04:51:52PM +0300, Erez Zilber wrote:
> Hi,
>=20
> I'm trying to config gitweb using v1.5.5.3. I'm able to see my
> repositories (through gitweb) but I see the following errors in
> /var/log/httpd/error_log. Can anyone help?
>=20
> [Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] (8)Exec format
> error: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:
> http://kites/cgi-bin/gitweb/gitweb.cgi

If cgi-bin is configured as ScriptAlias in Apache httpd server, then it
will try to execute every file inside that directory. You should move
them elsewere, or use a different directory altogether, with ExecCGI
permissions.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkheZOAACgkQinSul6a7oB9P3QCgn7uUXO9LiysHHxw1t8AvLVVv
PoMAn23SebpZKl3hWRW2JNJ+x4x9ovQa
=Dkjg
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
