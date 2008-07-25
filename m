From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC] custom strategies in builtin-merge
Date: Fri, 25 Jul 2008 13:33:16 +0200
Message-ID: <20080725113316.GF32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rVMVguMjBJz39qo3"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 13:34:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLYw-0006X3-Ce
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYGYLdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYGYLdS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:33:18 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42644 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbYGYLdR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:33:17 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 554341B2516;
	Fri, 25 Jul 2008 13:33:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 23B684465E;
	Fri, 25 Jul 2008 12:50:53 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 21E161190A09; Fri, 25 Jul 2008 13:33:16 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90035>


--rVMVguMjBJz39qo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We talked with Dscho about how would it be possible to allow custom
strategies in builtin-merge and I have a question here.

The problem is that currently merge strategies are always named
git-merge-foo, but not all git-merge-foo is a merge strategy.

So we talked about two solutions here:

1) Maintain a list of commands that has a git-merge- prefix, but not a
strategy. This list would currently contain "base, file, index,
one-file and tree".

2) Require custom strategies to have a different naming scheme, like
if "foo" is a custom strategy, then it would have to be named
git-merge-custom-foo, _not_ git-merge-foo.

Both are doable (I prefer 1) a bit), but I thought it's better to ask
first before I implement any of them.

So, comments?

Thanks.

--rVMVguMjBJz39qo3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiJufwACgkQe81tAgORUJbxGgCggMJLr0x1gltvCzJpSC0ViU+r
ezYAn3yuGHsKEnv19P1rdjFQn+hIIy/q
=zymB
-----END PGP SIGNATURE-----

--rVMVguMjBJz39qo3--
