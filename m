From: Martin Waitz <tali@admingilde.org>
Subject: Re: Errors cloning large repo
Date: Sun, 11 Mar 2007 22:35:24 +0100
Message-ID: <20070311213523.GB20726@admingilde.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org> <Pine.LNX.4.64.0703092145550.10832@woody.linux-foundation.org> <20070310060144.GA3223@spearce.org> <20070310223251.GA20726@admingilde.org> <Pine.LNX.4.64.0703101443411.10330@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anton Tropashko <atropashko@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:35:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVhS-0001zj-4R
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbXCKVf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbXCKVf1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:35:27 -0400
Received: from mail.admingilde.org ([213.95.32.147]:56851 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687AbXCKVf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:35:26 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HQVhM-00036T-2A; Sun, 11 Mar 2007 22:35:24 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703101443411.10330@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41987>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Mar 10, 2007 at 02:46:35PM -0800, Linus Torvalds wrote:
> Are you sure you're not just running a 64-bit process?

pretty sure, yes :-)

> 64-bit processes don't need O_LARGEFILE to process files larger than 2GB,=
=20
> since for them, off_t is already 64-bit.

but O_LARGEFILE is a Linux-only thing, right?

> Oh, except we have that=20
>=20
> 	#define _FILE_OFFSET_BITS 64
>=20
> which is just a horrible hack. That's nasty. We should just use=20
> O_LARGEFILE rather than depend on some internal glibc thing that works=20
> nowhere else.

Well, if I remember correctly the *BSD systems always use 64bit now,
its sad that glibc does not do the same out of the box for Linux.
_FILE_OFFSET_BITS is the documented way to get 64bit file sizes on
glibc, so I think it is the right thing for us (even when that define
is really ugly).

--=20
Martin Waitz

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF9HYbj/Eaxd/oD7IRApC8AJ4y40rnRf+6RvPF6lQeBYVVlDT4qgCfZnNZ
xu/ovgbtlqmcS22xscSRL8A=
=JADW
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
