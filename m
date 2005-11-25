From: Ryan Anderson <ryan@michonline.com>
Subject: Re: files are disappearing in git
Date: Thu, 24 Nov 2005 20:54:34 -0500
Message-ID: <43866EDA.9050203@michonline.com>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig799D45A63CC5C1E0628355BB"
Cc: Linus Torvalds <torvalds@osdl.org>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 02:56:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfSo4-0002X7-GZ
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 02:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVKYBzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 20:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVKYBzK
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 20:55:10 -0500
Received: from mail.autoweb.net ([198.172.237.26]:20717 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1161086AbVKYBzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 20:55:09 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EfSnO-0008Nb-Qq; Thu, 24 Nov 2005 20:54:40 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EfSnO-0000ds-00; Thu, 24 Nov 2005 20:54:38 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EfSnN-0007Yi-Rf; Thu, 24 Nov 2005 20:54:37 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051124084633.GA3361@schottelius.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12727>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig799D45A63CC5C1E0628355BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nico -telmich- Schottelius wrote:
> Linus Torvalds [Wed, Nov 23, 2005 at 09:20:28AM -0800]:
 >>Is the tree public so that we can look at it and perhaps make a guess
from
>>what happened around it?
> 
> 
> I am sorry it is not. Perhaps I can convince my boss to allow access to it for
> some git developers, so someone could debug it. Thought, every information
> found in the tree would have to be treated confidental.
> 
> Do you have some other hints on how to debug that? Perhaps some conistency checking
> tool?
> 
> Or perhaps should I put that git directory under cvs? ;-)

Is there anything in the directory structure that would be confidential?

Can you maybe provide the output of "git-whatchanged" (with no
parameters) or maybe

	git-whatchanged $commit1..$commit2 path/

Where $commit1 is a few commits before the problem, and $commit2 is a
few after it, and path/ is a path above the problem path?

You might add -m to that command line, too.

If the output of one of those commands, which will be commit objects +
tree differences, is less problematic, perhaps that would be easier to
share?




--------------enig799D45A63CC5C1E0628355BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDhm7dfhVDhkBuUKURAssSAJ4hX6tiQTx/xgnwOsI84DK0dRFrkQCeNS4o
YX5fDh8iNsxEs84XAgIeovg=
=3xaG
-----END PGP SIGNATURE-----

--------------enig799D45A63CC5C1E0628355BB--
