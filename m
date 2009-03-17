From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Mirroring repository state, with branches and submodules.
Date: Tue, 17 Mar 2009 17:56:35 +0100
Message-ID: <20090317165635.GB3817@genesis.frugalware.org>
References: <623D3837-E899-49AF-9A37-F667A311EE58@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nljfjKcp9HDtPSOP"
Cc: git@vger.kernel.org
To: Toby White <toby.o.h.white@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjccA-0003RU-Q2
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbZCQQ4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZCQQ4h
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:56:37 -0400
Received: from virgo.iok.hu ([212.40.97.103]:39953 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbZCQQ4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:56:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 02E84580DB;
	Tue, 17 Mar 2009 17:56:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E917B44783;
	Tue, 17 Mar 2009 17:56:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4469411B80AE; Tue, 17 Mar 2009 17:56:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <623D3837-E899-49AF-9A37-F667A311EE58@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113506>


--nljfjKcp9HDtPSOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2009 at 03:21:40PM +0000, Toby White <toby.o.h.white@googlemail.com> wrote:
> git fetch
> for BRANCH in $(git branch -r | cut -d / -f 2); do
>    git checkout $BRANCH
>    git reset --hard origin/$BRANCH
> done
> git submodule update --init

First, I think you don't handle the case when you have multiple
remotes. I don't know if this is a problem for you or not.

Second, use plumbing in scripts, git for-each-ref has a stable output
format, while git branch may change.

--nljfjKcp9HDtPSOP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm/1kMACgkQe81tAgORUJYF4gCgjz2vA7uhJCtQ560aR/oAil8b
V54AmweNKfxVLSk91AebQmZRNroU/9CN
=3AgU
-----END PGP SIGNATURE-----

--nljfjKcp9HDtPSOP--
