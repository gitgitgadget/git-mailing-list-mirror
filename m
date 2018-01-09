Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEDC1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 16:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934414AbeAIQhq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 11:37:46 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:42479 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934406AbeAIQhg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 11:37:36 -0500
Received: by mail-pf0-f176.google.com with SMTP id d23so8916095pfe.9
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=htQfNoZdeO2EIPl26Rl1V1GDshJUCinoksZThgut5JU=;
        b=PvyWn7e2VoDOD0GndOntNOu3zmEiSzDF6FcWcYInhr+Ey9uNlVy4yhhygBLcY82wKw
         Th/j7QVFINmzUqfUT0tvmLXN9Q+jl4NMpKNUF0VQbMTnBIBLerVkhIJD5RJ6c0rwUvq/
         FbZkTPg/KsAQDcXtxVnJrA/f+tZ7AAiLm7z+3/1A4xtIL477Mvam2I6EZ48OhSvjnuXa
         XMrD/l3IEk5IOGvuuChUb33vzhdmMb/sIcPWfsWziwoENEDOt77fW/7PnGQjfl6S5ike
         GaoKuJEQSP72e4TIDA7NLI9nnz/tDaKCl8OfG9P+l9EYKI8L91OJD16ocrFoGLmohDKi
         eNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=htQfNoZdeO2EIPl26Rl1V1GDshJUCinoksZThgut5JU=;
        b=m7SBjCdl4be1Rd9+49xAv7cmWxfrgloqEc5GsLmBGsfv2GtdUlvUFQ/if5DMZWznZ0
         9KKNSP2PjCJd6+TpnCdbqzobmLjLszOzh8q0n/l/zutvtK+5Yr3WWW7uIltgeC2lxl89
         uCLKmQdl3J7KY1DznhXwTjGfgru+3OGNGymCNgIEeveX3VASW4n6vepfzmadaU0jIBOo
         JZBoWEfH+UtbpIKeWOmy2tXO1LGPhHqwG63DynYzx9lAjLJ2/rTvwbXqdFIQ1GojaALk
         GKk5lTgI7viSKoizIZSuX3q5TuByCsvAGWnund9QObL+2UgU1/GXllZqBrvHq02fZuC0
         Yv8Q==
X-Gm-Message-State: AKGB3mKJW8CSHoyLrdv1drXVf6XWWnv+Zl8oGegud60yZ7JPOti4V0jL
        2WWzJLatFqpnbS8pZ0lm2bNzG817
X-Google-Smtp-Source: ACJfBoti0ZN9S4HyyylhyZxomFxpbvmGRVtS1JFmKvYbOCqntB8k1nCSTefBr8ESNZXsuH4aDbb+4Q==
X-Received: by 10.101.96.2 with SMTP id m2mr12812492pgu.119.1515515855645;
        Tue, 09 Jan 2018 08:37:35 -0800 (PST)
Received: from [192.168.206.100] ([117.219.201.242])
        by smtp.gmail.com with ESMTPSA id a22sm35123945pfc.47.2018.01.09.08.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 08:37:34 -0800 (PST)
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain
 lines
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
 <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <f82949ed-5dbd-eab4-d917-8fe675b1c517@gmail.com>
Date:   Tue, 9 Jan 2018 22:07:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o1VBanXi4pfskxoBQFm7foSeKxAG34twA"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o1VBanXi4pfskxoBQFm7foSeKxAG34twA
Content-Type: multipart/mixed; boundary="KpCfMXLkloKcjgoja2uKSRVSsNuPmosgk";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <f82949ed-5dbd-eab4-d917-8fe675b1c517@gmail.com>
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain
 lines
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
 <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
In-Reply-To: <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>

--KpCfMXLkloKcjgoja2uKSRVSsNuPmosgk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 January 2018 12:19 AM, Stefan Beller wrote:
> On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>>
>> - * The command line for those commands that support taking submodule
>> -   specifications. Most commands have a boolean flag '--recurse-submo=
dules
>> -   whether to recurse into submodules. Examples are `ls-files` or `ch=
eckout`.
>> + * The command line arguments of those commands that support taking s=
ubmodule
>> +   specifications. Most commands have a boolean flag '--recurse-submo=
dules'
>> +   which specify whether they should recurse into submodules. Example=
s are
>> +   `ls-files` or `checkout`.
>>     Some commands take enums, such as `fetch` and `push`, where you ca=
n
>>     specify how submodules are affected.
>>
>> @@ -90,8 +91,8 @@ Submodule operations can be configured using the fol=
lowing mechanisms
>>  For example an effect from the submodule's `.gitignore` file
>>  would be observed when you run `git status --ignore-submodules=3Dnone=
` in
>>  the superproject. This collects information from the submodule's work=
ing
>> -directory by running `status` in the submodule, which does pay attent=
ion
>> -to its `.gitignore` file.
>> +directory by running `status` in the submodule while paying attention=

