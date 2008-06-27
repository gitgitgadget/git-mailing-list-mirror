From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: possible 'git cp'/how does git detect copies
Date: Fri, 27 Jun 2008 15:09:45 +0200
Message-ID: <20080627130945.GN29404@genesis.frugalware.org>
References: <4864DFB6.3050204@mircea.bardac.net> <20080627130006.GC17898@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3c2Bxu25kYfJhL99"
To: Pierre Habouzit <madcoder@debian.org>,
	Mircea Bardac <dev@mircea.bardac.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 15:10:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDj0-0008JY-99
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760154AbYF0NJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759964AbYF0NJv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:09:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36070 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759101AbYF0NJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:09:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9F3C01B2514;
	Fri, 27 Jun 2008 15:09:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 55D4C4469A;
	Fri, 27 Jun 2008 14:43:11 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AD8BE1778012; Fri, 27 Jun 2008 15:09:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080627130006.GC17898@artemis.madism.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86557>


--3c2Bxu25kYfJhL99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2008 at 03:00:06PM +0200, Pierre Habouzit <madcoder@debian.org> wrote:
>   If you really need it, you can and an alias alias.cp=!cp and be done
> with it ;P

Actually that's not that easy. git-mv moves untracked files and adds
tracked files to the index as well. So such a git-cp would have to copy
tracked and untracked files, and add tracked files to the index.

I did it in the past:

http://thread.gmane.org/gmane.comp.version-control.git/72388/focus=73347

but then we agreed about it's better not encouraging copy-and-paste.

--3c2Bxu25kYfJhL99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhk5pkACgkQe81tAgORUJaJCQCfZ0Gqe6IUFhB88rfLCjypZYNR
gJUAoJQLib4tQPVjQzoCKdJW4aOqMlwg
=OJhx
-----END PGP SIGNATURE-----

--3c2Bxu25kYfJhL99--
