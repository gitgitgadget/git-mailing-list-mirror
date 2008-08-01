From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git rev-parse --verify HEAD: fatal: Needed a single revision
Date: Fri, 1 Aug 2008 16:35:31 +0200
Message-ID: <20080801143531.GT32057@genesis.frugalware.org>
References: <g6ul10$rr9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d3YHM87040rLS1j9"
Cc: git@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 16:36:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOvkA-0007cG-RG
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 16:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbYHAOfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 10:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYHAOfd
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 10:35:33 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44329 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYHAOfd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 10:35:33 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 404991B253A;
	Fri,  1 Aug 2008 16:35:32 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8831B4465E;
	Fri,  1 Aug 2008 15:49:07 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E7B7D1770071; Fri,  1 Aug 2008 16:35:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g6ul10$rr9$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91070>


--d3YHM87040rLS1j9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2008 at 11:29:04AM +0200, Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:
> How to reproduce:
> get http://carme.pld-linux.org/~arekm/rpm5.tar.bz2
> unpack
> cd rpm5
> git cvsimport -v -d :pserver:anonymous@rpm5.org:/cvs rpm

I did:

git cvsimport -v -d :pserver:anonymous@rpm5.org:/cvs -o master -C rpm rpm

first time it bailed out with an error, sadly I don't exactly remember,
but it was different to your error. Then I ran it again (of course
without rm -rf rpm) and it finished properly. The cvs checkout and git
HEAD differs only in one file (python/Makefile.in is removed in cvs, but
not in git).

I put it out to http://vmiklos.hu/gitweb/?p=rpm.git, if you are
interested.

> I'm using:
> $ git --version
> git version 1.5.6.4

$ git --version
git version 1.6.0.rc0.14.g95f8.dirty

Not sure if it matters or not.

--d3YHM87040rLS1j9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiTHzMACgkQe81tAgORUJbwGgCglORIu8UxQKbF41L1diGL1ctb
cVkAoIn0qf5hKMJc+XVQ76FKtQmvC0xt
=wNKv
-----END PGP SIGNATURE-----

--d3YHM87040rLS1j9--
