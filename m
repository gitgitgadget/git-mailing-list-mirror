From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Build in merge
Date: Tue, 8 Jul 2008 03:41:09 +0200
Message-ID: <20080708014109.GC10347@genesis.frugalware.org>
References: <7vhcb14l3m.fsf@gitster.siamese.dyndns.org> <1215474140-11220-1-git-send-email-vmiklos@frugalware.org> <7v63rhz03x.fsf@gitster.siamese.dyndns.org> <20080708010007.GA10347@genesis.frugalware.org> <7vskulxk0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG2De-0000iJ-7W
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbYGHBlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbYGHBlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:41:16 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38601 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754675AbYGHBlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:41:16 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 675861B24F0;
	Tue,  8 Jul 2008 03:41:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EFA6044699;
	Tue,  8 Jul 2008 03:08:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EA72C11901B3; Tue,  8 Jul 2008 03:41:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vskulxk0o.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87684>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2008 at 06:05:43PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > 1) A project has code in a repo, some documentation and po files.
> >
> > The first two can be merged with builtin strategies, the later probably
> > needs a custom merge driver.
>=20
> Per-path merge is probably better handled with custom ll-merge driver
> anyway.  See gitattributes(5).

Ah, thanks. I did not know ll-merge supports custom drivers as well.

> It wasn't *me* ;-) who wanted to add these "flags".
>=20
> I think it does not matter what "my-strategy" does unless "-s my-strategy"
> (or pull.twohead) is explicitly given by the user, and at that time,
> DEFAULT_* options should not matter.  It probably is Ok to allow fast
> forward and trivial merges to them.  We'll see.

OK, so at first round I think we could avoid flags for custom
strategies.

For the error message, I think the output could be something like git
help --all, which splits commands based on being in
GIT_EXEC_PATH or somewhere else in PATH.

Also, currently (the shell version and the C one as well) we silently
ignore the config setting if it's set to semething invalid. What about
changing that to a similar error message as well?

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyxbUACgkQe81tAgORUJa4kACffXCACb7e4v8gi2RSSxR7Ml5u
BtQAn0L4I9Q/vsCuHrASbJv56XnetYkl
=kY98
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
