From: Stephen Rothwell <git@ozlabs.org>
Subject: Re: [PATCH] Remove useless uses of cat, and replace with filename
 arguments or redirection
Date: Wed, 6 Jun 2007 13:39:15 +1000
Message-ID: <20070606133915.d72e4afe.git@ozlabs.org>
References: <46660F43.4060402@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Jun_2007_13_39_15_+1000_v6ODMnL3hp7P=YcI"
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 05:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvmMt-0008F9-3s
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 05:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXFFDjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 23:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbXFFDjX
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 23:39:23 -0400
Received: from ozlabs.org ([203.10.76.45]:45313 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbXFFDjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 23:39:23 -0400
Received: from localhost (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E637EDDEFF;
	Wed,  6 Jun 2007 13:39:21 +1000 (EST)
In-Reply-To: <46660F43.4060402@freedesktop.org>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49239>

--Signature=_Wed__6_Jun_2007_13_39_15_+1000_v6ODMnL3hp7P=YcI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Jun 2007 18:34:59 -0700 Josh Triplett <josh@freedesktop.org> wro=
te:
>
> -commits=3D$(cat ../revs | wc -l | tr -d " ")
> +commits=3D$(wc -l ../revs | tr -d " ")

This is not equivalent, you probably wanted:

commits=3D$(wc -l <../revs | tr -d " ")

Cheers,
Stephen Rothwell

--Signature=_Wed__6_Jun_2007_13_39_15_+1000_v6ODMnL3hp7P=YcI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZixnFdBgD/zoJvwRAjqoAJ9VbbsZGpxuYyJwlMb/3hAQ3Ue+xgCgkNUu
QxGIXtezWz54ba9gwkb9ReU=
=JJRQ
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Jun_2007_13_39_15_+1000_v6ODMnL3hp7P=YcI--
