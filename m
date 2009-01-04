From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 04:38:39 +0100
Message-ID: <20090104033839.GD21154@genesis.frugalware.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu> <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com> <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xhBcNpeZh7WRSjC8"
Cc: David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Jan 04 04:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJJqP-0002YA-GC
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 04:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbZADDip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 22:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbZADDip
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 22:38:45 -0500
Received: from virgo.iok.hu ([212.40.97.103]:51203 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbZADDio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 22:38:44 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 078FC580D1;
	Sun,  4 Jan 2009 04:38:42 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7F7FB4465E;
	Sun,  4 Jan 2009 04:38:40 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id ECA5311B8630; Sun,  4 Jan 2009 04:38:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104492>


--xhBcNpeZh7WRSjC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 03, 2009 at 06:18:36PM -0800, Karl Chen <quarl@cs.berkeley.edu> wrote:
> How about an option to git-symbolic-ref that gets rid of the
> refs/heads/ ?

Make an alias?

git config alias.cb '!sh -c "git symbolic-ref HEAD|sed s,refs/heads/,,"'

$ git cb
master

(Where cb can stand for 'current branch', for example.)

--xhBcNpeZh7WRSjC8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklgLz8ACgkQe81tAgORUJYs/wCgnKSP8Kx1KQni9IKS9rv09LlN
kyQAmwW9I24/+g9vUxqh2sK/T7mqujPv
=2DWO
-----END PGP SIGNATURE-----

--xhBcNpeZh7WRSjC8--
