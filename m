From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: gitk/git-gui misfeature: saving the geometry can the window out of reach
Date: Sat, 10 Nov 2007 22:48:05 +0100
Message-ID: <63F7323C-D90A-4F5E-AE3C-8937455972FD@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-19--471762876"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 22:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqyBv-0006zq-6Y
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 22:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbXKJVsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 16:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbXKJVsS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 16:48:18 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:41605 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbXKJVsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 16:48:18 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IqyBc-00013k-9u
	for git@vger.kernel.org; Sat, 10 Nov 2007 22:48:16 +0100
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64379>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-19--471762876
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hello list,

gitk (and I think git-gui too) save their "geometry" (which includes  
X/Y position) in ~/.gitk.  So far so good.  The problem is that I  
often use 2 screens at work (one is the screen of my laptop, the  
other one is above) and I happen to put my gitk/git-gui windows on  
the 2nd screen.  When I go back home, I don't have a second screen  
and gitk/git-gui open their windows out of reach.  This could well be  
an ugly wart in Apple's port of Tcl/Tk (I have a MacBook with OSX  
10.4.10) or a more general problem (didn't try with other OSes).

git-gui version 0.8.4
git version 1.5.3.5.654.gdd5ec (tonight's master's HEAD)
Tcl/Tk version 8.4.7 (Apple's)
(gitk doesn't support --version!)

For those struggling with the same problem, here is a quick workaround:
   gnused -i /geometry/d ~/.gitk

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-19--471762876
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHNicVwwE67wC8PUkRAtncAJsEJqvaIKpVMa1ioBAK/zu1YkB47gCdFgeQ
Py06SbKLoYEcvEYIKb+iCUk=
=b1YW
-----END PGP SIGNATURE-----

--Apple-Mail-19--471762876--
