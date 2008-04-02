From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto (try2)
Date: Wed, 2 Apr 2008 21:02:40 +0200
Message-ID: <20080402190240.GV3264@genesis.frugalware.org>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org> <20080402011447.GO3264@genesis.frugalware.org> <7vwsngaoqg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JvUS8mwutKMHKosv"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8Fo-0004Lp-7T
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761349AbYDBTCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759967AbYDBTCr
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:02:47 -0400
Received: from virgo.iok.hu ([193.202.89.103]:24700 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761334AbYDBTCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:02:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 74C021B2511;
	Wed,  2 Apr 2008 21:02:43 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0E49A446AF;
	Wed,  2 Apr 2008 20:59:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A9CF41190A16; Wed,  2 Apr 2008 21:02:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsngaoqg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78702>


--JvUS8mwutKMHKosv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2008 at 09:02:15PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > So may I put it back? :)
>=20
> I agree that it makes sense to send the output to standard error for
> consistency.  Many existing hooks called from scripted versions of tools
> seem to contaminate the standard output, though.  That would be a good
> post 1.5.5 clean-up, perhaps.

Ok, I will put it back.

> > Also, is the other parts of the series looks correct?
>=20
> I do not think we would want empty templates/hooks--pre-gc-auto file.

I did it this way as we have such an empty post-commit hook as well, so
I added it for consistency. Though it's true that for example
post-applypatch doesn't have such an empty hook under templates either.

What is your opinion here?

Possibilities I see:

1) Just don't add such an empty template for pre-auto-gc.

2) Remove post-commit as well.

3) Add missing empty templates, like post-applypatch (maybe there are
more, I haven't did a complete research).

I've did the rest of the modifications locally as you suggested just I
don't want to spam the list with the series before the empty templates
question is not clear to me :)

Thanks

--JvUS8mwutKMHKosv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfz2FAACgkQe81tAgORUJZJlACfV4de3+SBXbBpxvjcMNZ0+uGJ
3s4AnRZcmsP6JCBMkdJp6AMj49l1yegG
=788X
-----END PGP SIGNATURE-----

--JvUS8mwutKMHKosv--
