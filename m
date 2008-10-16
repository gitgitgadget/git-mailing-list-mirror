From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 23:00:02 +0200
Message-ID: <20081016210002.GJ536@genesis.frugalware.org>
References: <48F730D0.9040008@calicojack.co.uk> <20081016135908.GI536@genesis.frugalware.org> <48F7542B.1050909@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pssgfZQbIK00CPi6"
Cc: git@vger.kernel.org
To: Rick Moynihan <rick@calicojack.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZyF-00042c-92
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 23:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbYJPVAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbYJPVAG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 17:00:06 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51802 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071AbYJPVAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 17:00:05 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 74AD1580C8;
	Thu, 16 Oct 2008 23:00:03 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5F9D74465E;
	Thu, 16 Oct 2008 23:00:03 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F013D11901A1; Thu, 16 Oct 2008 23:00:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F7542B.1050909@calicojack.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98426>


--pssgfZQbIK00CPi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2008 at 03:48:11PM +0100, Rick Moynihan <rick@calicojack.co=
=2Euk> wrote:
> Yes, but my understanding is that it's only harmful if you publish the=20
> branch (or dependent branches) which are being rebased.
>=20
> So rebasing is very bad in these circumstances, but I fail to see why it'=
s=20
> bad if these branches are kept private.

Ah, I thought you publish your branches.

One reason may be that if you use merge, no history is lost, if you use
rebase, history is in the reflogs, so it'll be lost after some time. But
if you know what you are doing, then this is not a problem.

--pssgfZQbIK00CPi6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3q1IACgkQe81tAgORUJaWvwCeJMiPMQAv78e6hkcX4ryaCHCH
/jkAnRZ4WUaeyROVWhsZUK/AyLLjmvYp
=9vro
-----END PGP SIGNATURE-----

--pssgfZQbIK00CPi6--
