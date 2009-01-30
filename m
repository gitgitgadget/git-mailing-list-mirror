From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across --continue
Date: Fri, 30 Jan 2009 23:43:34 +0100
Message-ID: <200901302343.39921.trast@student.ethz.ch>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org> <7veiyp4w2m.fsf@gitster.siamese.dyndns.org> <7vzlhd3fh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5322430.qOsMvynx4D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT27E-0006a5-SV
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbZA3WoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZA3Wn6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:43:58 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8397 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbZA3Wn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:43:56 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:43:51 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:43:51 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vzlhd3fh7.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 30 Jan 2009 22:43:51.0548 (UTC) FILETIME=[39094BC0:01C9832C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107878>

--nextPart5322430.qOsMvynx4D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Perhaps something like this.
> +	git rev-list --topo-order --parents --pretty=3D"tformat:%s" HEAD |
> +	git name-rev --stdin --name-only --refs=3Drefs/heads/conflict3 >out &&

Clever.  I'll follow up with cleanup patches for the rest of the
test.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart5322430.qOsMvynx4D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmDgpsACgkQqUud07tmzP2waQCglBX5xVICVZQ4klG6gRg02e0I
OwQAoJehNWNWfKepIA5SOVjCQrBYqXjz
=D72X
-----END PGP SIGNATURE-----

--nextPart5322430.qOsMvynx4D--
