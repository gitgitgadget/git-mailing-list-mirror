From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [Question] info/grafts file.
Date: Wed, 16 Nov 2005 19:57:14 -0500
Message-ID: <437BD56A.7030402@michonline.com>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com> <7vhdafx81m.fsf@assigned-by-dhcp.cox.net> <20051115000349.GA32136@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D979CA5D178BD0E2FB30DB9"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 01:59:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcY6H-0007uK-FW
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 01:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVKQA5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 19:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVKQA5z
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 19:57:55 -0500
Received: from mail.autoweb.net ([198.172.237.26]:28113 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1161049AbVKQA5y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 19:57:54 -0500
Received: from [10.100.10.12] (helo=[10.100.10.12])
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EcY61-0002vs-15; Wed, 16 Nov 2005 19:57:49 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051115000349.GA32136@hpsvcnb.fc.hp.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12079>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D979CA5D178BD0E2FB30DB9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Carl Baldwin wrote:
> This is fine, I just needed to know.
> 
> How hard is it to, in a generic way, take a grafts file and reconstruct
> commits to include the parents in the graft file in the actual tree?  I
> am wondering because I couldn't, after much work, get git-svnimport to
> find my merges correctly.  So, I am needing to hand-graft some merges in
> to make things right.  Any suggestions?  I could try to figure something
> out if I can find some time.  I'm good with graph traversals and such.

It's actually pretty easy.  I wrote a rough (and not quite safe) tool to
do this a week or so ago.

http://marc.theaimsgroup.com/?l=git&m=113131673606637&w=2

I will try and clean it up a bit and submit it for inclusion in contrib/
sometime this coming weekend, but you should be able to use it to solve
this problem.

It's pretty straightforward, honestly.  (And I'm pretty sure it could be
faster if I did things slightly differently.)


--------------enig2D979CA5D178BD0E2FB30DB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDe9VvfhVDhkBuUKURApeIAKDsA2jkeQBgHvO4RXRO+enshR4NuACfZV64
VLRwD/nmzTDiMhhmN2APEVE=
=B1LS
-----END PGP SIGNATURE-----

--------------enig2D979CA5D178BD0E2FB30DB9--
