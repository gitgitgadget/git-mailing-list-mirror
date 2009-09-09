From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: Problem with "dashless options"
Date: Thu, 10 Sep 2009 00:49:30 +0200
Message-ID: <20090909224930.GC29776@artemis.corp>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
 <20090909143455.GA10092@sigill.intra.peff.net>
 <AB9C50E3-E2BB-4449-B8F9-75777ADE1602@isy.liu.se>
 <20090909163001.GE4859@laphroaig.corp>
 <4EEF55B5-46E1-4C06-AA60-62F700F7B279@isy.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Henrik Tidefelt <tidefelt@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu Sep 10 00:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlVzY-0002K8-OE
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 00:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbZIIWta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 18:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZIIWta
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 18:49:30 -0400
Received: from pan.madism.org ([88.191.52.104]:37230 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbZIIWt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 18:49:29 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 90DB14711E;
	Thu, 10 Sep 2009 00:49:31 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8517F777049; Thu, 10 Sep 2009 00:49:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4EEF55B5-46E1-4C06-AA60-62F700F7B279@isy.liu.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128089>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2009 at 11:12:12PM +0200, Henrik Tidefelt wrote:
> No, but it is mapped to WHITE FROWNING FACE; I guess I defined it so
> to avoid the trouble I was previously experiencing from accidentally
> typing the &nbsp; instead of space without being able to see the
> difference on screen.  Why would it matter?

well because then one of your space could have been that, and the shell
doesn't consider non breakable space as .. breakable, hence you can read
something where you believe there is (n+1) arguments but the shell (and
git) see only n.

It often yields errors really hard to grasp like the dreaded:

$ ls |=C2=A0grep
zsh: command not found: =C2=A0grep
notice the              ^

sorry then I don't really know what happened...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqoMPoACgkQvGr7W6Hudhwh4wCeLmvVBzdimgphHzmf229ebYL9
n20AoIskR1wlCWXhO8XRQ6ZA8C6UYAgk
=IEAf
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
