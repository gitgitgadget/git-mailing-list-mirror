From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Question on GIT usage.
Date: Fri, 28 Oct 2005 21:43:23 -0400
Message-ID: <4362D3BB.3050601@michonline.com>
References: <4362C700.6020901@candelatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig55AA9E8C16649041C627A97A"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 03:44:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVfkx-00079e-Sm
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 03:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVJ2Bng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 21:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJ2Bng
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 21:43:36 -0400
Received: from mail.autoweb.net ([198.172.237.26]:24263 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750862AbVJ2Bnf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 21:43:35 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EVfkn-00055x-O3; Fri, 28 Oct 2005 21:43:29 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EVfkl-0001VD-00; Fri, 28 Oct 2005 21:43:27 -0400
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EVfkl-0003F5-Dz; Fri, 28 Oct 2005 21:43:27 -0400
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <4362C700.6020901@candelatech.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10779>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig55AA9E8C16649041C627A97A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ben Greear wrote:
> 
> I have a kernel GIT tree to hold my developing patches...
> 
> I need to build this kernel for 4-5 different processors (c3, p2, p4,
> p4-smp, etc).
> 
> Is there any clever way to have this one git repository keep these
> other source trees in sync so that I can do incremental builds?
> 
> Should I perhaps have a unique git repo for each different build and
> just pull changes in from my master repo before building?
> 
> If there's a simple command to set up slave repositories like this,
> please point me to it.

There isn't, not really - but in the kernel's case, you don't need one,
either.

Build with:
	make O=/path/to/c3/tree

Put your .config in /path/to/c3/tree/

All your compiled stuff will drop into that tree, and your source tree
will stay untouched, so you can have a single GIT tree and source files.


--------------enig55AA9E8C16649041C627A97A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYtO+fhVDhkBuUKURAsgMAJ0QkaNJ2ocDtaADc8uhhvYl6a8sEACeJrm/
V7d5QgM9KADuFgSrXUPVZgk=
=lcWs
-----END PGP SIGNATURE-----

--------------enig55AA9E8C16649041C627A97A--
