From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 18:34:11 +0200
Message-ID: <20080627163411.GA2058@genesis.frugalware.org>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org> <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org> <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org> <20080627161220.GB6201@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGuq-0000VA-UF
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbYF0QeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYF0QeQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:34:16 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36426 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361AbYF0QeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:34:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EF3A11B2514;
	Fri, 27 Jun 2008 18:34:13 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6398344697;
	Fri, 27 Jun 2008 18:07:32 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 53E841778012; Fri, 27 Jun 2008 18:34:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080627161220.GB6201@leksak.fem-net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86595>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 06:12:20PM +0200, Stephan Beyer <s-beyer@gmx.net> w=
rote:
> I wonder why the bugfix commit
>=20
> 	aec7e9cd	Don't append default merge message to -m message
>=20
> has disappeared or why/if this belongs to js/rebase-i-sequencer.

I think it its current form that is not a bugfix. The user may want to
prepend a custom message and may want to replace the original message
with a custom one, and I would not consider either of them as "buggy".

Funny enough, I just sent a patch:

http://thread.gmane.org/gmane.comp.version-control.git/86584/focus=3D86589

that tests the original behaviour. ;-)

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhlFoMACgkQe81tAgORUJaEuQCgoqpEMqeGbcxgsIq84UTz5x8b
SpkAn0r6VnEfb9U6wDJ2H8DJE1ldUXtq
=jeat
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
