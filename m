Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E481F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeDPPHi (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:07:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43202 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeDPPHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:07:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id f132so2814445pgc.10
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=5qYmh2aYYCQUqnXqjSO/21jnrrxiAFwQma+K/DlZQCY=;
        b=Gs8EOsfuW4shGV3hnfpdbcjEaUvmozSSgVBNXxUEqQ1gbxysgDQ4X9JhlNn9CoHdki
         GerOn1oAwAgdsdceSQVf8glNZRHObzxu4v4UImx5UlxG7qFgp+O+4fdJbCRJadsp+ruq
         xsoyItgM2PdPdhQ5iyQIyEFvPyTF00oePo7Aft56Vv4IHhSiIjd+YzLKw7kqoore8EH5
         b+SYYjQ7i08MSNhYVLXzQ5u8clrSxM3/0FZI4WBlAwFvcPX+X0KKRMN/7mXcb121IH1Y
         ORAoJ212AxVZC18/jJTrMnui6Qy4/2kRribAtFtKcyq1ij5Ud3DTmsjzpQux0If+L1hh
         d8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=5qYmh2aYYCQUqnXqjSO/21jnrrxiAFwQma+K/DlZQCY=;
        b=hZOd+8KQJUwcSc5yLdXTIWdicx0K30d6pKb6cj1fdk1RwISivzbKKne3BETwWBXljT
         Y/nPwxrAjetIWYJRItQU/Tc6pLCKE8VsxWHHugeLnYvPEQ8UWENhnIsMpT8AG55T7uch
         afgXBl2CEOKBiuRk5Vsz1XWAlurz8QUkoVIeBLTX3p8zctvXTXALRLdmOAo70aAj/r35
         /rwdHup4VqLNRW52mbo+z3L4G7NyDpt9IuU4ip5dHJKWd3c/ykLwIKWCB+Rkz7Y5qPI2
         HldJmpx53yxvXiNP9GlFREbqP7DZIv8PDOw0CPMnp9Pz8VUSC8bPm+k1VP5c4SzF/Ezk
         8Zhw==
X-Gm-Message-State: ALQs6tAv9ogoB0JUojRmQCRr1dLFcyVaRqDs1tOkBO0iQAVvJeGTDP1t
        9VPaIpN6CTwt5a8EkFfclH8=
X-Google-Smtp-Source: AIpwx48iNV5t4BbVPAw4j52uwe8nAkCXa0UnrlJcw10zOkEARYyoxRkIJuNEecVAlfCRARW0Xr+0FA==
X-Received: by 10.98.23.134 with SMTP id 128mr2663116pfx.120.1523891249605;
        Mon, 16 Apr 2018 08:07:29 -0700 (PDT)
Received: from [192.168.206.100] ([117.219.197.224])
        by smtp.gmail.com with ESMTPSA id y7sm26878372pfi.185.2018.04.16.08.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Apr 2018 08:07:28 -0700 (PDT)
Subject: Re: Draft of Git Rev News edition 38
To:     Sergey Organov <sorganov@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com>
 <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
Date:   Mon, 16 Apr 2018 20:37:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87sh7v6vn4.fsf@javad.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uvga4v2PD8qTfetoJyrvmcEuIR26hnpTU"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uvga4v2PD8qTfetoJyrvmcEuIR26hnpTU
Content-Type: multipart/mixed; boundary="UdQ1UTAvgW0uKlgJRQ95uL54yX2p0l2Ql";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Sergey Organov <sorganov@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Jakub Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>,
 Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jiang Xin <worldhello.net@gmail.com>, Jacob Keller <jacob.keller@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Igor Djordjevic <igor.d.djordjevic@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
 Phillip Wood <phillip.wood@talktalk.net>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
Subject: Re: Draft of Git Rev News edition 38
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com>
 <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com>
In-Reply-To: <87sh7v6vn4.fsf@javad.com>

--UdQ1UTAvgW0uKlgJRQ95uL54yX2p0l2Ql
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On Monday 16 April 2018 08:33 PM, Sergey Organov wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>> Here "the above article" means the Jake's "branch -l: print useful
>> info whilst rebasing a non-local branch" article above the current
>> article.

Just a little correction. I suppose Chris actually meant the "rebase -i:
offer to recreate merge commits" article written by Jake and not the
"branch -l: print useful info whilst rebasing a non-local branch" article=
=2E

That said, I read the draft and found it good except for two minor issues=
,

1. I see the following sentence in the "Rebasing merges: a jorney to the
ultimate solution (Road Clear) (written by Jacob Keller)" article

	"A few examples were tried, but it was proven that the original
	concept did not work, as dropped commits could end up being
	replaid into the merge commits, turning them into "evil"
	merges."

I'm not sure if 'replaid' is proper English assuming the past tense of
replay was intended there (which I think is 'replayed').


2. I see a minor Markdown syntax issue in the "branch -l: print useful
info whilst rebasing a non-local branch" article.

	... reworked his original patch to improve `git branch
	--list=CC=80

Specifically, in the '--list=CC=80' part. I guess it should be "--list`".=


--=20
Kaartic

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


--UdQ1UTAvgW0uKlgJRQ95uL54yX2p0l2Ql--

--uvga4v2PD8qTfetoJyrvmcEuIR26hnpTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrUvCUACgkQveda2sPW
GWlelw//ei+PyIIB642omaWT72ijtUqtR5Auzrbs94tJStqPC7lBhny/DhA76Ez2
x1q3urPcT0lDFwvHJtKmJ3lS8HDjzSHEkleLQdjp/hMp/k84mAxrWowGbIgJKM2A
LG0WculcEQztO609YWnLG85GT7wLH5fP1nKdB9ZrSz5qoMEsOq5mYjpvCA3WY6Gj
VkgTXrbatBH8uWXxptAss/AZEAeiC1rxRxizHSeRfk3OOXxKd/U6y9MvjvGZ4EXw
067nhUcULB9tHPXXmEyW44URlGizL3Qizc1qb6ty358KyMNNDP/yz9UgoFp2N43K
+T3npdS5H0WZ9RyETU08H1hRFYGw4ndXx5wrzO2QvXUjjQWhKoJbtKlmB52sBbe9
hT0I1YFdU53B/Jyg+KguyCQblJQdUtI8r2cF5BD56QZILRstt8/6ByR9EwTA9SpE
TI1dtymzVBprasjBSiij5uSOsQebzxuZzl/snXCxSSeCGt2G5ew0MiJP5l9+g+rd
36RZjOhWWcp01nMJ4mge2NrVD5eZ9NjHJs14zndaCYBs2J/ue/lo3fl+xAh9V7fv
ElqfrmJHJgUFJCyeUZah1qLTIM2t0z/vdnduR6rzC/TRbymKKmeLDbjBGTirJZiU
Xrmt6ArQ/hafbMKSYKr7GBGjoqqoQ+xKJKmaHNrJfulO2wclVF4=
=6LtP
-----END PGP SIGNATURE-----

--uvga4v2PD8qTfetoJyrvmcEuIR26hnpTU--
