From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Thu, 21 Aug 2008 00:42:29 +0200
Message-ID: <20080820224229.GO23800@genesis.frugalware.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org> <20080819125429.GD17582@genesis.frugalware.org> <7vabf83j9u.fsf@gitster.siamese.dyndns.org> <20080819205917.GJ23800@genesis.frugalware.org> <7v3al0zmv8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVwOt-00049j-CD
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbYHTWmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbYHTWmb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:42:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40393 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754387AbYHTWma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:42:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A36811B24F0;
	Thu, 21 Aug 2008 00:42:29 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 503274465E;
	Wed, 20 Aug 2008 23:45:47 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 84BD31770019; Thu, 21 Aug 2008 00:42:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3al0zmv8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93069>


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2008 at 03:00:27PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Not exactly. builtin-merge-recursive uses get_ref() - which should not
> > be in merge-recursive.c IMHO - and get_ref() uses make_virtual_commit().
> > merge_recursive() itself takes commits, so it can be only static if we
> > copy it builtin-merge-recursive as well, causing a code duplication. Or
> > have I missed something here?
>=20
> I think you have.
>=20
> Let's look at the call chain from cmd_merge_recursive() and think again.

Thanks for the detailed answer. I just wanted to say that probably I
won't have time to implement this before the weekend; but I plan to do
so then.

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkisndUACgkQe81tAgORUJZclQCdF02OeR/cr+G+85Zvjp1OP6kg
mGEAn1uC8axnNLwxb1jXyF8kIm2R9Lyl
=UPo1
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
