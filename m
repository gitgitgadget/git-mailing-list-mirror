From: Kristis Makris <kristis.makris-tTJs1oqo2yY@public.gmane.org>
Subject: Git and Scmbug integration
Date: Tue, 13 Nov 2007 12:06:32 -0700
Message-ID: <1194980792.4106.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_morpheus-24161-1194980829-0001-2"
Cc: scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org Tue Nov 13 20:07:38 2007
Return-path: <scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
Envelope-to: gcbsu-scmbug-users@m.gmane.org
Received: from net.mkgnu.net ([67.40.69.52] helo=mail.mkgnu.net)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is16g-0003mF-Tu
	for gcbsu-scmbug-users@m.gmane.org; Tue, 13 Nov 2007 20:07:32 +0100
Received: from [192.168.0.100] (localhost [::ffff:127.0.0.1])
  by morpheus with esmtp; Tue, 13 Nov 2007 12:07:09 -0700
  id 0001207F.4739F5DD.00005E61
Received: from syd-mkgnu-net.dhcp.asu.edu (syd-mkgnu-net.dhcp.asu.edu
	[::ffff:149.169.179.39]) (AUTH: LOGIN mkgnu-DO7gHyv135BeoWH0uzbU5w@public.gmane.org)
	by morpheus with esmtp; Tue, 13 Nov 2007 12:07:04 -0700
	id 00011EFA.4739F5D8.00005E57
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64828>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-24161-1194980829-0001-2
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_morpheus-24161-1194980829-0001-3"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-24161-1194980829-0001-3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I've been working on adding Git support in Scmbug, a system that
integrates software configuration management with bug-tracking. I've run
across what seem to be limitations in the Git hooks mechanism (at least
in version 1.5.1.3). In particular:


(1)

http://bugzilla.mkgnu.net/show_bug.cgi?id=3D991

There's no hook that will trigger when a tag is applied.


(2)

http://bugzilla.mkgnu.net/show_bug.cgi?id=3D992

Git does not offer metadata describing a change on the commit trigger

The commit trigger seems to be "post-commit" but it supplies no arguments. =
The
"update" trigger supplies a lot of information but that's only triggered wh=
en
changes are published to a remote repository.


I could not find a way to extract this information from what I've read in:

http://www.kernel.org/pub/software/scm/git/docs/hooks.html


Are there plans to implement these hooks ? Or, could someone help me
understand how to extract such information ?=20


Thanks,
Kristis

--=_morpheus-24161-1194980829-0001-3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBHOfW3/KuTDwnYLxERAtPeAJ9oZnByy0pw71ZUbTw9dcRX2CeWIgCWIklO
HDZ+dvmm3rF/TjHwGPEkxQ==
=rTl+
-----END PGP SIGNATURE-----

--=_morpheus-24161-1194980829-0001-3--

--=_morpheus-24161-1194980829-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
scmbug-users mailing list
scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users

--=_morpheus-24161-1194980829-0001-2--
