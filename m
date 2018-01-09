Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D491F406
	for <e@80x24.org>; Tue,  9 Jan 2018 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeAIP6R (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 10:58:17 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34850 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbeAIP6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 10:58:16 -0500
Received: by mail-pf0-f172.google.com with SMTP id t12so5999339pfg.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=6wpyqjjGXbS+bbGrSnv/FCbrWaPiEj8tCUc+zD5tg0o=;
        b=Y9NTv2TMWdjbMjlrFW/4sLp/s1Kt0nIhEietljF1t56F0SqQyp3Ud5OG5pD+l6K4cg
         u4R/T/NaZDBfpIx8swc8Fnx7cRFpIpw6+LyND7EREuufhgn8EGJEOUXxCjub4G1Mz4Oc
         EVgOgOnlKosiUtQYO5O6dLNREv8FGa90l6pbSX8ZDh138aS6d2nDWQJtFKvyda2G4Vih
         mhFcny4z5Js2Pv5IRc+lWnhO7a+AgnPYXcfBMlXD9fo32nfjKV6KRm9T/OhwqXt/aQrZ
         gtgP9bjFIkomAS0cIILEUMNGnIUAEkQQQft++G64I4NLIWseZorSXRvf1InlE9Zbj8dM
         ThJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=6wpyqjjGXbS+bbGrSnv/FCbrWaPiEj8tCUc+zD5tg0o=;
        b=MugUA0/vVTYgXNXI1YCH556z14g1tsOcvTJRwsD8VcEm+6TTVkO7KGDYM+0+rRfhgd
         4EYz/4paa9TjZg9vVbl6XNVSIDPM6cS1DYAH1pKK/gBaZYmNTcDDB1oe1A5uId/9gzX5
         g1xuvDjRgpZ6jOwdFpCVI2Z9k4BekW3UBx/b+OXawobchxECKCycA1WtMjLjDJX5u4xD
         H3TNX38GlHCadlAv5hblL7DBGQfHsugC9+Cs/OuFrSniP62XqHatQB8jiUkQmfoGUPGw
         wk+wR6JSGGPpnUW5ihGAaq7zL6P89GNSWnEtOeMpkRqv1XKWfpIslCMRXYMXS8oHITBQ
         loew==
X-Gm-Message-State: AKGB3mLNLmBHg3CD7en2xwFeyIRwzqLHDvgqDegGCNtGctCw207tfyKL
        aDa+EmY5EjJWQCuEyB64G33od+ag
X-Google-Smtp-Source: ACJfBouILXImCHgVTgJ/1pUSaSUEehiV3loKxy/Z4Pzbn4hzowUmf9oEvuzA9SPmFskfPX/G3lpAVw==
X-Received: by 10.99.99.4 with SMTP id x4mr11607853pgb.453.1515513496005;
        Tue, 09 Jan 2018 07:58:16 -0800 (PST)
Received: from [192.168.206.100] ([117.219.201.242])
        by smtp.gmail.com with ESMTPSA id i125sm30337728pfe.151.2018.01.09.07.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 07:58:14 -0800 (PST)
Subject: Re: [PATCH 2/8] Doc/gitsubmodules: clearly specify advantage of
 submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-3-kaartic.sivaraam@gmail.com>
 <CAGZ79kYyUcun4spUKVsOb+SucCe6=1cizrfH7hrFoyKteWZ_9w@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <19bb76a0-3360-65f8-4933-404addbdc767@gmail.com>
Date:   Tue, 9 Jan 2018 21:28:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYyUcun4spUKVsOb+SucCe6=1cizrfH7hrFoyKteWZ_9w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="twtDNZCnlLCfLV133aNKKTMTDwPMRLUDT"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--twtDNZCnlLCfLV133aNKKTMTDwPMRLUDT
Content-Type: multipart/mixed; boundary="l3Esbylqrw4GdHh1EIupcuErE7BNNST7W";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <19bb76a0-3360-65f8-4933-404addbdc767@gmail.com>
Subject: Re: [PATCH 2/8] Doc/gitsubmodules: clearly specify advantage of
 submodule
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-3-kaartic.sivaraam@gmail.com>
 <CAGZ79kYyUcun4spUKVsOb+SucCe6=1cizrfH7hrFoyKteWZ_9w@mail.gmail.com>
In-Reply-To: <CAGZ79kYyUcun4spUKVsOb+SucCe6=1cizrfH7hrFoyKteWZ_9w@mail.gmail.com>

--l3Esbylqrw4GdHh1EIupcuErE7BNNST7W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

>>        content that is not compressed by delta computation between tre=
es.
>> -      However you can also use submodules to e.g. hold large binary a=
ssets
>> +      Therefore you can use submodules to hold large binary assets
>=20
> If this improves readability by a lot, I'd be all for it. But this use
> case is just
> exemplary. There are also cases of submodules that do not contain big f=
iles,
> but e.g. have a lengthy history with lots of small files.
> So I don't know, as I would want to keep emphasized that this is just
> an example.
>=20

You're right I actually screwed up by emphasizing that was the only use
case it was envisioned for. Fixed it by replacing "Therefore" with " For
example, ..."

Thanks,
Kaartic


--l3Esbylqrw4GdHh1EIupcuErE7BNNST7W--

--twtDNZCnlLCfLV133aNKKTMTDwPMRLUDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpU5osbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpwQsP/0W51boDGbzGXhB5tb4m
7ute9RwcBdOsz1Uwqm3cFbWe/OIOEahka/gOSP+80Vb3DBfXl1itTll/Ips+qRsf
ePUKX7ENLIKGZY7EsdXve71Jc01rFzvQtYlAyoZMRuoQYh0emtYBIm0lsFBzR0zd
vH4cy/HZL6PGJn2Ms7E5gh92iohIWqOOr9L7Y2wIT0Epgk3yKIv1JAWi9SaAGLp2
MDRx0sPF3rIVEr4poil5OiypEhrk0ozMk70OBPkdpqfLWdU/lfx62FoAAOsZd6QD
7SBlGkMvjFaIR9Jw4sCUYc8og+6qKB+Nr7FLbW6cjlKr2wnu9h0bqAfe6tc7vAJ0
LjiUuKU6ERGZTk6DMxPoY+lhojXkedUA4oewC2IMWWEU1cG3f4swZQka/6XNaCgK
ebtDlKzSBpBnMUwsR0t2MHzWGXeXEBi95o9jY4GfWvCvbSilD3kBkN72aJWyylA1
U2JJ+Yzko5Mpu/CddyCpyy3El7PTZHI/nQO2n6QfbT99vIzkjYGC0rio+P0x7S3C
cJRB9rmwPwalzayGPpARzSr/9hwyHZbCQayKVpNdvP8PZTVkBJ612ZWX16EpErjN
QPPwpmjTRv+FdcbelmQiS2wbrua7YVnmcr/BdzP0/rq8Z/oZWME8o8Ia9BwgDfxn
2rnZ07gbL6o6+ywfEgwibE7I
=vzBB
-----END PGP SIGNATURE-----

--twtDNZCnlLCfLV133aNKKTMTDwPMRLUDT--
