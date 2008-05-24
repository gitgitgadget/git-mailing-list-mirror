From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/5] Move reset_index_file() to a new reset.c
Date: Sat, 24 May 2008 23:55:30 +0200
Message-ID: <20080524215530.GA27724@genesis.frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org> <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org> <alpine.LNX.1.00.0805240016230.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TugNW38Ug5HSYOfG"
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 24 23:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K01j0-0000aC-Jh
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 23:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbYEXVzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 17:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761330AbYEXVzf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 17:55:35 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38397 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbYEXVzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 17:55:35 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7B93D1B253C;
	Sat, 24 May 2008 23:55:33 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5BB8A4465E;
	Sat, 24 May 2008 23:41:04 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0748F1778001; Sat, 24 May 2008 23:55:30 +0200 (CEST)
Mail-Followup-To: Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0805240016230.19665@iabervon.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82833>


--TugNW38Ug5HSYOfG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2008 at 12:21:42AM -0400, Daniel Barkalow <barkalow@iabervo=
n.org> wrote:
> You might as well use unpack_trees() directly here, instead of running a=
=20
> separate command. In fact, you might skip making a function here, and jus=
t=20
> call unpack_trees() where you'd use it. (And maybe have a function to=20
> initialize a struct unpack_tree_options to some common defaults to make i=
t=20
> easy to see what's being done.)

Thanks for the suggestion, I did so; as a result now patch #1 and #3 are
no longer necessary.

(I haven't sent out a new series yet, but it's in
git://repo.or.cz/git/vmiklos.git builtin-merge.)

Maybe builtin-reset could use unpack_trees() directly as well? I don't
know if it's just a question of "nobody did it yet", or there is some
reason for not using unpack_trees() there.

--TugNW38Ug5HSYOfG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg4jtIACgkQe81tAgORUJYnqwCfWJQDT5Xj7aWLSLzjOf12WQxs
WyIAn2lszvXQEGZWOECVH9w02vbvxtJ6
=Vnd9
-----END PGP SIGNATURE-----

--TugNW38Ug5HSYOfG--
