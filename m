From: Daniel Hulme <st@istic.org>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 17:55:19 +0100
Message-ID: <20070817165519.GA28614@istic.org>
References: <20070817163034.GA11151@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 19:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5Ql-0004e8-Rn
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXHQRQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXHQRQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:16:09 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:42481 "EHLO mail3.uklinux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512AbXHQRQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:16:08 -0400
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2007 13:16:07 EDT
Received: from presteign (cpc2-cmbg3-0-0-cust106.cmbg.cable.ntl.com [86.7.28.107])
	by mail3.uklinux.net (Postfix) with ESMTP id 943BA40A0C4
	for <git@vger.kernel.org>; Fri, 17 Aug 2007 16:55:23 +0000 (UTC)
Received: from z1 by presteign with local (Exim 4.67)
	(envelope-from <st@istic.org>)
	id 1IM56V-0007Wa-Ok
	for git@vger.kernel.org; Fri, 17 Aug 2007 17:55:19 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070817163034.GA11151@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56069>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2007 at 06:30:34PM +0200, Mike Hommey wrote:
> Hi,
>=20
> The git-commit-tree man page reads:
>   A commit encapsulates:
>=20
>   =B7   all parent object ids
>=20
>   =B7   author name, email and date
>=20
>   =B7   committer name and email and the commit time.
>   If not provided, "git-commit-tree" uses your name, hostname and domain =
to
>   provide author and committer info. This can be overridden by either
>   .git/config file, or using the following environment variables.
>   (...)
>=20
> The "If not provided" part doesn't make sense. If you're not setting the
> author and committer in your config or environment, how are you supposed
> to provide it ?
Makes sense to me. I interpreted it as:

  If not provided (by one of the ways I'm about to mention), the default
  is ... This default can be overridden by ...

I can understand how it might be read differently, though. Assuming my
reading is correct, might something along these lines be clearer:

  To find author and committer info, "git-commit-tree" first looks at
  these environment variables:

  ...

  If they are not set, it tries the keys user.name and user.email from
  the .git/config file. Finally, it falls back to using your name,
  hostname, and domain.

Even clearer, though this might be a bit extreme, would be to not
mention .git/config and say it reads the global or repository-specific
keys using git-config.

--=20
"I like talking to Rabbit.  He talks  about sensible things.  He doesn't
use long,  difficult words,  like Owl.  He uses short,  easy words, like
'What about  lunch?' and  'Help yourself,  Pooh.'  I suppose,  really, I
ought to go and see Rabbit."     A. A. Milne, 'The House at Pooh Corner'

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxdL3goQ42ohbFw0RAu39AJkBS9WZJQyTCGdRjdHRM6diVK3mpwCcDAB0
jZMLMb3Tph/NjvJq4XcP7ug=
=2oN6
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
