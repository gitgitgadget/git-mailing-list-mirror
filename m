From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 19 Aug 2008 14:54:29 +0200
Message-ID: <20080819125429.GD17582@genesis.frugalware.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 14:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVQkO-0005sK-NA
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 14:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbYHSMyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 08:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYHSMyh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 08:54:37 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34482 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbYHSMyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 08:54:36 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6DCFC1B250C;
	Tue, 19 Aug 2008 14:54:30 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id F164A4465E;
	Tue, 19 Aug 2008 13:58:32 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F0E971770019; Tue, 19 Aug 2008 14:54:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92853>


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2008 at 02:05:42AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> [On Hold]
> (...)
> * mv/merge-recursive (Tue Aug 12 22:14:00 2008 +0200) 3 commits
>  - Make builtin-revert.c use merge_recursive_generic()
>  - merge-recursive.c: Add more generic merge_recursive_generic()
>  - Split out merge_recursive() to merge-recursive.c
>=20
> I do not think builtlin-revert should use "recursive", but these patches
> give a good starting point to separate the bulk of the "rename-aware
> three-way merge" into library form.

I wanted to send a patch that makes builtin-merge use the new
merge_recursive_setup(), but then I was not able to decide to use
merge_recursive_generic() or not.

What is your preference here? I just want to avoid a "this could be
merged, but it uses merge_recursive(), not merge_recursive_generic()" or
the opposite of this. :)

Thanks.

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiqwoUACgkQe81tAgORUJZueQCeIFoMfGz3/4QPiAe2JkIHETSL
QGEAn2xUxeBFXae+TcIMjSHsI8ASuKNf
=4E6C
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
