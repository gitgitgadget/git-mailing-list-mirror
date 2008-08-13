From: Kristis Makris <kristis.makris-tTJs1oqo2yY@public.gmane.org>
Subject: Re: Git and Scmbug integration
Date: Wed, 13 Aug 2008 02:23:05 -0700
Message-ID: <1218619385.4058.0.camel@localhost>
References: <1194980792.4106.6.camel@localhost>
	<ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	<1194998142.4106.24.camel@localhost>
	<ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
	<1194999404.4106.40.camel@localhost>
	<7vtznppr8m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_morpheus-13102-1218994671-0001-2"
Cc: David Symonds <dsymonds-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org,
  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org Sun Aug 17 20:09:09 2008
Return-path: <scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
Envelope-to: gcbsu-scmbug-users@m.gmane.org
Received: from net.mkgnu.net ([67.40.69.52] helo=mail.mkgnu.net)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUmgc-0004hQ-U1
	for gcbsu-scmbug-users@m.gmane.org; Sun, 17 Aug 2008 20:09:09 +0200
Received: from [192.168.0.100] (localhost [::ffff:127.0.0.1])
  by morpheus with esmtp; Sun, 17 Aug 2008 10:37:51 -0700
  id 00027B4D.48A861EF.0000332E
Received: from demokritos5.cytanet.com.cy (demokritos5.cytanet.com.cy
	[::ffff:195.14.130.179])
	by morpheus with esmtp; Sun, 17 Aug 2008 10:37:45 -0700
	id 000092D6.48A861EA.00003327
X-Virus-Scanned: By virus scanner at Cytanet
Received: from [192.168.1.4] (83-0-09.netrunf.cytanet.com.cy [83.168.0.9])
	by demokritos5.cytanet.com.cy (Postfix) with ESMTP id B12EA187C99;
	Sun, 17 Aug 2008 21:06:18 +0300 (EEST)
In-Reply-To: <7vtznppr8m.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
X-Mailer: Evolution 2.6.3 
X-BeenThere: scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: General Scmbug list <scmbug-users.lists.mkgnu.net>
List-Unsubscribe: <http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users>, 
	<mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.mkgnu.net/pipermail/scmbug-users>
List-Post: <mailto:scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
List-Help: <mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users>, 
	<mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=subscribe>
Sender: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
Errors-To: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92618>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-13102-1218994671-0001-2
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_morpheus-13102-1218994671-0001-3"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-13102-1218994671-0001-3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-11-13 at 17:09 -0800, Junio C Hamano wrote:
> Kristis Makris <kristis.makris-tTJs1oqo2yY@public.gmane.org> writes:
>=20
> > I just tried again tagging with both:
> >
> > $ git tag TAG_NAME
> >
> > $ git tag -a TAG_NAME
> >
> > and I don't get the post-commit hook executed.
> >
> > Perhaps I missed something ?
>=20
> You didn't.  You did not create any commit.  No post-commit hook
> runs.  There is no post-tag hook.
>=20
> > Can the new commit SHA-1 hash be added as a parameter to the post-commi=
t
> > hook please ?
>=20
> Looking at "git-rev-parse HEAD" in your hook should be enough.

But ... which hook ? There is not post-tag hook!!=20

--=_morpheus-13102-1218994671-0001-3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIoqf5/KuTDwnYLxERAtgwAJsEoeD2hKyue5W9aowPpy20/DbwawCeMBZW
BsuvZaYwjuaYYBR17j2oyNM=
=nIS/
-----END PGP SIGNATURE-----

--=_morpheus-13102-1218994671-0001-3--

--=_morpheus-13102-1218994671-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
scmbug-users mailing list
scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users

--=_morpheus-13102-1218994671-0001-2--
