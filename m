From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Stange diff in "mailinfo: re-fix MIME multipart boundary parsing"
Date: Tue, 19 Aug 2008 13:57:23 -0400
Message-ID: <48AB0983.2050706@gmail.com>
References: <e5bfff550808191038u645cf4baldca5c2c4bbd02162@mail.gmail.com> <48AB0805.1020309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB20C6E67CCA1455CC0888401"
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:58:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVTc-0002wL-1K
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYHSR53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYHSR53
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:57:29 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:60759 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYHSR52 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:57:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so11438and.103
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=/COSCrhwMJ4lLxmSOtx0izcINXQFAsu545UrCVPCce0=;
        b=r0P+hMIuYl8pIwZN1gYsQ1/Y4r88mzL9AzOrMws6VFOtpsyOdr1471v29/m1Vce6BT
         T0RYh35G/1XOIBgY3wwmY1IvU6iYW5P7VqR3C1IlF0UD0lUex8b0OfWzUBpyRFwOS1uC
         QQgleKCMq5o25dwvwl/HF63CHS7IaLoXvKsDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=PXkmMWw72ipiOrQcVMT6pxCXxFqEHlUC8ItagLcnSO0JxCrOzPYDU+RmyIvwya7+/M
         muXTWwo5G66wbtbdlQCk+yTyzwBw6gEW93iEDtF5gDLIUCJeM4f3Cc9/TUaOACdecjxv
         Xk7AimritsF3cx5EYsnUgqpbYTNnQ6XbSSxPA=
Received: by 10.100.144.11 with SMTP id r11mr1326465and.52.1219168647492;
        Tue, 19 Aug 2008 10:57:27 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id g5sm760520wra.14.2008.08.19.10.57.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 10:57:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48AB0805.1020309@gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92889>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB20C6E67CCA1455CC0888401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Marcus Griep wrote:
> It looks like an empty line added to the end of the file.
> Unsanitary, but ok since it comes after the last MIME
> multipart boundary.  Junio could probably just ax the change
> to sample.mbox from the patch before applying it.

Or I could have misunderstood the intent of the change, and it
is necessary to fully test the change, since it appears to
operate line-by-line, an empty line at the end would be necessary
to trigger the code path that stops mailinfo from looking for
another boundary.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enigB20C6E67CCA1455CC0888401
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSKsJgwPFruyc22R/AQJDdhAApry7KlPuoqTAASreUaftQqEzATymNWlb
1lmZr+NGtG2U+vIAKw5z+cAFXsZdU3otPSHK/3Te9xMrU4qwbR4FTgPYppNx/n/y
SvpfVPYG/d5OSL1WmGTA+Ow1yxt5m3BVgvFAB/4LYn0gis5pNbEShBPjd0kRcAOa
N03UbC8Nb9rcHPAw0r4hhRW30aZz13NjQVa8Wl1WIMuqSMVGAr3XyLar0ku3DOaK
q6lWJukPwqw+9fRe9eSaVv6FXMnD7P3jcLLfWQaYt0Sgbn1RjJkgYic/ipJLX2Ez
DhKxnlDFEpXBQjZBkUmD4ospJaEAOeHGw84cHjE8zxwqoegutHJwDvT2Vp4QBdG0
p0+RZr82nWBb9+apuc26dMfgEHxA+uLmdsiG+UwtkRGwP4K2rx0DwpliND0nmyyV
lSWObotafTOupQoVX2oHWldtJXDAtxTM6Pxjtu7RIp1scyymSlVhHezdTJQI2fiT
uVAvbJwAVXqD2UzatIsY5zdPgpqRqyH2ypl6kHC29V+5QRB8ilAzRg4DJT0ICxxx
s94lmIBbgPLDAHbQ66IUHiGpAOB0YIcsUcD9azk7vPhvxxEMDXZnMf2bDpSrjifq
pF9LVmLcGUCqnZF1vIEoBzV4aZYa0H1JEpznVcZ1ifcEk6tKS4hy1w/KhkdiBF8g
mnoaHjC+PDg=
=wari
-----END PGP SIGNATURE-----

--------------enigB20C6E67CCA1455CC0888401--
