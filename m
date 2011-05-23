From: Grant Limberg <glimberg@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Mon, 23 May 2011 09:18:20 -0700
Message-ID: <34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com>
References: <20110522114917.GA19927@arf.padd.com> <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com> <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--704697862"
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 18:18:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOXpw-0007q3-2F
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 18:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab1EWQS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 12:18:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57178 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab1EWQSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 12:18:25 -0400
Received: by yxs7 with SMTP id 7so2160161yxs.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-pgp-agent:x-mailer;
        bh=/eydGgGm76OaFbISgDZ/GHuZ/sZSHz8sUuC2nS4Ucag=;
        b=b1NFxUAiLMsk/P7C4E/b5qEA6J5UQ81itsZNe3RkK/l684klN0hSntQDiQl0eKbkF/
         55D3Abo0aSrpDcs6LNFaKrslczHMQjEW1M9PFXVisZb8cX1XiQNiQop9jFKrgpO8Y68A
         Y8ki273uXmqHsy59IZR+TD5DDl81+ihlwZu08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-pgp-agent
         :x-mailer;
        b=RVe/H0X5hFwmScjHzrPXMdZ1IZmFX1TV5AtJpp2RHk5NETruWbyQOR0+AWyNupKf5C
         sTtQ86s3VJlZEJzhWJPihCxmeZO7/0LM90vngIBHzmM7Q23yY5EEYbgyuge7fMwUNdJ0
         ei5MrOQlIxkvognN8k8dAzbUQ9VE9V5zkBbHg=
Received: by 10.90.204.13 with SMTP id b13mr252149agg.180.1306167505034;
        Mon, 23 May 2011 09:18:25 -0700 (PDT)
Received: from [192.168.169.66] ([12.186.225.162])
        by mx.google.com with ESMTPS id w1sm4885036anh.10.2011.05.23.09.18.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 09:18:23 -0700 (PDT)
In-Reply-To: <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.3.3
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174250>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--704697862
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii

On May 23, 2011, at 3:54 AM, Vitor Antunes wrote:

> Hi Grant,
>=20
> I think I saw that happening when there is nothing to import or in
> situations where the parent of a certain branch does not exist.
>=20
> Perforce does not strictly require branch definitions to allow a =
branch
> structure/flow. It is quite possible that you are integrating stuff
> around without using "branch specs". When git-p4 is importing your P4
> database it will look at all branches available in the server, =
including
> ones from other depots. So it is possible that while you are seeing a
> big list of branches being processed, none apply to the branch =
structure
> you are trying to import.
>=20
> Could you please confirm that you have Perforce branch specs for all
> branches that you are trying to import?
>=20
> Thanks,
> Vitor

Vitor,=20

The "Branch-foo" that git-p4 is crashing on does have a branchspec in =
Perforce.  I cannot, however guarantee that branchspecs were correctly =
created and used for all integrates in the repository.  It was created =
long before I started working here.  Is there a way to limit =
--detect-branches to only certain branches that I can ensure do have =
branchspecs?

- Grant=

--Apple-Mail-5--704697862
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJN2ojMAAoJEH+RGVrhASuPEbwQAI896uGEm8X0BtdxTgXh+YUh
rl7hPvf6HGdS1vhtCSw6xiq3JX6x/odJnyn0BBvQBTvm/UVwSM90uok3C6E+DIpK
/3ZnK1hJKZhc4OuYNBJQjWwnAVn97cz/o6ur9r90SlVSs8/h2owJkSgXL6v9Bfjc
os86rJtMMxAK9jmYef8MRS1+27o2ODCpsQA8Pg4DUs/SYkpYXJFwuCN9PRGA4F0e
S1TKhXdui17FEVJkasd+lhrqfT3IxTZ317vYbGqRdjdx0tL76zcyYH/TigGO8Yuw
C3vtwweNXOKKKHt2EC3Yrab2pqnob8qSUBotC/GZZVjC1dIxBvDrxHIWKZYVI/wc
f7QfzklgF76zn7s04GDaBqs/RbXW+FttxjE4EJsP4TYa5XFHQ3oCuXZXZKdmJqbj
UguAs1cKluMqNGvsSmiXchBSLI7ndQ/fPA2koNzeu0Z+wskngwTy+nlwJjkVJJUE
mApmdLlcmUtL6SOoFWH49gPPWiigdSQLKAhzVVIIYtX9fGxizD0sjMlwlHuLnOw6
Rf7EJt/YFv7/dTqgI1gkKwCseoPCH6wbSArLW//eV//4PCR28iX58XixXJrZ8llO
FhihW9vE3DicYMHzGLpMi++B1FinBDXN1iNYTs+eY2LSxa3bLu3xBMDeV0Q/0qZ/
jDm+pTgfUJnpkFgQKdkl
=7VjU
-----END PGP SIGNATURE-----

--Apple-Mail-5--704697862--
