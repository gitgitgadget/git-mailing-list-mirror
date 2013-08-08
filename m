From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 08 Aug 2013 23:35:35 +0200
Message-ID: <52040F27.4050908@googlemail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88E58AD41438F2DCAF1211A8"
Cc: git@vger.kernel.org
To: Justin Collum <jcollum@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Xru-0001Ej-9D
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966733Ab3HHVfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:35:34 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:62539 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966702Ab3HHVfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:35:33 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so1368951eek.13
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=vSuMutRS9g7Adx2HvZESKr1lsDrs/INvibyf6UqSoxM=;
        b=IL9GLghro6xo6+NarQT1OVEuCFLjztGXlaSoFmhtI2g/lHY3U+QQcsOSDEfcrZyyzB
         2AmpQRbq5T0Gsr/52sLePKIRbR6iIO7rV58uECJCDtB1A/W0lnW9pQMZ/MdY+ajJ3viB
         lsUXAO3+abOyaCOZwR3QoTz4vi/Zm5L3K5zc0k5pgESd26OjYOiXOooKz7f/eRpKHMke
         2eUFKT/9Vx8R7SZuaZricMgvOft4CmFVz340EHhqajiHexXbUAJLcrlKVnETH1rxiQVJ
         hiXb2wc4Nne/tp7aiW0mLnd67Ygi4NT4iDLcZyGy77qXVuiG40vZUhImN4oa5eEbGVSz
         +DnQ==
X-Received: by 10.15.81.129 with SMTP id x1mr10191829eey.82.1375997732660;
        Thu, 08 Aug 2013 14:35:32 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm22806678een.16.2013.08.08.14.35.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 14:35:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231936>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88E58AD41438F2DCAF1211A8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 10:27 PM, Justin Collum wrote:
> I've run into a strange situation with git lately. It seems that
> anything I do involving git will alter the permissions on my index
> file to the point that I can't do anything until I re-add the
> permissions on the file.
>=20
> Looks like a bug to me, is it? It does seem like this has started
> happening since I moved over to 64b Ubuntu.
>=20
> $ ll .git
> total 156K
> ...
> drwxrwxrwx   2 dev dev 4.0K Jul 23 09:30 hooks
> -rwxrwxrwx   1 dev dev  17K Aug  8 13:12 index
> drwxrwxrwx   2 dev dev 4.0K Jul 19 09:31 info
> ...
>=20
> $ gs
> # On branch build-0.3
> # Your branch is ahead of 'staging/build-0.3' by 5 commits.
> #   (use "git push" to publish your local commits)
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> # scripts/loadMongo.coffee
> nothing added to commit but untracked files present (use "git add" to t=
rack)
>=20
> $ ll .git
> total 156K
> ...
> drwxrwxrwx   2 dev dev 4.0K Jul 23 09:30 hooks
> -rw-rw-r--   1 dev dev  17K Aug  8 13:16 index   # <---------------
> this line  <-------------------------------
> drwxrwxrwx   2 dev dev 4.0K Jul 19 09:31 info
> ...
>=20
> $ git --version
> git version 1.8.3.4
>=20
> Ubuntu:
> Distributor ID: Ubuntu
> Description: Ubuntu 12.04.2 LTS
> Release: 12.04
> Codename: precise

The permissions are set to reading for all and writing for you(r user)
and your group. This should be no problem with standard git commands.
Before you had the index file executable, why would you need that?

What kind of filesystem do you have? (The output of 'mount' would be=20
interesting)=20

Also what exactly breaks? ("can't do anything")=20
What commands do not behave as you'd expect?=20

Stefan


--------------enig88E58AD41438F2DCAF1211A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBA8nAAoJEJQCPTzLflhqUm4QAN2qrJtAMp/Ct5Ijzd0MqNta
GxkSFxajBxTLZ4TdX0wCjC/tGXPlSDGLvIKI0Oq4wMya1eAhr4zvll1bsBz3qwJu
cRM1Nwb73S6kgkCHAlOWxHfGNTQIyfEaMBbBLU0X6k+HM2vr5ZfqGuROQVrD/hGq
y9KuxnfgN37k1J4zXrE5cjKaNGBqoSoMakQ+DHmCTwN6NnoBoISh1XcOTCrVTfW0
UEk9SafLV9QZvJBvlJCVcuq45qXzR94hQGN7BKbhyAVHCzgxudrgXX7KECfR3AVK
qA7WDJ4FtjIIV06KTd3iH1h3QWmGbVnz1Sxvp//Ssjd6facckyn2x0xvuYocL3gM
peNC+gZRUNYdlkB4GIP39jeWmyI6M3S5/4tjEvCUrIRnaElC0RGyJCoSckDOqzi1
+/U1CqTN0L/yvAAOz4AWY34io7JvFWAvEBW/KEWEFzOarCs8rZGGzlzniYwm4rvi
5P3IgazHopv1j7eCwzqzFWuFLcKm+ZsLm9k2K0qMYeupXPoNYuaSAa10wwlVbUgR
9BDifxgAmtgh0bT0shYMJmdVmPaLq488Rajzhe0Ic+6qjpAgp9HL7cJtNSDatRDt
xFpZ0C7CrMKuchqMkEc81iwQL1+2Tb+Katpd0b6Mo8NS165e/ryz2+br5n5CraL4
UL34KPLI8GPg0ag4EOua
=WU4L
-----END PGP SIGNATURE-----

--------------enig88E58AD41438F2DCAF1211A8--
