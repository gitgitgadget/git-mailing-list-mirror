From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 23:10:49 +0200
Message-ID: <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16-192168156"
Content-Transfer-Encoding: 7bit
Cc: Neil Macneale <mac4-git@theory.org>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibjat-0007fE-SI
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbXI2VLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbXI2VLQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:11:16 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:60107 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbXI2VLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:11:16 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Ibjaj-0008VY-QU; Sat, 29 Sep 2007 23:11:13 +0200
In-Reply-To: <Pine.LNX.4.64.0709292201400.28395@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59491>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16-192168156
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Sep 29, 2007, at 11:03 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sat, 29 Sep 2007, Neil Macneale wrote:
>
>> When using "git stash," in some cases I'd like to stash away files  
>> that
>> are currently untracked. It seems to me like there should be a way to
>> stash everything in a working directory so that the end result is a
>> pristine tree. Then applying the stash will reinstate those file as
>> untracked.
>
> Funny how the same ideas always come in packs: I had the same  
> discussions
> a few nights ago on IRC.
>
> Here is why I think it is _wrong_ to stash untracked files: this would
> include *.o and *.a, as well as all those binary files, too.
>
> Instead this is what you _should_ do:
>
> git add <the files that you care about>
> git stash

You could stash untracked files that are not ignored (I personally  
ignore *.o, *.a and the like).

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-16-192168156
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG/r9ZwwE67wC8PUkRAvFdAJ9+kiYqbuXWGX4uh8qc+84gJ7CRlgCghxJ7
8U5S6jyfa/wpoLkoeVstBQ0=
=p6ro
-----END PGP SIGNATURE-----

--Apple-Mail-16-192168156--
