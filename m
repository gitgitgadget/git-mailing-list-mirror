From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: Re: [PATCH] difftool: silence warning
Date: Tue, 21 Aug 2012 11:42:14 +0200
Message-ID: <503357F6.2020907@gmail.com>
References: <1345532358-11742-1-git-send-email-rosslagerwall@gmail.com> <CAJDDKr5W5YJoMEkX7_ax_pvwdibJ81LMzsM0Rnkn1=9=Nu25EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig1F2470D737BAEB31B02482D1"
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 11:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3kzQ-00063E-8V
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 11:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab2HUJmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 05:42:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62035 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab2HUJmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 05:42:38 -0400
Received: by eaac11 with SMTP id c11so2316286eaa.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=JfDoK2YDq5chI8Nvq4bIM13S8teiDrK4Yg+Lal4aOwM=;
        b=LroMzoARVHKtgcjzqGPe4IHKsLHQ3OjNjodEU6rPLOh0tqNVtBe+goAWbhpMLH0IaE
         r4AOMuLBqhfWDXtWazHyahXePrR7n6rmun558AkpAGrVtnEeyDKvo8sV1/Vr3xG8FshE
         jwin+DqxePm4TYkbIShHlxbmBpalIwspyLCn8ScH6RlU6cvvNDfn8xL2ADNSLE9vXmVZ
         +JHLm3xA3SmZOl4BGPS6i8lEaSDFCTZyfq8JnAwxpVzYpa/V93zrnZJYO/z/fM2AZUFK
         p6+jQP+eCitNOQm9ttMuRfLtsZ6RU+w3FLvxqTboqljdHj3LPZuqPuTSsBKXbs2gVYj+
         3caQ==
Received: by 10.14.204.72 with SMTP id g48mr12634936eeo.45.1345542157287;
        Tue, 21 Aug 2012 02:42:37 -0700 (PDT)
Received: from [192.168.1.2] (41-135-222-205.dsl.mweb.co.za. [41.135.222.205])
        by mx.google.com with ESMTPS id u8sm2756014eel.11.2012.08.21.02.42.33
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 02:42:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <CAJDDKr5W5YJoMEkX7_ax_pvwdibJ81LMzsM0Rnkn1=9=Nu25EA@mail.gmail.com>
X-Enigmail-Version: 1.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203958>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F2470D737BAEB31B02482D1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2012 11:04 AM, David Aguilar wrote:
> This patch is obviously correct, but it won't apply in git's "next" bra=
nch.
> Can you please prepare a patch based on the version in next?
>=20
Sure.

>=20
> A small question on Perl style for the list... is it better say this?
>=20
>    exit(0) unless $diffrtn;
>=20
> or is it better to explicitly check for undef using defined($diffrtn)
> like was done in this patch? I would assume that explicit is preferred.=

>=20

It seems like defined() is used throughout git-difftool so I just used th=
at.

Regards
--=20
Ross Lagerwall


--------------enig1F2470D737BAEB31B02482D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREIAAYFAlAzV/wACgkQMRWWudUHn2QsjwD+JPRXN7yuYCAVGz0e2YJf3JDp
puVSBf7xaWnOB6ZNIIsA/1IUHdJ89xs5mMrJ9/kl/PrENyLqxCvZYj2NMyXha2k+
=Q66g
-----END PGP SIGNATURE-----

--------------enig1F2470D737BAEB31B02482D1--
