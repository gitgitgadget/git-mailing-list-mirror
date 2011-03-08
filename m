From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Who created a branch - reflog
Date: Tue, 8 Mar 2011 16:11:07 +0100
Message-ID: <20110308151107.GW3609@genesis.frugalware.org>
References: <20110308143846.GV3609@genesis.frugalware.org>
 <AANLkTimsz7OPfUF5j=xY6ro4uX4AQty+PzW-tG6TQbuW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dBMBt2YGaTHbdllf"
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 16:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwyZA-00028f-9w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 16:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab1CHPLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 10:11:11 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35686 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab1CHPLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 10:11:09 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EC876580B2;
	Tue,  8 Mar 2011 16:11:07 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DD93A44965;
	Tue,  8 Mar 2011 16:11:07 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CE0A91358449; Tue,  8 Mar 2011 16:11:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTimsz7OPfUF5j=xY6ro4uX4AQty+PzW-tG6TQbuW@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168666>


--dBMBt2YGaTHbdllf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2011 at 06:57:38AM -0800, Shawn Pearce <spearce@spearce.org=
> wrote:
> reflog identity entries are derived from GIT_COMMITTER_NAME and
> GIT_COMMITTER_EMAIL in the environment at the time that the log event
> takes place. If these aren't set, they are derived from the current
> user's gecos, or from $GIT_DIR/config or ~/.gitconfig as the
> user.name/user.email variables.
>=20
> Perhaps over SSH one of these is triggering for a user, allowing the
> user to fill in their own identity... or someone else's. If you want
> to enforce an identity you should set these environment variables on
> the SSH server side before invoking git-receive-pack, perhaps by way
> of a forced SSH command the way gitosis or gitolite is installed.

Then once I'm sure the users can't alter their identity on the server,
the same can be achieved using ssh as with http.

Great, that's exactly what I was needed. :)

Thanks!

--dBMBt2YGaTHbdllf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk12RwsACgkQe81tAgORUJZfcQCeMNUfR8FkVxUrhOJfY5zYsJ8r
lnEAoIsBqMMhw7Ak0/EtFYacON2P33dd
=OzEa
-----END PGP SIGNATURE-----

--dBMBt2YGaTHbdllf--
