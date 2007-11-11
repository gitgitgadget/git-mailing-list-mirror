From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Installing without rebuilding
Date: Sun, 11 Nov 2007 17:55:31 +0100
Message-ID: <8FE99206-EECF-4081-B4B7-82707FA4E863@lrde.epita.fr>
References: <8B92E213-17DB-4E83-B045-01CE0E7D26CB@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-28--402917080"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrG6J-0001pP-IL
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 17:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbXKKQzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 11:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbXKKQzn
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 11:55:43 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:54505 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXKKQzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 11:55:42 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IrG61-0000Tr-5J; Sun, 11 Nov 2007 17:55:41 +0100
In-Reply-To: <8B92E213-17DB-4E83-B045-01CE0E7D26CB@silverinsanity.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64475>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-28--402917080
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 11, 2007, at 5:49 PM, Brian Gernhardt wrote:

> Git has a very clever Makefile.  Sometimes its a little overly clever.
>
> 1) I use stow to manage my /usr/local directory.  With many other  
> programs I am able to build with a prefix of /usr/local and install  
> with a prefix of /usr/local/stow/$program.  Git detects a change in  
> the build variables and recompiles pretty much everything.
>
> 2) If I remove the old copy of git before installing the new, git  
> will notice this and again start a (smaller) recompile because the  
> GIT-VERSION-FILE file changes from something detailed like  
> "1.5.3.5.622.g6fd7a" to "1.5.3.GIT".
>
> Is there a way to tell git to be a bit less clever and just install  
> the already compiled program?  If not, would changing the Makefile  
> to read something like the following be accepted?
>
> ----- 8< -----
>
> install: all install-dumb
>
> install-dumb: # No rebuild!
>   # Current install process
>
> ----- 8< -----

I also stow git (which doesn't come with a make uninstall grrrrrr)  
and what I do is that I dropped the dependency of `install' on  
`all'.  Also, I always install the new version before removing (stow - 
D) the previous one.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-28--402917080
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHNzQDwwE67wC8PUkRAjIKAKC6YpNNO0UkIOYJWYsXnts1espB1gCgmFvr
hW3DuquCiugCq1zmKudIP9Q=
=THHZ
-----END PGP SIGNATURE-----

--Apple-Mail-28--402917080--
