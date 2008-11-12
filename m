From: Michael Adam <obnox@samba.org>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: send individual mails to recipients
Date: Wed, 12 Nov 2008 18:58:07 +0100
Organization: SerNet GmbH, Goettingen, Germany
Message-ID: <E1L0Jyh-00Bzdi-7r@intern.SerNet.DE>
References: <E1L0ITB-00Bv9t-72@intern.SerNet.DE> <7vfxlwq1gn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRrlDaCa9Eh922E4"
Cc: Michael Adam <obnox@samba.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K00-0001qB-Te
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYKLR6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbYKLR6K
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:58:10 -0500
Received: from mail1.SerNet.de ([193.175.80.2]:45276 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbYKLR6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:58:10 -0500
Received: from intern.SerNet.DE by mail.SerNet.DE
	with esmtp (Exim 4.63 #1)
	id 1L0Jyh-0005bG-Lu; Wed, 12 Nov 2008 18:58:07 +0100
Received: by intern.SerNet.DE
	id 1L0Jyh-00Bzdi-7r; Wed, 12 Nov 2008 18:58:07 +0100
Received: from intern.SerNet.DE (localhost [127.0.0.1])
	by localhost (AvMailGate-2.1.4-7) id 2858544-cFrZwb;
	Wed, 12 Nov 2008 18:58:07 +0100 (CET)
Received: by intern.SerNet.DE
	id 1L0Jyh-00BzdV-0n; Wed, 12 Nov 2008 18:58:07 +0100
Content-Disposition: inline
In-Reply-To: <7vfxlwq1gn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100786>


--jRrlDaCa9Eh922E4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Michael Adam <obnox@samba.org> writes:
>=20
> > This changes the behaviour of post-receive-email when a list of recipie=
nts
> > (separated by commas) is specified as hooks.mailinglist. With this modi=
fication,
> > an individual mail is sent out for each recipient entry in the list, in=
stead
> > of sending a single mail with all the recipients in the "To: " field.
>=20
> Why can that be an improvement?

My use case is that I have a repository where I want to send
commit messages to an "official" mailing list and to a private
recipient list that might not want to be seen on the official
mailing list.

If this is not generally useful, I could make it optional or
add s/th like a secondary mailing list argument to hooks.

Cheers - Michael


--jRrlDaCa9Eh922E4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: comment

iD8DBQFJGxkuyU9JOBhPkDQRAiL6AJ47L4ocTvubqsI7/ly/vGOWrO/d1gCdFtTt
Nta34ly3cyg2r8VjUHJfuvA=
=v6uO
-----END PGP SIGNATURE-----

--jRrlDaCa9Eh922E4--
