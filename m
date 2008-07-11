From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 20:14:13 +0200
Message-ID: <20080711181413.GI10347@genesis.frugalware.org>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com> <20080711161923.GE10347@genesis.frugalware.org> <fa7d16350807111107o40c5cbb5xc06c3c56b16b7499@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wn0J+vu9+NMIXK57"
Cc: git@vger.kernel.org
To: ff <ff@member.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHN9H-0001ed-IF
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYGKSOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbYGKSOQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:14:16 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50473 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYGKSOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:14:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 430C11B24FA;
	Fri, 11 Jul 2008 20:14:14 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2024B4465E;
	Fri, 11 Jul 2008 19:39:36 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7FDF1177001C; Fri, 11 Jul 2008 20:14:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa7d16350807111107o40c5cbb5xc06c3c56b16b7499@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88148>


--Wn0J+vu9+NMIXK57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ Did you reply off-list intentionally? ]

On Fri, Jul 11, 2008 at 02:07:44PM -0400, ff <ff@member.org> wrote:
> thank you.
>=20
> I did see the -m option in the revert man page. It talks about
> "parent" and I did
> not understand what that is. Is parent the commit id of the merge commit?
>=20
> Thanks again!

http://www.kernel.org/pub/software/scm/git/docs/gitglossary.html#def_parent

A merge commit has two parents, but obviously only one of the was the
HEAD commit before the merge. So when you revert a merge, you need to
specify which which parent's tree should be the tree of the new HEAD.

For example, if you were on branch 'master' and you merged 'foo' to
master using 'git merge foo', and you want to revert that merge then you
need '-m 1'.

--Wn0J+vu9+NMIXK57
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3ovUACgkQe81tAgORUJaPHACfUYR+9oZCPfBVu+APITl29RJs
CMkAoKGbBLaMhe6NTudbfuYQmD9ZDjFa
=MW79
-----END PGP SIGNATURE-----

--Wn0J+vu9+NMIXK57--
