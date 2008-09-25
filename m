From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add OS X support to the pre-auto-gc example hook
Date: Fri, 26 Sep 2008 01:20:08 +0200
Message-ID: <20080925232008.GO23137@genesis.frugalware.org>
References: <1222209803-4401-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Cc: git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Fri Sep 26 01:21:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj09B-0007i6-Gc
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 01:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbYIYXUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 19:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbYIYXUL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 19:20:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59880 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbYIYXUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 19:20:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 596191B24FC;
	Fri, 26 Sep 2008 01:20:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EC7B34465E;
	Fri, 26 Sep 2008 01:20:11 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 18C2E11901A1; Fri, 26 Sep 2008 01:20:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222209803-4401-1-git-send-email-jon.delStrother@bestbefore.tv>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96817>


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2008 at 11:43:23PM +0100, Jonathan del Strother <jon.delStr=
other@bestbefore.tv> wrote:
> Shell scripting isn't my fort=C3=A9, suggestions for improvements would be
> welcome.
>=20
> +elif test -x /usr/bin/pmset && (! /usr/bin/pmset -g batt | grep -q 'Batt=
ery Power' )

What about

+elif test -x /usr/bin/pmset && /usr/bin/pmset -g batt | grep -q 'AC Power'

?

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjcHKgACgkQe81tAgORUJaGtgCgmBP2owh6ocTHU7EZ2lQskaRM
jQ4An1aGR61alpVSts0cheGF3WZGrGeJ
=yMrY
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
