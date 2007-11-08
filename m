From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH 2/3] Fix sed script to work with AIX and BSD sed.
Date: Thu, 8 Nov 2007 23:15:32 +0100
Message-ID: <D42380BD-64A7-4686-9EC1-39F76D0C35D6@lrde.epita.fr>
References: <20071108214624.GF31439@ins.uni-bonn.de> <20071108214824.GH31439@ins.uni-bonn.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-94--642915966"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:16:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFfJ-0003JX-Jt
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 23:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664AbXKHWPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 17:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759500AbXKHWPm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 17:15:42 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:41297 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759452AbXKHWPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 17:15:42 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IqFf2-0001XQ-HA; Thu, 08 Nov 2007 23:15:40 +0100
In-Reply-To: <20071108214824.GH31439@ins.uni-bonn.de>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64082>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-94--642915966
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 8, 2007, at 10:48 PM, Ralf Wildenhues wrote:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index c18bd32..3aac816 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -276,7 +276,8 @@ exit_if_skipped_commits () {
>  	if expr "$_tried" : ".*[|].*" > /dev/null ; then
>  		echo "There are only 'skip'ped commit left to test."
>  		echo "The first bad commit could be any of:"
> -		echo "$_tried" | sed -e 's/[|]/\n/g'
> +		echo "$_tried" | sed -e 's/[|]/\

Just out of curiosity, is there any valid reason to use `[' and `]'  
in this RE?  By default sed does not use extended RE (at least none  
of the implementation I know of) so why not just use sed 's/|/...' ?

> +/g'
>  		echo "We cannot bisect more!"
>  		exit 2
>  	fi

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-94--642915966
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHM4qEwwE67wC8PUkRAjH3AJ4wOCgkdUCCNCrr7cB9lR1AGrGs/gCgxiS5
Nvxhyt34HQ9A8iUf5NrIbkU=
=RiLg
-----END PGP SIGNATURE-----

--Apple-Mail-94--642915966--
