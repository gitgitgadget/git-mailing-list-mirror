From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn branch naming question
Date: Sun, 9 Dec 2007 20:36:33 +0100
Message-ID: <20071209193633.GR3199@genesis.frugalware.org>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org> <20071209020510.GM3199@genesis.frugalware.org> <20071209022624.GA31033@soma> <20071209023600.GP3199@genesis.frugalware.org> <20071209032608.GB31033@soma>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kZU6r8y0YpRwyDfh"
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 20:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1RxR-0005Qk-CN
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 20:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXLITgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 14:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXLITgf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 14:36:35 -0500
Received: from virgo.iok.hu ([193.202.89.103]:40793 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbXLITge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 14:36:34 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8DD4D1B24F0;
	Sun,  9 Dec 2007 20:36:33 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BCEDA4465C;
	Sun,  9 Dec 2007 20:35:25 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 33B2E1190054; Sun,  9 Dec 2007 20:36:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071209032608.GB31033@soma>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67654>


--kZU6r8y0YpRwyDfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2007 at 07:26:08PM -0800, Eric Wong <normalperson@yhbt.net> wrote:
> Perhaps git-clone could gain the ability to clone refs/remotes/ as-is
> without an extra step?

well, what i did for now is to use 2 repos. i use git-svn to create a
regular git-svn repo from svn, then an other one to create a regular git
repo from the git-svn one. this has one benefit: git-svn requires a
working tree, but i definitely want to publish only a bare repo. so here
is what i have in the bare repo's config:

[remote "origin"]
        url = /path/to/git-svn/repo
        fetch = +refs/remotes/origin/tags/*:refs/tags/*
        fetch = +refs/remotes/origin/trunk:refs/heads/master
        fetch = +refs/remotes/origin/*:refs/heads/*

then a simple git fetch will do what i need. i'm not entirely sure this
is the right think to do, but works for me :)

thanks,
- VMiklos

--kZU6r8y0YpRwyDfh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHXEPBe81tAgORUJYRAsAYAJ9Pcl5VWemytiCm3EwNxAD4ZW6iegCgpojw
o0gOP5/7/nSxzzJHZHF8DoM=
=QRqs
-----END PGP SIGNATURE-----

--kZU6r8y0YpRwyDfh--
