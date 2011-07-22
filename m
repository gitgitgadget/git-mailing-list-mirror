From: Adam Monsen <haircut@gmail.com>
Subject: Re: .gitattributes not forcing EOLs correctly for a CRLF-ending file
 on *NIX
Date: Fri, 22 Jul 2011 08:56:27 -0500
Message-ID: <4E29818B.40707@gmail.com>
References: <4E297C5C.8030104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig938B0A5724EDE67FB785E7AE"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 15:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkGDX-00013j-Ve
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 15:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab1GVN4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 09:56:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42586 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab1GVN4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 09:56:34 -0400
Received: by iyb12 with SMTP id 12so1996640iyb.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type;
        bh=coN0PtaH4FX7JMdhLSQGxZzncm+upjErNIHzQ+gYB/s=;
        b=FNWepTbCnkVdeJyen7kw1F6R1neBnzT9damqbneyn+vIv8A9iNAKtNEB9TCcsuISDT
         McQnoc66+NBYG15PyLgk9JtwnaeWleZ3LZE4D13iL+tBnugviPv67qmYcAVBK85EeV5l
         O4P3NWV3dLm0VAFzr0sRHfa9zBwhftR6xcejs=
Received: by 10.231.42.155 with SMTP id s27mr1347665ibe.68.1311342992955;
        Fri, 22 Jul 2011 06:56:32 -0700 (PDT)
Received: from [10.1.1.119] (mail.tri-county.com [72.164.238.234])
        by mx.google.com with ESMTPS id q4sm1646315ibb.15.2011.07.22.06.56.30
        (version=SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 06:56:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <4E297C5C.8030104@gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177645>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig938B0A5724EDE67FB785E7AE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I wrote:
> Anyone have ideas why my .gitattributes file isn't working?

drizzd on #git helped me out!

I went ahead and committed the file, and git replaced the line endings.
drizzd said the repository (the file object, I guess?) contained a file
with CRLF line endings, instead of LF line endings. But in my
checked-out version, I correctly see a file with CRLF line endings. Yay!

I generally follow the advice at http://help.github.com/line-endings/ in
terms of the core.autocrlf setting.


--------------enig938B0A5724EDE67FB785E7AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOKYGLAAoJEJtdmT+DbynAtyAH/3lRQqR0Jp6SQfd9lF4EvwkZ
IOZp3KdAj7+TQoGVy09RTeItzKQmPVlvQHXx66n9Q7YtK2znJbzzoAM/D58Nqwnv
gwwkt9mo6+rWzCDHG5skJMCEvo7uBrQu4Tmf8YcY9O5rBJqg/3hbRGv8Niw7xwxR
aIlLUOsoA/DuVwzdrKOD9kAMsa1vhygnOU5qNl7o7ov8em0AEoJYcWaTBEwBiRTP
qLMtLo/EDxjIgNabXjc/S2R+oKozrgQSTezIk2CAAC/byYF1R9uSgw45HNDj/WNC
E+gVCfpnNWWGHT8eVpaqaY0dku145A4yL7bJPcbsF5Bze6u7td5zU2uK8sNag70=
=5kQQ
-----END PGP SIGNATURE-----

--------------enig938B0A5724EDE67FB785E7AE--
