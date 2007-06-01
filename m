From: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 1 Jun 2007 16:50:09 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706011650.10650.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <7vsladzp29.fsf@assigned-by-dhcp.cox.net> <87zm3ju6tg.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1825970.nMSe1gMC7X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 15:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu7W0-0001TZ-7x
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 15:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbXFANt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbXFANt6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 09:49:58 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:51957 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757362AbXFANt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 09:49:57 -0400
Received: from southpark.local (unknown [85.97.19.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 1324A6022195;
	Fri,  1 Jun 2007 16:49:50 +0300 (EEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070508.662491)
In-Reply-To: <87zm3ju6tg.fsf@wine.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48866>

--nextPart1825970.nMSe1gMC7X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 01 June 2007 16:45:31 Alexandre Julliard wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > I would say that the patch is an improvement from the current
> > code so it should hit 'master'; I was a bit busy lately and then
> > am sick, and also we are post -rc1 freeze now and I was being
> > cautious, just in case some nacks from more informed parties
> > arrive late.
>
> Sorry for the late nack, but it turns out that this patch breaks diff
> output on the Wine server for files that are not utf-8.

Isn't UTF-8 default even for Linux kernel now?

> The cause is apparently that decode_utf8() returns undef for invalid
> sequences instead of substituting a replacement char like
> decode("utf8") does.
>
> That may be considered an Encode bug since we are running a fairly old
> version (1.99, coming with Debian 3.1), but I'd rather not upgrade
> perl on the server. Could the patch be reverted, or done differently?

Sorry but thats too old. Of course I am not the maintainer of GIT so its no=
t=20
for me to decide but well as David Woodhouse puts it, please join us in 21s=
t=20
century and start using UTF-8.

/ismail

=2D-=20
Perfect is the enemy of good

--nextPart1825970.nMSe1gMC7X
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmAkEke9qviWcMsnAQLeoRAAsSD8sGbChlZAZr67/nOGkAn1SGfvt8d6
v3sQzYv5d8HVqmN5bXirrTKj/4M+1DecAUXYkp2U6CgsIwovY3N4J/gslY+QxG0Q
Mnnxx2SytfhK7zR832gYEuE0nSiyhxmJ9kRF2gb/TOxl+8qvbToDzxgGof3t2iRS
wopiHQlRqfntHqRa8szd/2kVjTfKZD4BUBjdi9/Ivhu+Wd/Rtcrr2r4Tzi3P08oS
zKjRnsmKWfBLTGF1U1BvcjSDxXcafBPLwjs+xi5yYGicCA6wqdvltEC+FK52sN34
ZYXR9fe53ALe3TnhcdKPBOgTD5fe2XdR5atKUaC1D/fd4vsToijMR9E1fKlqPOl6
ZjE3Sxn3Jdykm3IQDXQXrQWehMe80FBFKEmPTDTh/CAuo645ihKECg5o5HbCDOTa
/xv8LK2v6D9DqZzz7cJpu8YafC75KHTl3Mcvao0andB3qm5T7kq+NXecS08c61ys
CuAL2MGlNScGFe89qMw5zcEV/yFUar3MmEaw8M2QrFUGzPOFl1x/bGVnNA8i1z4l
2uITasCXeppprQBQfPwVygj4T/rim5LZyPHH0ArC4PIhXkq0BwjdwkezlThcYa8E
8UqSbcWKaFdQsrGZrbXeXdrm+A75mR2R0sgMaIhEOh9TO9luEE+hgJh/ynx7qS7W
hpnM513wD6U=
=8aVU
-----END PGP SIGNATURE-----

--nextPart1825970.nMSe1gMC7X--
