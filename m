From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 18:19:23 +0200
Message-ID: <20080711161923.GE10347@genesis.frugalware.org>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dRgc669pgRVB2OqT"
Cc: git@vger.kernel.org
To: ff <ff@member.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLM8-0006mG-GG
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYGKQTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYGKQTZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:19:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50180 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbYGKQTY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:19:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8697A1B24FA;
	Fri, 11 Jul 2008 18:19:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6D0624465E;
	Fri, 11 Jul 2008 17:44:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2FBC1177001C; Fri, 11 Jul 2008 18:19:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88140>


--dRgc669pgRVB2OqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2008 at 12:16:15PM -0400, ff <ff@member.org> wrote:
> Now I would like to revert the merge... what is the best way of doing that?
> I would like very much to use something like git-revert <merge_commit_id>
> But that does not seem to work.

git revert has a '-m' option to revert merges. See the manpage.

> Any help/pointers of an example illustrating solution to this case
> would be greatly
> appreciated!

Actually if you just did that merge by accident, then probably you want
'git reset --hard HEAD^', not git revert, I think.

--dRgc669pgRVB2OqT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3iAsACgkQe81tAgORUJbZdQCfVeVGqp9kHLuZRLyzrS1W27Qr
1yMAoKjGEzWOLQJSaEI0aGtgTJ5VQmFu
=ooZu
-----END PGP SIGNATURE-----

--dRgc669pgRVB2OqT--
