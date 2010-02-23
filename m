From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-* in hook scripts
Date: Wed, 24 Feb 2010 00:59:42 +0100
Message-ID: <20100223235941.GG12429@genesis.frugalware.org>
References: <m3hbp7x673.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aa/yH8O8slWSpyYB"
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:59:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4fO-0001Eh-Jy
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0BWX7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:59:45 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46426 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab0BWX7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:59:44 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 53CF858096;
	Wed, 24 Feb 2010 00:59:42 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4E66942F09;
	Wed, 24 Feb 2010 00:59:42 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 142351240003; Wed, 24 Feb 2010 00:59:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3hbp7x673.fsf@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140877>


--aa/yH8O8slWSpyYB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2010 at 11:33:36AM -0500, Eli Barzilay <eli@barzilay.org> wrote:
> There are several sample hook scripts that use `git-*' -- should these
> use `git *' instead?

No need to do so, `git --exec-path` is already in PATH when those
scripts are invoked.

--aa/yH8O8slWSpyYB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuEa+0ACgkQe81tAgORUJYMIgCfaHpqSCju1DNGs06ifFGnHz+o
CVYAn3cu7nMT7XlNipNJr0xDsNUKfoZe
=I+mT
-----END PGP SIGNATURE-----

--aa/yH8O8slWSpyYB--
