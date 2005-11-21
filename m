From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Mon, 21 Nov 2005 00:18:12 -0500
Message-ID: <43815894.20602@michonline.com>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de> <20051120223249.GI3393@nowhere.earth> <Pine.LNX.4.63.0511210041370.24681@wbgn013.biozentrum.uni-wuerzburg.de> <20051121022428.GB7902@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD10447C70479BD232FA4799D"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 06:19:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee44P-0006TY-4I
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 06:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVKUFSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 00:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKUFSW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 00:18:22 -0500
Received: from mail.autoweb.net ([198.172.237.26]:58053 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932191AbVKUFSW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 00:18:22 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.50)
	id 1Ee44F-0004j1-VQ; Mon, 21 Nov 2005 00:18:16 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Ee44F-0004JA-00; Mon, 21 Nov 2005 00:18:15 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1Ee44F-0007vH-FL; Mon, 21 Nov 2005 00:18:15 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051121022428.GB7902@kiste.smurf.noris.de>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12423>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD10447C70479BD232FA4799D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthias Urlichs wrote:

> If you need a new HEAD *anyway*, then re-basing your trees would
> IMHO be a better solution.
> 
> ORIG1 .. ORIG2 .. .. ORIG_HEAD
>                          |
>                          |   GIT1 .. GIT2 .. .. GIT_HEAD
>                          |  //       //           //   \
>                          | //       //           //    TAG
>                       NEWGIT1 .. GIT2 .. .. NEW_HEAD
>                                                    \
>                                                   NEW_TAG
> 
> Those // links might be real parent pointers, which allows you to keep 
> your old tags -- or not, which allows you to have a sane history. The
> good part is that you can do this incrementally, so you won't need a
> flag day.

This is exactly what the script I started this thread with does. It
would be mostly useful if someone had serious development work based of
an old, out-of-git branch, and wanted to use the git merging tools to
get it merged into something based against the current development.

I would expect that they would then want to rebase it or do something
else to clean up the mess that is created, and apply it directly to the
current development tree, rather than leaving it as part of that very
messy tree.

My other goal was to provide myself (and others) an example of using the
barebones core tools for some strange tasks that no *real* porcelain
would ever find useful.



--------------enigD10447C70479BD232FA4799D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDgViXfhVDhkBuUKURAlcpAKDjfCj7dVYuEz921TRbBcJoKmmZiQCdFurx
1TYLUVIByz5JnQQsSGkGryU=
=lOhc
-----END PGP SIGNATURE-----

--------------enigD10447C70479BD232FA4799D--
