From: Grant Olson <kgo@grant-olson.net>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Sat, 01 May 2010 13:25:15 -0400
Message-ID: <4BDC63FB.7060202@grant-olson.net>
References: <4BDC45EB.8090305@grant-olson.net> <4BDC561B.4030307@gmail.com> <7vhbmr5ym4.fsf@alter.siamese.dyndns.org>
Reply-To: kgo@grant-olson.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A483BCB54C14F559F595419"
Cc: gitzilla@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 01 19:25:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GRg-00075K-LL
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab0EARZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:25:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52563 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0EARZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:25:34 -0400
Received: by vws19 with SMTP id 19so896088vws.19
        for <git@vger.kernel.org>; Sat, 01 May 2010 10:25:32 -0700 (PDT)
Received: by 10.220.108.198 with SMTP id g6mr8880332vcp.202.1272734732046;
        Sat, 01 May 2010 10:25:32 -0700 (PDT)
Received: from [192.168.1.182] (pool-96-235-50-222.pitbpa.east.verizon.net [96.235.50.222])
        by mx.google.com with ESMTPS id i29sm14668533vcr.0.2010.05.01.10.25.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 10:25:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vhbmr5ym4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146101>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A483BCB54C14F559F595419
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 5/1/2010 1:18 PM, Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
>>
>> Why not fall back to just the email if the full lookup fails?
>=20
> Thanks; I like that suggestion a lot better.  Grant's suggestion does n=
ot
> make the lookup "less fragile", but actually makes it less reliable for=

> people with the same address with different spellings of name and want =
to
> choose which one to use per project.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Unless I'm mis-understanding you, the does the opposite of that.  It
finds your gpg key based on your git email, ignoring your git name, so
that different spellings of the name between gpg and git become irrelevan=
t.

--=20
Grant

"Can you construct some sort of rudimentary lathe?"


--------------enig4A483BCB54C14F559F595419
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJL3GQHAAoJEP5F5V2hilTWhcgH/0QtscbEsJZDWVvz8Sqy+VG6
Iu44TPWRHMMgxSkmLZZ318w6ll7epEA7iDhME6pfjAJGAufnRf74hQi5jyv2+G2a
YlnFNT1ZqAqm01fKdN+W1Prb3Iva+boim3K1/Dkqg0ep+XusxHsJf7UbpHvZcxb7
uIQ7XAlIX9hyEk40hOc6gewViAC4Zy/GjOe9IwcPOGbEFPk6dF3C0fa1RyjuUpZE
FrZ3B0n7MkjNbNj30J6pCKrGGQyAA6ovxPc6msAzV7GjXKxQVVDY0vQ4OooN14sN
8qesBYT5wdt50p1BLSd7I8cqOLpjFRfb+CgCNoSzHXE5X1TdfPgVPTh3kKtBHzg=
=/Gfi
-----END PGP SIGNATURE-----

--------------enig4A483BCB54C14F559F595419--
