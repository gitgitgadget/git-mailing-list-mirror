From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Interactive rebase encoding
Date: Mon, 15 Dec 2008 16:13:22 +0100
Message-ID: <20081215151322.GI5691@genesis.frugalware.org>
References: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z+vV71AWp02Mr0PV"
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 16:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCF9h-0004Xm-83
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 16:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbYLOPNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 10:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbYLOPNZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 10:13:25 -0500
Received: from virgo.iok.hu ([212.40.97.103]:57217 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbYLOPNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 10:13:25 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DC5DA580A1;
	Mon, 15 Dec 2008 16:13:22 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 90D294465E;
	Mon, 15 Dec 2008 16:13:22 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5AB4111B862F; Mon, 15 Dec 2008 16:13:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103172>


--Z+vV71AWp02Mr0PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 15, 2008 at 03:42:08PM +0300, Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> The interactive rebase command builds a text file and passes it to
> editor specified as environment variable or as configuration
> parameter. However the man page for rebase operation says nothing
> about which encoding will be used for that file. Apparently
> i18n.logoutputencoding is used. I think that the man page for rebase
> operation should explicitly specify it.

Care to send a patch?

> Also it might make sense to use explicit encoding parameter for
> interactive rebase operation.

Do you have a use-case where having a different encoding for log output
and rebase -i todo list makes sense?

Thanks.

--Z+vV71AWp02Mr0PV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklGdBIACgkQe81tAgORUJa3MQCgo/4rEjVluhimXYtg/MT7kPi5
83EAoJRz/bVj9pPtEqOPxTodieGrQctE
=viVo
-----END PGP SIGNATURE-----

--Z+vV71AWp02Mr0PV--
