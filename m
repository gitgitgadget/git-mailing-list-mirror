From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Sat, 17 Nov 2007 20:12:56 +0100
Message-ID: <20071117191256.GD5198@efreet.light.src>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de> <200711131842.03622.jnareb@gmail.com> <87d4ue81tv.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: osv@javad.com
X-From: git-owner@vger.kernel.org Sat Nov 17 20:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItT6f-0005Zk-5j
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758975AbXKQTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758857AbXKQTNJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:13:09 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:51973 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756107AbXKQTNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:13:08 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C3E275740A;
	Sat, 17 Nov 2007 20:13:06 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id v4GBGNeTTIYc; Sat, 17 Nov 2007 20:13:04 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 203FA57405;
	Sat, 17 Nov 2007 20:13:02 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItT68-0000Vp-SG; Sat, 17 Nov 2007 20:12:56 +0100
Content-Disposition: inline
In-Reply-To: <87d4ue81tv.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65295>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2007 at 20:58:20 +0300, osv@javad.com wrote:
> Guys, could you please read man git-branch? What do you think this
> example is doing?:
>=20
> <quote Documentation/git-branch.txt>
> Delete unneeded branch::
> +
> ------------
> $ git clone git://git.kernel.org/.../git.git my.git
> $ cd my.git
> $ git branch -d -r origin/todo origin/html origin/man   <1>
> $ git branch -D test                                    <2>
> ------------
> +
> <1> Delete remote-tracking branches "todo", "html", "man"
> </quote>
>=20
> That's *exactly* what I did! And it *doesn't work*! Well, it does delete
> the branches, but they are automagically re-created on the next fetch,
> so "deleting" them this way is useless.

Of course it *does* work. It *deletes* the branches. There is not a single
word about stopping fetch getting them!

Obviously given that the example is slightly contrived, it should really
be mentioned that it does not affect fetch at all.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPz04Rel1vVwhjGURAnOOAJsFhCWmDBP3Xma0vt3rCLKNiHR6kgCgppqZ
YUy4J3Tt//OuuF0U1yPaETU=
=6Bn6
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
