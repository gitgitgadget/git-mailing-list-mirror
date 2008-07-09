From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Wed, 9 Jul 2008 12:56:23 +0200
Message-ID: <20080709105623.GP10347@genesis.frugalware.org>
References: <200807080227.43515.jnareb@gmail.com> <bd6139dc0807090318r4cbcac93s907871c6b45c03ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Jul 09 12:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGXMV-0006W9-Gm
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 12:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYGIK43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 06:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbYGIK43
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 06:56:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43647 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYGIK42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 06:56:28 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9F49A1B255A;
	Wed,  9 Jul 2008 12:56:26 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4439C4465E;
	Wed,  9 Jul 2008 12:23:05 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 38037177001C; Wed,  9 Jul 2008 12:56:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0807090318r4cbcac93s907871c6b45c03ac@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87867>


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2008 at 12:18:41PM +0200, Sverre Rabbelier <alturin@gmail.com> wrote:
> I am not yet sure how I should send in my code for peer review.
> $ git rev-list master | wc -l
> 151

What I did squashing fixes regularly, but I keep a 'history' branch
where I always reference to the old HEAD, so others can still have a
look at the individual commits.

It's like:

$ cat rebase-builtin-merge.sh
#!/bin/sh -e

[ -n "$*" ]

old_head=$(git rev-parse HEAD)
git rebase $*
git update-ref refs/heads/rebase-history \
        $(echo "Rebased with 'git rebase $*'" | \
        git commit-tree HEAD^{tree} -p rebase-history -p $old_head -p HEAD)

It will not work properly if you get conflicts, but you got the idea.

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh0mVcACgkQe81tAgORUJY+mQCghQC539bzEZyPRnFvpxzxz6pk
dkQAn25czTSnQfk9V5MuCkuPLDNALfv3
=5JyZ
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
