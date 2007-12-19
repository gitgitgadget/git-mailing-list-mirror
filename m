From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn and migration
Date: Wed, 19 Dec 2007 21:23:33 +0100
Message-ID: <20071219202333.GD4390@genesis.frugalware.org>
References: <320075ff0712190849u2c40cc46pf01fa2a75f557482@mail.gmail.com> <320075ff0712190850r35263bcfv1d8f84e699208e15@mail.gmail.com> <20071219175447.GB15898@dervierte>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Cc: Nigel Magnay <nigel.magnay@gmail.com>, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 21:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J55SW-00016t-RG
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 21:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbXLSUXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbXLSUXk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 15:23:40 -0500
Received: from virgo.iok.hu ([193.202.89.103]:16003 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449AbXLSUXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 15:23:36 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 050771B24FB;
	Wed, 19 Dec 2007 21:23:33 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A9A3A4465C;
	Wed, 19 Dec 2007 21:22:15 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AE083119019C; Wed, 19 Dec 2007 21:23:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071219175447.GB15898@dervierte>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68934>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2007 at 12:54:47PM -0500, Steven Walter <stevenrwalter@gmail.com> wrote:
> Using a central git repo that is kept uptodate with svn is the approach
> I've used.  git-svn isn't especially keen on this mode of operation,
> however.  After every fetch, you have to reset refs/remotes/trunk to
> origin/master, which it turn puts .git/svn out of date (you can blow it
> away and run "git svn fetch" to regenerate it).

an other problem is that you probably want to have a bare repo while
git-svn needs a working dir. a possible solution:

http://blogs.frugalware.org/vmiklos/2007/12/09/p320

(it works for me fine, but maybe there are problems with it so use with
care :) )

- VMiklos

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHaX3Fe81tAgORUJYRAsyMAKCGmcQ8oyZbF3SpPXU8DG2XCdHJ8wCdET6z
8kKTAAu9U20o4fspQPcm9H8=
=5OeO
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
