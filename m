From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Don't share anything but those files
Date: Fri, 13 Jul 2012 13:53:06 -0400
Message-ID: <20120713175306.GB30723@euporie>
References: <500037EB.5030408@modusfx.com>
 <20120713152127.GC17521@phobos.chilli.itwm.local>
 <50004048.9060203@modusfx.com>
 <20120713161432.GA8770@phobos>
 <50005DA8.5020803@modusfx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Cc: Edward Toroshchin <edward.hades@gmail.com>, git@vger.kernel.org
To: Yves Perron <yves.perron@modusfx.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 20:03:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpkCi-0005Mn-2H
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 20:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386Ab2GMSCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 14:02:44 -0400
Received: from tmh.cc ([173.230.128.92]:55229 "EHLO elara.tmh.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563Ab2GMSCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 14:02:42 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2012 14:02:42 EDT
Received: by elara.tmh.cc (Postfix, from userid 1001)
	id F259730222; Fri, 13 Jul 2012 17:53:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on elara.tmh.cc
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=5.0 tests=ALL_TRUSTED,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED autolearn=no
	version=3.3.2
Received: from euporie (rrcs-70-61-89-106.midsouth.biz.rr.com [70.61.89.106])
	by elara.tmh.cc (Postfix) with ESMTPSA id D4AE430222;
	Fri, 13 Jul 2012 17:53:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50005DA8.5020803@modusfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201413>


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yves Perron, Fri 2012-07-13 @ 13:40:56-0400:
> Ok, let me rephrase, is there a way to edit a file where we can put
> every files/folders we need to add without the need of entering a
> command for each entry?

Sure, but you don't need functionality built in to Git to do this. Just
list the paths you want to add in a file and then:

    xargs git add <filename

But you only have to do this once, so I'm not really sure what that buys
you.

You can use glob patterns to select groups of files to add as well, if
there is some similarity in the pathnames.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQAGCCAAoJEDTWeng2oxKKjBkP/1JEyBF0vSig4clKDptwmDBq
SAxMb8G4yTiZCXGl6DgZRFrHDPIVCdCO2EJ8coUxftbJCY2Mavx0nwJmFWNyudgw
BV0ejTatTTK62XNHq24FkxCulBoPQq1mp6UHzIhLnVWK2mEyJ1gCaQFfSmRBSm/s
v9e6+/4WhASXzfc44b4nfWHS+lTA/Rm4MPmyA/ZMussK3h8RcfYO1ECIlSgPrcRY
Br1eI83+zbw1r9ArY8k622k4fuU9jGrcDwnadHEkgtUFai8CTlUxIQatCz1gyiBq
Si0cBZ6RhqcFK8QHvuSjKomoScSe8C1gwBJOdhyOiLSnT94LR76cGSFk3EuREkNd
GaHDx78OiIdEbiPRI8LMbgBk007Hv42dBidZWVsejZzTkYi2oCda9iVHRZMStPqc
I0fwgsLEu5jyFVhG3XnshdPBnHrZpJi48Q/eQ+Ke2DxAK2CTyoIqede9UnotTm/F
7NyKzPtkn3Y5sCNFaZnM6sQJD67MJ3qBEaCVNPqrTH9wNb8wjXwlSuLJ8n5ZsaGF
gTTzwVK/k7NLsFfEFg96QvWdhRcfPeXg3LdqD1hpd4w8rPVbEr5eM57xGKN/k1wT
7DdYJjgkl5k/Ii5cbXbTDzQVlxJfI5rY/p3a7pxVX7W1krh/KeTVi4539FmKC2Wj
015AgTnMJ8BBiYBy7PMJ
=gbGs
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
