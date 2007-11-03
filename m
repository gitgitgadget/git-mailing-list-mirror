From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 11:56:35 +0100
Message-ID: <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-73-1031830690"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 11:57:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoGgk-0006Vn-GC
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 11:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbXKCK4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbXKCK4t
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 06:56:49 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:54559 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbXKCK4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 06:56:48 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IoGgH-00077S-7I; Sat, 03 Nov 2007 11:56:45 +0100
In-Reply-To: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63230>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-73-1031830690
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 3, 2007, at 9:19 AM, Luke Lu wrote:

> There are a few svn repositories that use non-standard layout like  
> this:
>
> <path_to_project>/trunk
> <path_to_project>/production
> <path_to_project>/some_branch
>
> production and some_branch are indeed branched from trunk.
>
> 1. How do you init/clone svn repositories like that?

I seem to remember that you can pass more than one `-b' option to git- 
svn clone, so I'd basically do (untested):
git svn clone <url> -T trunk -b production -b some_branch

> 2. Is there a way to add a new svn branch like that (say production  
> or some_branch) to an existing git-svn repository that has trunk  
> cloned?

I don't know, but that'd be great indeed.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-73-1031830690
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHLFPjwwE67wC8PUkRAnPjAJ4m4fw+iBNtCTt5pq/MDAZXshrDxgCgjtcl
7lX61tcAq7C3K8tSXVpJSMU=
=oUto
-----END PGP SIGNATURE-----

--Apple-Mail-73-1031830690--
