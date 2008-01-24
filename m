From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 15:47:11 -0500
Message-ID: <20080124204711.GC17765@kodama.kitenet.net>
References: <1201198439-3516-1-git-send-email-pascal@obry.net> <alpine.LSU.1.00.0801241818441.5731@racer.site> <4798DE6A.1050201@obry.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 21:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI96Q-0001RO-DH
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 21:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbYAXUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYAXUyl
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 15:54:41 -0500
Received: from wren.kitenet.net ([80.68.85.49]:38334 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbYAXUyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 15:54:40 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2008 15:54:39 EST
Received: from kodama.kitenet.net (66-168-92-132.dhcp.kgpt.tn.charter.com [66.168.92.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTP id AA3DE3143A5
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 15:47:12 -0500 (EST)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 4AB8F114340; Thu, 24 Jan 2008 15:47:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4798DE6A.1050201@obry.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92/5545/Thu Jan 24 13:20:13 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71660>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pascal Obry wrote:
> Johannes Schindelin a =E9crit :
>> That is ugly.  In a source file which is by no means specific to =20
>> git-commit, you cannot possibly mean to check for "amend".
>
> Agreed :( I'll try to come with something better.

Some option parsers avoid this sort of ambiguity by not allowing short
options that take a string to be bundled in the same word with other
short options.

So, for example, git-commit -am<msg> would not be allowed, while
git-commit -a -m<msg> and perhaps git-commit -am <msg> would be allowed.

There could still be problems if there were a --mend option that could
be typoed as -mend.

I don't know enough about compatability to say if this would work for git.

--=20
see shy jo
<relurk>

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHmPlPd8HHehbQuO8RAkWBAKDQjIlm+l3qJDJ+eFcUAqFv+HGNRgCg3bH+
lhr9WuBGYJCDeXCPgRXN0yk=
=107c
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
