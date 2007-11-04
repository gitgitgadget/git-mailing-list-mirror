From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] user-manual: add advanced topic "bisecting merges"
Date: Sun, 4 Nov 2007 14:50:25 +0100
Message-ID: <C6820C23-1727-46B5-80A7-BD8DF8C3EF92@lrde.epita.fr>
References: <11941677732664-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-79--1018822670"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IofsL-0006SL-W4
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbXKDNuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 08:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755614AbXKDNuk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:50:40 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:36569 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbXKDNuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 08:50:39 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iofs6-0001Wm-4l; Sun, 04 Nov 2007 14:50:38 +0100
In-Reply-To: <11941677732664-git-send-email-prohaska@zib.de>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63402>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-79--1018822670
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 4, 2007, at 10:16 AM, Steffen Prohaska wrote:

> diff --git a/Documentation/user-manual.txt b/Documentation/user- 
> manual.txt
> index d99adc6..480e7c1 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -934,6 +934,95 @@ Figuring out why this works is left as an  
> exercise to the (advanced)
[...]
> +
> +Imagine this history.
> +
> +................................................
> +      ---Z---o---X---...---o---A---C---D
> +          \                       /
> +           o---o---Y---...---o---B
> +................................................
> +

I don't know how you chose these letters, but I don't find them  
particularly intuitive to remember.

................................................
       ---B---o---X---...---o---Y---M---H
           \                       /
            o---o---T---...---o---Z
................................................

would be better (IMO):  B stands for "Branch point"
                         M stands for "Merge"
                         H stands for "HEAD"
                         T stands for "Topic"


Otherwise thanks for documenting this, the patch looks fine to me.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-79--1018822670
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHLc4hwwE67wC8PUkRAlEbAJ0RARHAFYb4y9cMRsonqb2Ipm60VQCeMLrR
5rWDOXYHuHYl0qAGEbjRigg=
=LGCw
-----END PGP SIGNATURE-----

--Apple-Mail-79--1018822670--
