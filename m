Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8D92047F
	for <e@80x24.org>; Thu, 28 Sep 2017 05:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdI1Fbu (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 01:31:50 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:55146 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdI1Fbt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 01:31:49 -0400
Received: by mail-wr0-f175.google.com with SMTP id g29so626284wrg.11
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZI1znMeOoiRO9cLkY+X3IrAGcdurnUQL9O92B04fG4E=;
        b=hCfAlqvc93dXbUfzYgB0PTF5VUDAC71ngb524tn3b/61Im5e3C34QK47v7xCYf5j60
         Iz1rs9PRxe834HCxnqx83yznjwoAxfA9sa1jrqfxJdpYaz/9yCg45x8m2oqJRpS9IbSE
         Z+NmYBm7FkTYuJfwkJ5y31NJS2h2sKvCF/L0EveTBBwa0nEj8Uj/l1xX0UIpcY/+T91G
         jsnRPr6gB9JxLpyg9S38ZuEU9VW6OGJiDb7Fqapk0H9oVDGLpJl1xpHgg5+/J+l9JxNN
         f+Vo5HDGNc/rjpsoBCiTcbT3SnY3Z4lXVQaAWED125Nu07l4c9BfT+AViZQGcEZx4npg
         M3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZI1znMeOoiRO9cLkY+X3IrAGcdurnUQL9O92B04fG4E=;
        b=uQNnwbu5cR7Cxr0fzKorfZnhptRvFe2YcQu5w9h/Ny8mfdaIAIFrWjbNzKsbaXiV+i
         u7ruZIn/KhlbWB44Frep0W0s6u9vI5wOrQ3WWm6xKQETkz6JngtalC68eWlgXUeHwIFy
         8xlEl+B3sMCAWbUjkjpNiYmbmMLpPzRN6OzUfAjOjdrmXWi32w2rpUvWPD6NCdhr74eM
         78MyVdOO8I6ff0lzGhBk0YavPrR73aO5TCF6N/ekGJ3VTk7XtHiKar0NJkJzjRf3huYA
         R6RlvNV689tU45rhL1c7T4OWFwDXW6eaggA05UruzbVqB5vXjtKQ+4qzwa/Jc6zXEw4x
         Ztiw==
X-Gm-Message-State: AHPjjUjyS+b+sk+CSpEezbCz5mAsKkAAMgDzsokYD/HsojWvbqhBP1US
        ICEHhrgmivKfz7R9Ba4gWj0=
X-Google-Smtp-Source: AOwi7QDcXHhNDOIPXL1CUeEQpE3BFPz9bm6APNcTHcYM8Etx0AXOJhowFT1GfgKOY+AZRHZr2SQZ8Q==
X-Received: by 10.223.186.201 with SMTP id w9mr3209604wrg.230.1506576708353;
        Wed, 27 Sep 2017 22:31:48 -0700 (PDT)
Received: from [192.168.1.100] (p57bfaa82.dip0.t-ipconnect.de. [87.191.170.130])
        by smtp.gmail.com with ESMTPSA id y39sm1602768wry.70.2017.09.27.22.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 22:31:47 -0700 (PDT)
From:   Toni Uebernickel <tuebernickel@gmail.com>
Message-Id: <A96CA99A-B2A1-4CC1-ADEC-128211C88B57@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5291EC56-1C14-451F-90F4-58C54CE09D5F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Date:   Thu, 28 Sep 2017 07:31:45 +0200
In-Reply-To: <20170928052043.vh5wyecibe3cujwp@sigill.intra.peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To:     Jeff King <peff@peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
 <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
 <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
 <20170927195159.GE19555@aiede.mtv.corp.google.com>
 <20170927195310.GF19555@aiede.mtv.corp.google.com>
 <21387D23-F581-4179-969E-823FEF82C405@gmail.com>
 <20170928052043.vh5wyecibe3cujwp@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_5291EC56-1C14-451F-90F4-58C54CE09D5F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

That's a very very old setting :)
Honestly, I don't know why it's "always". I have set up this setting =
years ago and never thought about it again, as it worked out.

I changed it to "auto" and the --patch options are working again on =
v2.14.2!

Thank you very much for your time & efforts.
If I can be of any further help on this matter, just let me know.

Kind Regards,
Toni

--
Toni Uebernickel

tuebernickel@gmail.com - https://keybase.io/havvg
https://github.com/havvg - https://www.xing.com/profile/Toni_Uebernickel

> On 28. Sep 2017, at 07:20, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Sep 28, 2017 at 07:03:55AM +0200, Toni Uebernickel wrote:
>=20
>> color.ui=3Dalways
>=20
> This is the problem, and Jonathan's guess was correct that 136c8c8b8f
> (color: check color.ui in git_default_config(), 2017-07-13) is =
related.
>=20
> Re-reading that commit message, I'm inclined to say that the commit
> isn't wrong, and that setting color.ui to "always" has always been a =
bad
> idea. Of course, I also wrote that commit message, so I may be biased. =
:)
>=20
> What led you to setting color.ui to "always" in your config?  The more
> usual value is "auto" (which is also the default these days).
>=20
> -Peff


--Apple-Mail=_5291EC56-1C14-451F-90F4-58C54CE09D5F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqtw0WfnqbGj2qtYvvngIZvYDXHoFAlnMiUEACgkQvngIZvYD
XHrDeQ//XFP0eUP4tMO2MnvBXbOQZU45U4rGxVTmBvYLZ/mdL13/OqC+6rxEtN91
eGdwC4ejdqfS7AIBybk4skrugIR8mwkiB8CG9a3pr2ksTICKvOp/4rFHDNTFRlIo
bvihLcXD4DOnan8rBtpzO36HUh5CTpMOvVYry5tGy5e4t+g6gOrKaBILV19yO0xX
awL9tw2AAUYYxYQauHpItqHNAxqli3A2g+DzvobFgw2SeBrULQiOOxgR4xoGYzoQ
b0NjLDrsQE0W6AiX3UKiWDAkIabqhTkjbHITNL80HGQYFmJPt2HLywMhtIt0X4uY
YbEz7NmE6yVmck0dEJAaQ7WFmIN3C9dJ9duq22Iqu8FKBYy6+THJdNytakz6koV1
EUPsPaTytDG64FjoF58rL9yoZtLlaHgKcItqH295sKjGciqb7RArr7HOtAzN45+z
uIY0fzxMliqYE8r1jcNmBKEkmtFK2LzFteIIYxtLZK8XjYiUg7gTdUiD3Toa97On
DTyKZBwFSg5o70utA6plC3h84PhXABLYmHlXISC2E+G9w5N3/hnm45apQNIK7wZb
5Mfo+6DazSp0Yc9imjCRmazm1xFukdfMNOtZgJdozqnI+/7FlSkEd8KKZXxaXdJM
eKeo4CcTsXk20m+wonWLrnPSfzjjKDiZHhuOc3f13kp3tbqRu7A=
=+WyB
-----END PGP SIGNATURE-----

--Apple-Mail=_5291EC56-1C14-451F-90F4-58C54CE09D5F--
