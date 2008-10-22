From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: stackprotector tree build failure
Date: Wed, 22 Oct 2008 19:31:13 +1100
Message-ID: <20081022193113.20369b63.sfr@canb.auug.org.au>
References: <20081022131124.a572b11f.sfr@canb.auug.org.au>
	<20081022043227.GA31413@elte.hu>
	<20081022182149.f89fe88d.sfr@canb.auug.org.au>
	<20081022072923.GC27637@elte.hu>
	<20081022192725.5f5de711.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__22_Oct_2008_19_31_13_+1100_qRdyS5fFH.BClgg."
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-next@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-next-owner@vger.kernel.org Wed Oct 22 10:32:49 2008
connect(): Connection refused
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZ94-0004ys-H3
	for glkn-linux-next@gmane.org; Wed, 22 Oct 2008 10:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYJVIbi (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Wed, 22 Oct 2008 04:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYJVIbi
	(ORCPT <rfc822;linux-next-outgoing>);
	Wed, 22 Oct 2008 04:31:38 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:48622 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbYJVIbh (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Wed, 22 Oct 2008 04:31:37 -0400
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 1CBB8368006;
	Wed, 22 Oct 2008 19:31:34 +1100 (EST)
In-Reply-To: <20081022192725.5f5de711.sfr@canb.auug.org.au>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98842>

--Signature=_Wed__22_Oct_2008_19_31_13_+1100_qRdyS5fFH.BClgg.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2008 19:27:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I think rerere matches preimages on the SHA1 of the conflict (or its
> reverse), so sufficiently similar pieces of code will match.  I would
> expect things like ext2/3/4 to be candidates.  Did the traps_32.c one
> match one for traps_64.c?

Or, of course similar conflicts in different merges in different branches
of the same tree are really asking for it ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Oct_2008_19_31_13_+1100_qRdyS5fFH.BClgg.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj+5NEACgkQjjKRsyhoI8xDIwCgvnY69BAbEXGhG2d1xSSucB0G
E9kAoLtLZk0boQE5oH3UZRR2QMNEDHty
=RwGG
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Oct_2008_19_31_13_+1100_qRdyS5fFH.BClgg.--
