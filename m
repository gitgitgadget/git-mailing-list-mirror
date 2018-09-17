Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A34F1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 11:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIQRGu (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 13:06:50 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37984 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIQRGu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 13:06:50 -0400
Received: by mail-ed1-f53.google.com with SMTP id h33-v6so12604575edb.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGgWrnKDxkJTTc5pI+65hahQWW63TeIQMM15JxqHAFA=;
        b=OLdF7We34cn6YCfw0CQqdVJIjCLj2KNoQvRSNOqBMXEKD4M7PwtjVzlbWoDA1fpcIe
         bas9HGrE9KskW31TCUjRI/4SHR8Bm32draB8Sl7G/pYDWARHw/FBDaDMTtBvul7T82g/
         zsElM6gWtkigMv23jyDYM2otkIW6IcfHyJ69Oyo3kwmn8BCaMQXCxcDa6N5Dh6ZPk4pS
         iNoq7F0xKL3hRza0f1EJnDWSv1YR2VH9g7ilXU/T8emGZ0kfXlc40BGMZRj39UCOTYqW
         L0g0jwtoQ4UOOmfM2k2RVqRqZw2dkbmTlq14Rpuh1vHfl+NahdBhu2rp9+bH9uhKHtJb
         GeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGgWrnKDxkJTTc5pI+65hahQWW63TeIQMM15JxqHAFA=;
        b=D3s6kFCvMR5XE6AtkOnRzu8o4F0rDBo8oIsxHdmNykmkmr1aDJkFL7TvNuFF94xGcs
         L+LHFO+CA1nXDkvaVzUqKyLez/uEve/nJ7hcAf1bwDSuVtJSHq/RT9GvslbxqKELYZX7
         fR5AxAmG03BDN/0MKHMiElyb7MpquX8/wrBiVJMU80bGfzlBeiXkFCrsuw6110/5tiwY
         Yne1gSEgv+jc3hdmOCaDBpoawzEffS2jxaTe8vV71nl0lcYJtgWvvNfLJz8K3C6Rm+/e
         VKx6ESVBVEiqoN1jltNx3b+kSi04WoYUbfedeuJVa2z3102VaWeCXIe5RlC7oORa5IYc
         6+cQ==
X-Gm-Message-State: APzg51AGsKjVqI5sNEiYyZL/FymLJGCMl+KoOyectRUHemrGik8xl/3D
        RmY2136c24hPRbeUESERrEY=
X-Google-Smtp-Source: ANB0VdZkoUKQruGNo6Q6f88N826UWfAqDswT7aGPkKwSSfVtvvKEMTNSts1lZ/v/0sIgIPaceT1c1A==
X-Received: by 2002:a50:ca83:: with SMTP id x3-v6mr40238787edh.287.1537184392065;
        Mon, 17 Sep 2018 04:39:52 -0700 (PDT)
Received: from localhost (92-109-79-134.cable.dynamic.v4.ziggo.nl. [92.109.79.134])
        by smtp.gmail.com with ESMTPSA id x32-v6sm8385770eda.81.2018.09.17.04.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 04:39:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 13:39:50 +0200
From:   Chris Coutinho <chrisbcoutinho@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question - no space in smtp-server-option
Message-ID: <20180917113950.b6oosxhscutrrafh@tumbleweed>
References: <20180917010244.btmlczam5m75rmto@tumbleweed>
 <20180917011657.GD154643@aiede.svl.corp.google.com>
 <20180917012721.akyclbcmeqw5dv3x@tumbleweed>
 <20180917015324.GE154643@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pd6zyy4pklr4ectv"
Content-Disposition: inline
In-Reply-To: <20180917015324.GE154643@aiede.svl.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pd6zyy4pklr4ectv
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

I realized what my issue was when looking closer at the documentation -=20
the smtp-server-option needs to be included as separate lines:

[sendemail]
	smtpserveroption =3D --account
	smtpserveroption =3D <myaccount>

I'm assuming this is intended behavior.

Thanks for your help,
Chris

--pd6zyy4pklr4ectv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgByWpgIJZOpMvgTGINFyBbymYXQFAlufkoYACgkQINFyBbym
YXRMWg//SsBS3JBtfACN5/UNBxA8LB9WKBjY9tdDUEbBBfCjVWV7i5HEMRszhbm9
1e9ZBxE2Uu2Ijew9fuqXynlrkcWsQDhHGXJ0/qI0pD5jf3hSSS+P7v2CaToSJvDj
RuZBZVfK04tGmg8YGlDvM8zGb2p4u3buNmipRA7Zj1pj1HIEx8ynKoMNP1HG2HGv
VvfT3PfX5BsgOeYpTocDaK1mDvntr4ClGo9oFmxetiCY3lBciB2FbWtlRgpk1KNB
8v2V3c7fZ4L2NUw+JdYBM3Tn0QlMhsp2+WnY2hUmKewp/1HQM6OExvIc/OECMzcY
sAY4D934JozgVGMft0vhmKTF1OImp9uKhinYcQx+f4FSp7uBlu3JSpFCrxF1W6tF
ymirdRhLJJwmxQE3T+LVB54Uwsrgf39JG6KW5vqhvrkSGPLMQm7987+NPXvarzsw
R4YJEvZynO0C/c+N/+klCtFkxpQWMzLGrbBj6sfNLV05GUAP/LJ5FiNkSfBnfYa0
2GQkqKqc5gTs2bQ2Kw/+9qLpN8ExAFs4hH3g2ZjO1IGSkY4C+vViwvlD19z7u5L2
DtXARTzEp/CU05+qhp4EtIdb4xiGpI636FODvripr5cRcJ0OeJv6dzLAI4J3tqFE
ruzB8p9Tt514D+tGJhk+F+m92V62iqu+AsAYCNeDilK2IT6wqto=
=2/zR
-----END PGP SIGNATURE-----

--pd6zyy4pklr4ectv--
