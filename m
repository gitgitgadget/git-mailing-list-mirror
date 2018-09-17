Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C5F1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 11:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIQQuy (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 12:50:54 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44292 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeIQQuy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 12:50:54 -0400
Received: by mail-ed1-f42.google.com with SMTP id s10-v6so12544909edb.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dRgMVGoZthiXZIGkZ4HV6OmHO+EW29JXFQPi+Y1Pong=;
        b=nwtL+BLVVhs5UnVEDh7JVBPHqqWhzbY3jaL9sdYNsC6QBpsUjSMIqznf5AWBDEbRgi
         FMRrUfM96FHziUw0STLsG2wDNKJsZd8Qdg6tpokqZ+z/n4w5SWxGkelDYCCsj/dyjt4E
         xS29p0y8Cu6uOToNX0IhDJrDuOgHwc7WkbcNK/qK2OAuUBOjkUq0WDFRGObz4iTlU4JF
         mDS7hOqn/xSzXOrBDBIUU/d+J3FQFXI5KqwYHOY2NCZC54JDpuG3YiIPcxCLcAqdPQdx
         gEF5PQYAB5Em1lb4vIuDiTsAU6MCnIgRDg5F0tN1HA/iUpSzp4f+9et6kgZy4svsdMaF
         imAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dRgMVGoZthiXZIGkZ4HV6OmHO+EW29JXFQPi+Y1Pong=;
        b=bhqmKr6oizKyVCKB+2xLB4YdxmN8/3VwtzBD6zybiAYt53Ed1ANs7wgbObE40I96fg
         Ei+sOoRyoL14ifJae/3KlfIRkQjqTyIQ/x2wqZjFwjKuS4cqVLbX1wvREttzG4PEIAqC
         IZYGbgnIGOKBUxAn+KvVZXR1hJuVjfe/DfJm7St3KMSnSrBdyiR4NBEZQlKf0oKKXbfW
         a1i5JNrtDpbBW0vghOU4v0APaZqBMNJswYS0u9Dvd7MuTCSQG1vYCPrHcPH2BLxBd0lk
         JbSQjnNqghwnIYzzlOfnhwF4MNaL8Ez9msJLz1W3OKa2k/jOrJ8s87SZmedn74/0Ak5U
         r7RQ==
X-Gm-Message-State: APzg51DSVjsPetLV++aSDYak3HL0b3Mg6nVZsHuqg8nJNqDz0Gjr0gS0
        vUvFAufFqHkh99U6OP/1qcI=
X-Google-Smtp-Source: ANB0VdaAWuTgAydM2hWwKuAsTxkDEYniK0sBsLRPkwL4czaCx/ujlIVjNsNkb8+Nobd42yNj0ayvNQ==
X-Received: by 2002:a50:8f84:: with SMTP id y4-v6mr42452016edy.71.1537183438797;
        Mon, 17 Sep 2018 04:23:58 -0700 (PDT)
Received: from localhost (92-109-79-134.cable.dynamic.v4.ziggo.nl. [92.109.79.134])
        by smtp.gmail.com with ESMTPSA id z56-v6sm13131164edz.54.2018.09.17.04.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 04:23:57 -0700 (PDT)
Date:   Mon, 17 Sep 2018 13:23:57 +0200
From:   Chris Coutinho <chrisbcoutinho@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question - no space in smtp-server-option
Message-ID: <20180917112357.7ajxecgw3hkdklzu@tumbleweed>
References: <20180917010244.btmlczam5m75rmto@tumbleweed>
 <20180917011657.GD154643@aiede.svl.corp.google.com>
 <20180917012721.akyclbcmeqw5dv3x@tumbleweed>
 <20180917015324.GE154643@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wpr542ov64fwzkfm"
Content-Disposition: inline
In-Reply-To: <20180917015324.GE154643@aiede.svl.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wpr542ov64fwzkfm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep-16-18, Jonathan Nieder wrote:
>On Mon, Sep 17, 2018 at 03:27:21AM +0200, Chris Coutinho wrote:
>> On Sep-16-18, Jonathan Nieder wrote:
>>> Chris Coutinho wrote:
>
>>>> Currently my gitconfig contains the following line:
>>>>
>>>> 	sendemail.smtpserveroption=3D-a<myaccount>
>>>>
>>>> Whereas, the following results in an 'account' not found error:
>>>>
>>>> 	sendemail.smtpserveroption=3D-a <myaccount>
>>>
>>> Do you mean that your ~/.gitconfig literally contains that exact line?
>[...]
>> Yes that's the exact line in my gitconfig file, which correctly mails us=
ing
>> the non-default account I'm after - I'm assuming you're noticing the lac=
k of
>> camelCase? To be honest, that came from zsh autosuggestions, which are a=
ll
>> lower-case for some reason.
>
>No, case shouldn't matter.  I'm noticing the it looks like
>
>	foo.bar=3Dbaz
>
>instead of
>
>	[foo]
>		bar =3D baz
>
>(i.e. it seems to be some syntax other than ini syntax).  E.g. I tried
>
>	echo a.b=3Dc >test.config
>	git config -f test.config -l
>
>and get
>
>	fatal: bad config line 1 in file test.config
>
>Thanks,
>Jonathan

Hi Jonathan,

Sorry for the inconsistency, you're write about the gitconfig syntax. I=20
was actually printing out the config using `git config --local --list`. =20
The actual config file has the two lines:

[sendemail]
	smtpserveroption =3D -a<myaccount>

Regards,
Chris

--wpr542ov64fwzkfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgByWpgIJZOpMvgTGINFyBbymYXQFAlufjs0ACgkQINFyBbym
YXSQYw//S5cN9Ce/xekhFEN5twko4nnwERdkKZBPbEfYpvhYgjvf4TRyTfGwf6ik
8ElaGBCdPx2itxvo6RmZpSow/HnXdjQGA2Af23/9Ix9w42CWA+v3dhm4XGLLUo5d
WbbFgYVItWPGn0eTton7NqQ8YdXGiJVOMMtK//LeKslgKXdI7lvO5GymOHnRQOFy
HTI9lIew2EOeb3XQuamuv+Jl+QM21ULWBDY/uVHiUfoRsOuNCoVI3I/9HyCJr/Za
PZnO1qHDTrnD6ZHzERKGbzQFgP+O+l/U19K5HlS6bpUrV9wYCIG10zUH2x/lJIVH
AfOGy5dJyk40V54rxBFIc+vkIcD5EiCdl2XQuQb+Pyka9jBgMzQw3XPfxhHFApq5
ufx3VOmX/Y+PTfoL47RXaOSm/Up/xonExbxDUsiG8M28REc/JgZd79U3Ikq5zwUz
ayMcLHQzhZAW5OUuviNUAcKgQ7eRqaTP/Y2ueb3WMHkoGTvwidLKBZkQA+WkQe5X
u/MKGpe8ZKM2qrFTd2KbGxREpO1nNTEs4tCdYD2BMGs4cQ3mWfvdfJAfjBFRJoui
Vp98Idr4kem3IX0SKttbRYbfyWqlp886XxNymaXklZopkJKKezk1Jm8oN9QdBOP3
yGd6LjTIrptRR3XAhTz/Au62U9rYTcM/k9VcuXJFX7H8/VEgECE=
=MD6O
-----END PGP SIGNATURE-----

--wpr542ov64fwzkfm--
