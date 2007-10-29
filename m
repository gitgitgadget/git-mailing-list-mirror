From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFH] gcc constant expression warning...
Date: Mon, 29 Oct 2007 13:41:35 +1100
Message-ID: <20071029134135.ed72fe78.sfr@canb.auug.org.au>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org>
	<slrnfi8pj7.mb4.antti-juhani@kukkaseppele.kaijanaho.fi>
	<alpine.LFD.0.999.0710281000260.30120@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0710282053590.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__29_Oct_2007_13_41_35_+1100_VAzhz8iZdc.MhfUd"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 03:42:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImKZl-00059j-9e
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 03:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXJ2Cls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 22:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbXJ2Cls
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 22:41:48 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:54934 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbXJ2Clr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 22:41:47 -0400
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id E6FC3368007;
	Mon, 29 Oct 2007 13:41:44 +1100 (EST)
In-Reply-To: <alpine.LFD.0.9999.0710282053590.22100@xanadu.home>
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62593>

--Signature=_Mon__29_Oct_2007_13_41_35_+1100_VAzhz8iZdc.MhfUd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Oct 2007 20:55:32 -0400 (EDT) Nicolas Pitre <nico@cam.org> wrote:
>
> The test must also make sure off_t isn't signed, since in that case it=20
> can only hold 31 bits.

Posix says:
	"blkcnt_t and off_t shall be signed integer types."
=20
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__29_Oct_2007_13_41_35_+1100_VAzhz8iZdc.MhfUd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJUhpTgG2atn1QN8RAoB+AJ0S4FiRVlERhU1lY8qyZ6yny6NTDwCeMfqR
rpXLJuLF/nf8S8aj3Kb0cHs=
=Pp/c
-----END PGP SIGNATURE-----

--Signature=_Mon__29_Oct_2007_13_41_35_+1100_VAzhz8iZdc.MhfUd--
