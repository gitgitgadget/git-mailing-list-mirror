From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: git push <branch-name>
Date: Tue, 5 Oct 2010 18:11:44 -0400
Message-ID: <201010051811.49211.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1478251.MIj7GZuW6q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 00:11:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3FjP-0007yh-MQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab0JEWL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 18:11:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43294 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab0JEWLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 18:11:25 -0400
Received: by wwj40 with SMTP id 40so6271283wwj.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:subject:from:date:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=VsfgdS5EBMzjBbeoK2wR5vicS0Wvd3wteaZiBPTXr3I=;
        b=G9bvlfuWgJLOl1592TGu7/sbgtaNoRPjGvFadI45AB/+XjacW0hho2w28/X8fuglxg
         s5H6fT/9cijHt5zu4dOOu1agZrdPvBiexWKt4JkimtcWBoK+2HLPi1aSbS/YK+INS6xi
         gSKY8kCjYhOFJ2GLYynWF2wABrzDmP6C6mGA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:from:date:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=jSQGDiRQ7CMAnJD0I2QfGc7hqRf7CrNdcYphURD/VH5AmN04dYrMxyx4w9LIqC8AQ8
         abG7k42fRre6SpfTmEdse0BjennlqhH/cJ/gdL3EHnfBveMzsdR7KXmxOUfoh/0qucG1
         YQoOt94MkZVg59pzp0lqEa1RXVL4vqLdK82lI=
Received: by 10.216.182.202 with SMTP id o52mr9828218wem.29.1286316684264;
        Tue, 05 Oct 2010 15:11:24 -0700 (PDT)
Received: from hyperion.localnet (hyperion.student.rit.edu [129.21.115.231])
        by mx.google.com with ESMTPS id w1sm61514weq.1.2010.10.05.15.11.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 15:11:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158253>

--nextPart1478251.MIj7GZuW6q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 October 2010 16:29:50 you wrote:
> A newbie colleague asked why: "git push <branch>" didn't work.
>=20
> Although I know that "git push <repo> <branch>" is the correct
> syntax, I think that he has a point.  If branch.<branch>.remote
> is defined it seems unambiguous to me.
>=20
> So I can't see any reason NOT to dwimify
>=20
>     git push <branch>
Isn't that syntax reserved for remotes?
for example:

git push origin

I feel like it would be a bad idea to have these 2 types of invocations=20
overlap in syntax like that.

--nextPart1478251.MIj7GZuW6q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyroqUACgkQhP2Vm0oJTtzT9wCeMfm8Injhrr2bpm7kxOvPibPh
fVoAn3aE2rryY8vdOFr0Vg0jbSy+J0Ig
=dayE
-----END PGP SIGNATURE-----

--nextPart1478251.MIj7GZuW6q--