>> +to the `.gitignore` file of the submodule.
>=20
> Both are grammatically correct and expressive, thanks!
>

You're welcome!


>>  +
>=20
> Extra spurious line?
>

No. That's a "real" plus in the document that's usually present between
paragraphs :) I think I now get why Junio suggests people to review
patches in context (possibly, by applying them) ;)


>>  The submodule's `$GIT_DIR/config` file would come into play when runn=
ing
>>  `git push --recurse-submodules=3Dcheck` in the superproject, as this =
would
>> @@ -107,13 +108,13 @@ If the submodule is not yet initialized, then th=
e configuration
>>  inside the submodule does not exist yet, so configuration where to
>>  obtain the submodule from is configured here for example.
>>

I caught this in the context while replying. "so configuration where to
obtain the submodule from is configured here for example." doesn't seem
to read well. Maybe removing configuration from the sentence will make
it sound better?


>> - * the `.gitmodules` file inside the superproject. Additionally to th=
e
>> -   required mapping between submodule's name and path, a project usua=
lly
>> + * The `.gitmodules` file inside the superproject. Additionally, if m=
apping
>> +   is required between a submodule's name and its path, a project usu=
ally
>=20
> This changes meaning, originally it tries to say:
>=20
> * it requires mapping path <-> names.

I get this ...

> * but there can be more.
>=20

=2E.. but not this. Did the previous version really try to say this?
Anyways how does this sound?

  * The `.gitmodules` file inside the superproject. A project usually
    uses this file to suggest defaults for the upstream collection
    of repositories for the mapping that is required between a
    submodule's name and its path.

I think it conveys the "it requires mapping path <-> names." correctly
but doesn't convey the "but there can be more." part. I'm not sure how
to get that into the sentence, correctly.


--KpCfMXLkloKcjgoja2uKSRVSsNuPmosgk--

--o1VBanXi4pfskxoBQFm7foSeKxAG34twA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpU78EbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlp2XMQAJnfQAMxlE6K8RxbXbwO
ZZ4ASCZf19tXIKl1WPq+F+v9W8M8/avAbKP7OKciC2QjYgFX5T9n/+4ttRN/Fpqa
PN8JjoVuPBlBmBEV6WLay+tnQwT0o8z0QssFN2ln6UcwQ/NFGXeRdF7+TqOfLVhs
3dQPUazg8cAL7VTP0nJiwBf+z99iT+JGeRn0GS2/baLggo5DKEpgaUXJ43/0jkCG
upt28JpetAsT8Tje7FHfmjVa83CFvPu61I2DvDFGONx8yEHfgX5m700EKFWhP+/N
5W49x2Tp/KdHIMXruwMPNsCKQVk0EpAbsN5T8UX51mWUjMw9VXAojfXO0GPxCGNP
Sk5Xh9P75wdgtoWHCnv5fmDvyfdzTCs5W8UOqUF4bnBi5wYv0NlNYPoBx0qtrjjX
gm3z9Yo4lFNGwAgb+g2pzypufK1ScwqEhYBH1VF6GmGD27JtR3q5p6DHPYj3JEoz
Sa887pEsUX9xFfnLaQChUe7FraORxI44SeqqfSmx1Yj5IV81yVpk5UxvRru9zNxu
7s+p437aeeNY8NTkCqXkgdxe2knWKgKy8fqKJcoHumrsf9b+bcbUJutdXxDY9xYI
9LKokVb61QlAcazTRu1EwuAs6pCdokZM1PCeh5b6tM14ZVKq2BGYaihBlRQIDz3R
2kZWcfeuPFextZ0pl1RL3p0Q
=jXk5
-----END PGP SIGNATURE-----

--o1VBanXi4pfskxoBQFm7foSeKxAG34twA--
