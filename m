Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6271F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 17:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdAYR6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 12:58:43 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36757 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdAYR6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 12:58:42 -0500
Received: by mail-qt0-f174.google.com with SMTP id k15so29769803qtg.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gryk6sjZ1nVUdpbfmPyi8fmUChzXpVF6Q9JJUsCierg=;
        b=bJuJLlZ0OItrigaYvf9iS0IRYLT+pV6TgJUnPB2ESazH8zy/OuAD6PwgTpdtrTlgXr
         ekGvOu4xoNQMlf3TTOUPq+0w1bs5dgOuSNwfytAFKzFNomtYuU7mnomcM4AR/pTfpr3S
         wNNzuAG//BpUkZFJEtOXjqvsZj5+tVij3le/BwhpfhLl2DJJQVAY5+tGMBPxBV+Tvauh
         tUmnPfqVgIoGHgoXbnmG1GwTLfA2Lcw4Hv3OLDjtw8BgHZg8+hmHp7evP4w3vhKI9ZkR
         W1LFLawDOoGTCv7//137sQsUYAOwGYYJ49xGJe4OREiLkbCNkcWm+BUMJsdlQo8n7NF2
         P0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gryk6sjZ1nVUdpbfmPyi8fmUChzXpVF6Q9JJUsCierg=;
        b=EREz/rhec1zZHzeEq+dHtYgS/SP1N16zV4TrPGS3x4NH4WwODltGFJIrHsAdZFiHB9
         MfFASXR9wqNXk+Lg7NgwFbZ1+m4v5BEMc0kacv+IThExUSInvZWftlwaTRB4tYV4KLu0
         UR1Nn3Ymy1dagHw7K/wtTgqsxcdeyGRTGs5KlmnBLA0gf6M0pQrhuCKN+4CkkzOu0Tyq
         a4As/GyOwWj7h+j1bUh6AnqIMvv8CQmhAq5eCYu+G2bLXmhoQazFe3rfexc7+q6j3nHy
         I2dD7q0pgSF9sdydgfXxHHzi4m2QTgBRWwiOKoShjP78SeGrpZQsVqqHzqTfRIqXTF78
         DQXw==
X-Gm-Message-State: AIkVDXKNG0GA7uoxwekNFHhgzOeTqwV0ZqSPk41Pe1VoWCiy9NwKvEoLenYZ6rLK8j1vZWlg
X-Received: by 10.200.46.162 with SMTP id h31mr34141409qta.164.1485367121491;
        Wed, 25 Jan 2017 09:58:41 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-15.NATPOOL.NYU.EDU. [216.165.95.4])
        by smtp.gmail.com with ESMTPSA id h56sm19315595qte.24.2017.01.25.09.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 09:58:41 -0800 (PST)
Date:   Wed, 25 Jan 2017 12:58:40 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jordi Durban <jordi.durban@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone problem
Message-ID: <20170125175840.hy7d2f775dxnafpo@LykOS.localdomain>
References: <ef188364-ccd2-e7f5-3c06-62afca79f8d3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="voenh2y7sej4j5ui"
Content-Disposition: inline
In-Reply-To: <ef188364-ccd2-e7f5-3c06-62afca79f8d3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--voenh2y7sej4j5ui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, Jordi.

Hmm, it should've cloned in the "whatever" directory.

Can you post your git version/configs and maybe the output verbatim of
the command when you run it?

If you can reproduce in an empty dictionary that'd be better

$ mkdir test && cd test

$ git clone --recursive https://github.com/...

$ ls=20

Thanks,
-Santiago

On Wed, Jan 25, 2017 at 05:58:58PM +0100, Jordi Durban wrote:
> Hi all! Not sure if that will reach the goal, but let's it a try.
>=20
> I have a problem with the git clone command: when I try to clone a remote
> repository with the following:
>=20
> git clone --recursive https://github.com/whatever.git
>=20
> what I actually obtain is a copy of my own files in the current directory.
>=20
> I mean:
>=20
> In the current directory:
>=20
> $ls
>=20
> -rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
> -rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl
>=20
> $git clone --recursive https://github.com/whatever.git WHATEVER
>=20
> $ls
>=20
> -rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
> -rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl
>=20
> -rwxr-xr-x 1  1,6K set  5 13:05 WHATEVER
>=20
> $ls WHATEVER
>=20
> -rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
> -rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl
>=20
> I am really confused with that.
>=20
> Any help will be appreciated. Thank you
>=20

--voenh2y7sej4j5ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAliI50kACgkQRo8SLOgW
IpW01w//XH6oMyhpneNfdZ/iYrqbRY1aF75M2kFto0jQxfVIrDzMdKwWpcgARCrv
7XiAjHQtCLWhrHhz5rkfB2w5nGCrqY7tizAOj/YXHSicTFufmAClpAhUx9okO6J6
oQbvT1cIYBIXecCikrBClNvdlK8s9Z4LLkJTj7f7VnDpjlEL1jsVqN2TnmjmdhmT
QMRPDJ2BO55jwpTOh8jOZzft/EJvqKD1fnEV4X6WpVp37gRFeA45wHSfLd3WTa1P
5+XqCps5ytIyHqghdXHzWZP2v6dyDfM2TcvfFf+IABUGS5NoS2PvPaytXGlxmIGD
XIXq4ce5tUeNtFBB5BjBc6viM1cdmPdQ48uWA+4oV1V+MpxWo9pWIact7ob6FLVG
2kGEc7qCWqF7ELiwkM8O3iqicjAqzhWqQynZ0Zk98a6dDCofbsdYd5BAb6CMaQmi
Bat0UBLRPkg8/N4LLQ8ny/AlZtFRA8gXesyKjTU21iSx/7hT+CcM92V17YeTARV4
oOWm61TYg+2NIogbVh7JldtNsav0lSMerc3e1w4wW+kW2fEI6DQgpcgFnRB8+aUH
W3K10WBTi8RS4Q2nc2T8LF8NWs9N5KKwEJ9PngcVrxhSeGGTMUaGaIvjnhyHVAa9
BMjjas5C7/CQtD9NJVfutQoPYKjEH/xF9QEXaZRcHCi9w6A+LYU=
=pVw0
-----END PGP SIGNATURE-----

--voenh2y7sej4j5ui--
