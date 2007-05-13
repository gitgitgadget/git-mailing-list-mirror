From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Allow fetching references from any namespace
Date: Sun, 13 May 2007 09:24:09 +0200
Message-ID: <20070513072409.GD8983@efreet.light.src>
References: <20070511203522.GA2741@steel.home> <7vlkfv9j3c.fsf@assigned-by-dhcp.cox.net> <20070512074049.GA2410@steel.home> <7vveey4gt0.fsf@assigned-by-dhcp.cox.net> <e5bfff550705122048s6772db3as63f6fb23fe7e1bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 09:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn8RX-0007R1-BR
	for gcvg-git@gmane.org; Sun, 13 May 2007 09:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023AbXEMHYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757258AbXEMHYZ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 03:24:25 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2943 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757023AbXEMHYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 03:24:24 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.199354;
	Sun, 13 May 2007 09:24:09 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hn8R7-0004Jd-Fr; Sun, 13 May 2007 09:24:09 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550705122048s6772db3as63f6fb23fe7e1bd7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47125>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 13, 2007 at 05:48:00 +0200, Marco Costalba wrote:
> On 5/12/07, Junio C Hamano <junkio@cox.net> wrote:
> >
> >Sounds like it is not even a regression but just was not
> >supposed to work from the beginning.
> >
> >Not that I think lifting that restriction is a bad idea,
> >though.
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe git" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> Please consider that StGIT put patch names under refs/patches and
> probably we don't want to see them.

If you don't add them to the push configuration, you won't see them.

> I'm very sorry but I cannot test my-self because I'm leaving now. I
> have just seen the patch applied in git tree and this thing come to my
> mind.

It does not make them pushed. It just allows pushing them--which is good
thing sometimes (eg. if you use push to backup the repo).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRr0ZRel1vVwhjGURAoRRAKCnXWmU7JYfsms6sKVhzxTNnyOXWACguh+b
F4fKlu0yaRSqeF//HA296/o=
=VXXy
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
