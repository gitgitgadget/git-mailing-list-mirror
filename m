From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 20:53:32 +0200
Message-ID: <20080711185332.GJ10347@genesis.frugalware.org>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com> <20080711161923.GE10347@genesis.frugalware.org> <fa7d16350807111107o40c5cbb5xc06c3c56b16b7499@mail.gmail.com> <20080711181413.GI10347@genesis.frugalware.org> <fa7d16350807111146m18b0ca9q6902c2167bfd3512@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W18qbkTAGYos9/y6"
Cc: git@vger.kernel.org
To: ff <ff@member.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNlJ-0008Q0-Nc
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYGKSxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYGKSxe
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:53:34 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50593 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbYGKSxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:53:33 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 733331B24FA;
	Fri, 11 Jul 2008 20:53:32 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A55E64465E;
	Fri, 11 Jul 2008 20:18:54 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 53A4C177001C; Fri, 11 Jul 2008 20:53:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa7d16350807111146m18b0ca9q6902c2167bfd3512@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88158>


--W18qbkTAGYos9/y6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2008 at 02:46:15PM -0400, ff <ff@member.org> wrote:
> ooops... yes... I'm scared of the reply-all button. :)

Also please don't top-post, thanks. ;-)

> In your example, how and why you can determine that the number 1
> represents the "foo" branch? Would "-m 2" represent the master branch?
> In your example is there any other choice for the "-m" number to use?

If the merge has two parents, then the first one is the actual branch
and the second is the 'other' branch.

So if 'master' is checked out, you did a 'git merge foo', and you want
to do a revert, '1' stands for 'master' and '2' for 'foo'.

--W18qbkTAGYos9/y6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3rCwACgkQe81tAgORUJbifACeOIvaILN0fOzEcP3qKBj1qB6T
aDUAoKM6VaiAMZxb+COFRRXamR1TNHdG
=1UNY
-----END PGP SIGNATURE-----

--W18qbkTAGYos9/y6--
