From: James <purpleidea@gmail.com>
Subject: [PATCH] Add --recursive flag to git bash completion script.
Date: Sun, 08 Mar 2015 20:00:16 -0400
Message-ID: <1425859216.8244.40.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7b33dLWyfarj3p1ywwgK"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 09 01:00:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUl7R-0006TX-OE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 01:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbbCIAAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 20:00:21 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:41709 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbCIAAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 20:00:20 -0400
Received: by qcrw7 with SMTP id w7so1404123qcr.8
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:mime-version;
        bh=8+tuchakq2H6gVODwtwkv3SmG1DuBocQzvFD5UEkeQg=;
        b=F+++o+yRJRjV2HpzLygQeoEvPL+9Y6SE22WO5n6P7033jL2eycTvXZdB7PTrCnoUYU
         +mbp0Ldlk0TUZ7TgfaxehrFX0w1cJNw38AdBxAh2cwVgSvozJ1HnECOBqhzdtCaZLNeP
         iopRnJ/ShXdyyCPHmaoZ1potgwl+dR8MjkgJKrfid5HtSH3r1qAGfoiI02Bf3BUMXGBc
         +AxSmIHDhSAIMvciB4vhlwCoqqaNFwOjOeX+RS+jcFkL5hpcJBI8jPv4Q3fuJKWce7Rx
         0YB7FTiqNg9KxA7KGGrexTI7cHd//Yap0DeY/GiBBal8Tyhp5GN+7WC7eRpd2myJ58PE
         /xTQ==
X-Received: by 10.140.27.129 with SMTP id 1mr31278121qgx.64.1425859219614;
        Sun, 08 Mar 2015 17:00:19 -0700 (PDT)
Received: from freed ([216.252.90.33])
        by mx.google.com with ESMTPSA id c99sm7249393qkh.37.2015.03.08.17.00.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 17:00:18 -0700 (PDT)
X-Mailer: Evolution 3.12.11 (3.12.11-1.fc21) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265120>


--=-7b33dLWyfarj3p1ywwgK
Content-Type: multipart/mixed; boundary="=-Uc4C0wDEzx01UJiy1VhI"


--=-Uc4C0wDEzx01UJiy1VhI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a patch to add a much needed option to the bash completion
script. I'm not subscribed to this list, so please include me in your
reply if you'd like me to see your response.

Thanks,
James


--=-Uc4C0wDEzx01UJiy1VhI
Content-Disposition: attachment; filename="completion-recursive.patch"
Content-Type: text/x-patch; name="completion-recursive.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBjYTk3NmRlNWJmZWNjYzliZDY5YzIyMTgzZjgyYjlkMWU1OWQyNTQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBTaHViaW4gPGphbWVzQHNodWJpbi5jYT4KRGF0ZTog
U3VuLCA4IE1hciAyMDE1IDE5OjU3OjE3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIC0tcmVj
dXJzaXZlIGZsYWcgdG8gZ2l0IGJhc2ggY29tcGxldGlvbiBzY3JpcHQuCgpUaGlzIGZsYWcgd2Fz
IG1pc3NpbmcgZnJvbSB0aGUgbGlzdCwgYW5kIEkgdXNlIGl0IHF1aXRlIG9mdGVuIDopCgpTaWdu
ZWQtb2ZmLWJ5OiBKYW1lcyBTaHViaW4gPGphbWVzQHNodWJpbi5jYT4KLS0tCiBjb250cmliL2Nv
bXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9u
LmJhc2ggYi9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaAppbmRleCBjMjEx
OTBkLi42Y2I3ZmY1IDEwMDY0NAotLS0gYS9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRp
b24uYmFzaAorKysgYi9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaApAQCAt
MTA5MCw2ICsxMDkwLDcgQEAgX2dpdF9jbG9uZSAoKQogCQkJLS1uby1oYXJkbGlua3MKIAkJCS0t
c2hhcmVkCiAJCQktLXJlZmVyZW5jZQorCQkJLS1yZWN1cnNpdmUKIAkJCS0tcXVpZXQKIAkJCS0t
bm8tY2hlY2tvdXQKIAkJCS0tYmFyZQotLSAKMi4xLjAKCg==


--=-Uc4C0wDEzx01UJiy1VhI--

--=-7b33dLWyfarj3p1ywwgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJU/OKQAAoJEKDo88AkCQ1madkP/Ah/RquozrX5tq2Jk+VWb1GT
z5RhTlZFz53MIuRi7ZiVGA/AVzquIpF7AA/v77c+anQoYOpCQ90lF4uAhbQlxLQZ
juybgtlwUK/9LxURIPzKkG0ClEoJZ///5/9pwelhFURrJV8dmyGPgWB0/f3jKjVS
8uruGtMuFKRfKalZhZWUolTS5nKVton1/MUK3BwuxLZdV0tT+mQQ1nSBI4J7CEpe
S89TnEDKDdTAL87vGxN/aB/PSv8Tb8TN7RqpKioUnO2Gz6gmiqJ2+XWatYlM0/U/
yYjLDz2iGpMCBzbkb2STitwcp1cIkrwSvOBKLGRhhi25cK7gWgT0z/9NELthNFAX
6nF5jMsKHGIxDsKK6mTFiCiSit9ejkqT5iKAHwLYG2q0sXJGRGQTqY9JPg8X5ijC
D4lfLyr9gQUEywDI0Q/sMir8tUneUUDH27zhdRBLSo3sU2lO2jhdUyWZGh1CMHY9
+c67PEZLqSyyWWsPYLMJ64vhw7usuurMJ0OifAU6oH1eX/fbcwZd+ldIhYVGVqa+
387zm4ZL9+/gWwIUPm9iix/75n6ZbdbBWf9K9yTSrWek0Gdcv0rH/ovlLGKzOlbq
uJ3iIajBT2zLZwYPKqqYG2DdX+5/WftH2VEgGLzseyyMkaARiWT6Q9luhzfkXdpy
NDBgmPDfgQuOBMvlqPj/
=0p0z
-----END PGP SIGNATURE-----

--=-7b33dLWyfarj3p1ywwgK--
