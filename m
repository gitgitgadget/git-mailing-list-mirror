Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14A8E9413D
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 01:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjJGBH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJGBH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 21:07:58 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF4BF
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 18:07:56 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AEFF85AF6C;
        Sat,  7 Oct 2023 01:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1696640875;
        bh=yumXsLkaG+pG429b9mWdKyKjIDeteSnw90+76gzKEsc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Eg2SsiMYOCL2YvhH194gBAOBU9R6Umkl4jLVZGeMoD0opgmhos4j/nUMpOwCL3G2v
         4npeC7fccJzimIE6ml0bhYar6OoNJfkQtrt+cM5MDGLTim1nkCv3+N2TPWJjSyKS1g
         xGGPqoG+1C6UakLhFUkTXB9FR4CUcmYKe8uD5ngiVQycWxgo6YhbFSVoN7GKkLhF3Z
         1tiTUyySeNOEQdkUFxk3Pdj5UxbtljPTLpET3ysbaXmw8KYfLKiJ9Uegyox9hVdxbO
         MZDoyjD4g00HMzAF9z3P4fSwIAVrCPAcX8sjUkqjD1e2gNPvDuK/J5V+7NjZ11hD/y
         E67Z5DpL7HFip6y0Hqbs8bFPxTeQbaIFtsUai+By8Bl8Ym8gERkhGtPjEkvrJC8wup
         MAZKxc7+pQcPYjSvpIJ67e/xPO2VLnPQjLer0rR8paZqPQXJ6J9ebdbryP02wX5CC4
         2eXPQIgcWrQWv2LbH6czXhTqcijDryO5oQ6pVy1v+MJCuR14moa
Date:   Sat, 7 Oct 2023 01:07:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Rolland Swing (Insight Global LLC)" <v-roswing@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Anthony Chuang <anchuang@microsoft.com>
Subject: Re: Microsoft Smart App Control - Git - git-bash.exe File Unsigned
Message-ID: <ZSCvaWuPJ1peZ3KF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Rolland Swing (Insight Global LLC)" <v-roswing@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Anthony Chuang <anchuang@microsoft.com>
References: <SJ1PR21MB36990080CCBC0BB415261D82E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
 <SJ1PR21MB3699CA030DE035CA42582AF5E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
 <SJ1PR21MB369933C2C879EAD0D5EAFBD1E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTHqFk2yG07Cq/GJ"
Content-Disposition: inline
In-Reply-To: <SJ1PR21MB369933C2C879EAD0D5EAFBD1E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hTHqFk2yG07Cq/GJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-05 at 20:41:39, Rolland Swing (Insight Global LLC) wrote:
> Hi Git Team,

Hey,

> We're part of the Microsoft team that owns Smart App Control (https://lea=
rn.microsoft.com/en-us/windows/apps/develop/smart-app-control/overview), wh=
ich requires applications to sign all of their executable files (exe, dll, =
msi, tmp, and a few other file formats).
> =C2=A0
> We found during internal testing and/or from user feedback that your app,=
 git-bash.exe, is not correctly signed.=20
>=20
> Block Event:=C2=A0=C2=A0 FileName: \Device\HarddiskVolume7\Program Files\=
Git\git-bash.exe
> =C2=A0 Calling Process: \Device\HarddiskVolume7\Windows\explorer.exe
> =C2=A0 Sha256 Hash: 42F2E685686FB6356A195709AF912C7B9D424466BD7C6D69258AA=
DA5E80AC3C2=C2=A0

The Git project doesn't distribute any binaries at all.  We distribute
only source code.  Many distributors compile these to produce binaries.

The project you are probably thinking of is Git for Windows, which,
while related, is a separate project.  They do indeed distribute
binaries, and this looks like a binary that's theirs.  If you'd like to
contact them, you can use their issue tracker
(https://github.com/git-for-windows/git/issues) to inquire.

However, I will note that a cursory search there found
https://github.com/git-for-windows/git/issues/798, where the maintainer
points out that there are over 400 exe files and 250 dll files, which
would make signing them all excessively burdensome.  I expect the
upcoming requirements for HSM-backed keys for Windows code signing may
make that even slower and more burdensome.  That being said, perhaps
with automation, the maintainer may feel differently than they did in
2016, so it might be worth asking again.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--hTHqFk2yG07Cq/GJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZSCvaQAKCRB8DEliiIei
gTjGAP9i9vJdzqiV6UmeTgRD3PVwKybNdI/g6HVSEzw/y+Z5xAD9HGPqqaeDo5bC
YOFjtd8FM6zlBEf9S0hm4h86KhrXtQQ=
=dLaW
-----END PGP SIGNATURE-----

--hTHqFk2yG07Cq/GJ--
