From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-imap-send: Allow the program to be run from
	subdirectories of a git tree.
Date: Mon, 2 Jun 2008 00:04:10 +0200
Message-ID: <20080601220410.GD29404@genesis.frugalware.org>
References: <1096648c0806010828yf4f07ebt3f758f41cab5cdfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2bJ57vwr75KGnr5s"
Cc: git@vger.kernel.org
To: Rob Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 00:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2vfm-0005fI-2p
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 00:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYFAWEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYFAWEN
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 18:04:13 -0400
Received: from virgo.iok.hu ([193.202.89.103]:41881 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbYFAWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 18:04:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 21F9E1B254C;
	Mon,  2 Jun 2008 00:04:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7AF6144668;
	Sun,  1 Jun 2008 23:46:55 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D8BC31190A46; Mon,  2 Jun 2008 00:04:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1096648c0806010828yf4f07ebt3f758f41cab5cdfd@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83472>


--2bJ57vwr75KGnr5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2008 at 04:28:44PM +0100, Rob Shearman <robertshearman@gmai=
l.com> wrote:
> +	setup_git_directory_gently( NULL );
>  	git_config(git_imap_config, NULL);

I know this is just about cosmetics, but the style of the rest of the
code would suggest using

        setup_git_directory_gently(NULL);

not=20

        setup_git_directory_gently( NULL );

--2bJ57vwr75KGnr5s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhDHNoACgkQe81tAgORUJZX+gCeKkKs7bV862O8DGrsXZOjDmOU
a8IAnRs1QNl/9zYoRPvI+ET83x2jOnjo
=WAdx
-----END PGP SIGNATURE-----

--2bJ57vwr75KGnr5s--
