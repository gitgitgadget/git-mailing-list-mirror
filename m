From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: import files w/ history
Date: Fri, 6 Mar 2009 16:33:13 +0100
Message-ID: <20090306153313.GL4371@genesis.frugalware.org>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu> <20090303130046.GA7867@coredump.intra.peff.net> <slrngr299k.1t4t.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWGl2Oocib6fGxwW"
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfc4b-0007hL-3R
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbZCFPdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbZCFPdU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:33:20 -0500
Received: from virgo.iok.hu ([212.40.97.103]:57462 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168AbZCFPdU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:33:20 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id ABCE1580CD;
	Fri,  6 Mar 2009 16:33:14 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BE4764471C;
	Fri,  6 Mar 2009 16:33:13 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8FBE9153C001; Fri,  6 Mar 2009 16:33:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <slrngr299k.1t4t.csaba-ml@beastie.creo.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112450>


--XWGl2Oocib6fGxwW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2009 at 01:29:38PM +0000, Csaba Henk <csaba-ml@creo.hu> wrote:
> $ git filter-branch --commit-filter '
>    if [ $# -lt 3 ] || git diff --stat $3 $1 | grep -q 'sys/dev/disk/vn/vn\.c'
>    then
>      git commit-tree "$@"
>    else
>      skip_commit "$@"
>    fi' HEAD

Did you notice --subdirectory-filter? Maybe it would be more efficient
to run --subdirectory-filter sys/dev/disk/vn first, then you can play
with the resulting small repo to suit your needs. :)

--XWGl2Oocib6fGxwW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmxQjkACgkQe81tAgORUJbZqACfVY+sBfObpiCUlxu20K8dvc27
yTEAn1mqOYKHPHDz5+EMt2B1S4/Zai2+
=Ri9Z
-----END PGP SIGNATURE-----

--XWGl2Oocib6fGxwW--
