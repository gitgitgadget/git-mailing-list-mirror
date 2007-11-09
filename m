From: CJ van den Berg <cj@vdbonline.com>
Subject: Re: [PATCH 07/11] git-fetch: Limit automated tag following to only
	fetched objects
Date: Fri, 9 Nov 2007 13:12:28 +0100
Message-ID: <20071109121228.GA4241@prefect.vdbonline.net>
References: <20071109110631.GG19368@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:17:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoLB-0007Pw-Px
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXKJLRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXKJLRP
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:17:15 -0500
Received: from marvin.vdbonline.net ([208.78.101.188]:50007 "EHLO
	marvin.vdbonline.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbXKJLRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 06:17:14 -0500
X-Greylist: delayed 1778 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2007 06:17:14 EST
Received: from prefect.vdbonline.net (p54A754C0.dip.t-dialin.net [84.167.84.192])
	by marvin.vdbonline.net (Postfix) with ESMTP id B0C0C6808F;
	Sat, 10 Nov 2007 11:47:35 +0100 (CET)
Received: by prefect.vdbonline.net (Postfix, from userid 1000)
	id C6BCE1A86A6; Fri,  9 Nov 2007 13:12:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071109110631.GG19368@spearce.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64332>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2007 at 06:06:31AM -0500, Shawn O. Pearce wrote:
> We now redefine the rule to be: "tags are fetched if they refer
> to an object that was just transferred; that is an object that is
> new to your repository".  This rule is quite simple to understand,
> you only get a tag if you just got the object it refers to.

With this new rule a retrospectively pushed tag will never be fetched,
right? With our local work flow tags are only ever pushed retrospectively
because the tagged commit has to first pass regression tests. So this would
be a major regression for us.

I think adding a temporal dependency between the pushing and fetching of
branches and tags in this way is likely to cause even more confusing and
apparently random behaviour.=20

--=20
CJ van den Berg

mailto:cj@vdbonline.com
  xmpp:cj@vdbonline.com

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHNE6sl3pZXfh0CHIRAh3jAKCVyEIgb4BD0GTEXpZDOa+Moj4H2gCdHP4M
9+MU0cP9hJE2IOpCD5nIKlI=
=6WD1
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
