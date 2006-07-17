From: Martin Waitz <tali@admingilde.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 20:15:28 +0200
Message-ID: <20060717181528.GA30212@admingilde.org>
References: <87k66p8jee.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de> <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com> <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org> <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607171055230.15611@evo.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 20:18:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Xd2-000675-Gd
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 20:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWGQSPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 14:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWGQSPd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 14:15:33 -0400
Received: from admingilde.org ([213.95.32.146]:38835 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751110AbWGQSPd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 14:15:33 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G2Xcu-0004ls-PB; Mon, 17 Jul 2006 20:15:28 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607171055230.15611@evo.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23979>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Jul 17, 2006 at 10:56:04AM -0700, Linus Torvalds wrote:
> Imagine having a "map_packfile()" interface, and letting different target=
s=20
> just implement their own version. That doesn't sound too bad, does it?

we'd need something like that anyway if we want to support larger
pack files.
When it is only possible to map a part of the file into memory at a
given time then we have to special case all accesses to the pack file,
too.  Or is there an easier way?

--=20
Martin Waitz

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEu9PAj/Eaxd/oD7IRAojVAJ9IqXF4ZjenMF9KehHN/UawExMsCwCdFblG
4iFKhGynX7bdRtbiHdhJHQI=
=sdrP
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
