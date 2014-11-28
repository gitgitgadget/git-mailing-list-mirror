From: "Timothy M. Redaelli" <timothy.redaelli@gmail.com>
Subject: Force git submodule update --remote for some branches
Date: Fri, 28 Nov 2014 18:54:57 +0100
Message-ID: <5478B6F1.6070200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0SaQUHRdLB9qeol9qCgu34jj9TwGDI7H9"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 18:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuPl9-0002bU-BW
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 18:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaK1RzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 12:55:05 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40077 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaK1RzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 12:55:04 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so21756596wib.5
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        bh=jRxEo5dLmkAUJ3W+J3M084n17HmoxF9NhcHWgnZTSls=;
        b=VlKqc1mf7L+tuyfotOeDcGhirieRfAAYJZLEDRKOqNVfdXYTL1am3y515w7L/Ia5Aj
         0ANZscXiDhf1VBJs5l+hjZjmWECHq76NSEPCalvKsUdLNtM+gdRWl6aI7+vIGY0D89Ga
         16fQRh1OAsy/Eu8hU9f30a+hGvrl4fSgk3cOjmMlUZ/Ocf8hwgGPwI+tkZNeHIRjMnp7
         djw6z0ZacV+NMeSwAbgIX6t8WpAeeI1mHvr36BhHi6fa58ypKcdmNg3s7CaWuTrpHozE
         OPTd44alp3gJQ8J+E/I9ihatnj9bHxSmusL35Bw5ei/PgtCfUSsSxiDrMSrhl3x09MY/
         fQbg==
X-Received: by 10.180.99.163 with SMTP id er3mr61706655wib.18.1417197302627;
        Fri, 28 Nov 2014 09:55:02 -0800 (PST)
Received: from [192.168.3.101] (93-57-16-194.ip162.fastwebnet.it. [93.57.16.194])
        by mx.google.com with ESMTPSA id bc1sm30461637wib.16.2014.11.28.09.55.01
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Nov 2014 09:55:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260372>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0SaQUHRdLB9qeol9qCgu34jj9TwGDI7H9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
I have a repository with a submodule and I'd like to force git to
checkout the LAST version of the submodule and not the stored one (like
git submodule update --remote), but only on some branches and without
the need to remember to add --remote every time you are on this branch.

Is there any way to do it? Maybe using .gitmodules?

Thanks

--=20
Timothy M. Redaelli
Arch Linux Trusted User


--0SaQUHRdLB9qeol9qCgu34jj9TwGDI7H9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCgAGBQJUeLbyAAoJEOcRMG48T4i8BNMIANErPJPJ458RH3Ljtpl7hgD3
aMBeasVAGoCdDaadUWJFDt2sD0SCX8LJXfeg7uxL1pxN9JFcVG4y+OYrRCZV+4CG
1375MblQ1kzYESXh6JkV1lEi2OoZQQvHYd7i05kk1ZykOq52el/dJv8IQUOnWKhl
iucb/NkJ7Qi/GdztpNkcNT7qLchTgryKgBNKcxV7a+NidXXK6NsoDoCLO7zYoJ+X
SGOk6VPLvYskbV2sGJw8TvsnOarm48h/XpRJC/t+sLbLKJqre1ARk/qRu5xVv8o5
/bNwxyA6GQ2gzE9KvxjGu+OEIz2r6eg177xHb+ze60QRgI6boSw/M1HBgzgKEc0=
=WWZ8
-----END PGP SIGNATURE-----

--0SaQUHRdLB9qeol9qCgu34jj9TwGDI7H9--
