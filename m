Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6241F42D
	for <e@80x24.org>; Thu, 17 May 2018 11:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeEQLBa (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 07:01:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44289 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeEQLBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 07:01:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id e6-v6so2318454plt.11
        for <git@vger.kernel.org>; Thu, 17 May 2018 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=wYrxarYu1ZmcL2mw3Oisz0ybzScs3l2hnguvkVe6o68=;
        b=e0cbHxpUbUbyPnQoxTZPhYbzgSyCce/sz/L4n2EoFQ399pXPLYskijLb0e14GdLGi9
         NlFdWEyrUosOupLMre3D+CR3Pz5BL1wNzgHuI6XE6LraZ4vc3Z9jOmTOaMlxmkipt6eh
         CmI3F3gJCWhAMIlWGS/bMHRqml/6YeR4ILlzIpcUN/Hiqz/vCnnn1eKTmUDz8TY8meNl
         LZDdDb/e/0Wrdmca+vLI/rowXh/LPfMaMpKUV9vLsTb3svetWlqffi68eEl96DgkvqKW
         ceCKZZQxBzggcwGpx8TOJIJpB/uOdqYAp1+tQItiZN8l6xog3LiRaW37Z7fPUlLbwebj
         LvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=wYrxarYu1ZmcL2mw3Oisz0ybzScs3l2hnguvkVe6o68=;
        b=U8qgzOLwyoJ8cmrkOCyi7VgCHh0AdCvIEonpHrLjmpEkTzl+YIyqGNlciHLSxiW7KJ
         M9BisX560raXIhSTe/xXc+P8D/kZU5RoaMUafZT3GpUM+zhIFcquRJzeyrccY8+o0V//
         m+D8LSNrHiMSZmAyyOPbJ4LCj1fgElwGX9pzUbT1uoKHcd/3PHng3/h8V4sZvuMb6Gt5
         RNNLXY9FTy7YyqX/owGgBlE2pf/cxvZeb5Yu9p9ES+H6opTbFZqHPcaiEqxKz7SogGId
         tO2RZcrxVfsTvCb6FBZ600ZP3gzAB5KWC5cJN2owtwwsZaTKeLdNHVh8JO2IUnvj3arh
         UU1Q==
X-Gm-Message-State: ALKqPwdZWWAhHBvhzgpZyFCmi0cf9K6UOzt+cSNN23Txhld9bH7OHRPu
        L/g2wTRrkVW1TieNgHozO84HhUyM
X-Google-Smtp-Source: AB8JxZob5zUfavzB47U5GoK5OOWgDitTLcHHREEvbuiQX06Zr9kNSN/EKUOnu6rSdoiJrQs0M21t+g==
X-Received: by 2002:a17:902:598d:: with SMTP id p13-v6mr4765865pli.191.1526554865976;
        Thu, 17 May 2018 04:01:05 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.184.61])
        by smtp.gmail.com with ESMTPSA id 65-v6sm10401479pgj.22.2018.05.17.04.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 May 2018 04:01:04 -0700 (PDT)
Subject: Re: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May
 2018, #02; Thu, 17))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <57e90df8-9522-0988-f25d-59a132b5afbe@gmail.com>
Date:   Thu, 17 May 2018 16:30:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87fu2qbojy.fsf@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w16aVdq29IZPlm5IHoxRAm6sFZeZgoxN4"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w16aVdq29IZPlm5IHoxRAm6sFZeZgoxN4
Content-Type: multipart/mixed; boundary="GHepoeteekjbFsu2GLkguZwOXvkRnHolm";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>
Message-ID: <57e90df8-9522-0988-f25d-59a132b5afbe@gmail.com>
Subject: Re: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May
 2018, #02; Thu, 17))
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
In-Reply-To: <87fu2qbojy.fsf@evledraar.gmail.com>

--GHepoeteekjbFsu2GLkguZwOXvkRnHolm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thursday 17 May 2018 03:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
> I've ended up with that $LESS setting via hackery over the years, so
> maybe I'm doing something retarded, minimal test case:
>=20
>     PAGER=3Dless  LESS=3D"--no-init --quit-if-one-screen" git branch -l=

>
> ...
>=20
> So I think this is probably OK for most users, if the have very few
> branches they'll see it, and then if they use default pager settings
> they'll see the stderr output once they quit the pager. I don't know ho=
w
> common my (mis)configuration is.
>
I'm not sure this is ok, because I still see the stderr output with your
minimal test case even when I have enough branches to not fit in one
screen. The stderr output is of course above the pager output (after I
quit the pager) and gets hidden out-of display as I stated before. I
also get weird 'ESC[m' characters with you minimal test case. I'm not
sure what I'm missing.

What version of 'less' do you use? Is any other configuration that you
didn't mention affecting what your observation?


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - John Sonmez


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--GHepoeteekjbFsu2GLkguZwOXvkRnHolm--

--w16aVdq29IZPlm5IHoxRAm6sFZeZgoxN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlr9YOkACgkQveda2sPW
GWmnDxAAjJA9pJABz8BEm0c1/9O1ntcUGV00j4JgBeCHSoGsJjLJUg4n8Yj8xKhG
9JrTyj08kS7ZLyKqj7peVRNDzqGnaZeqoLXfi5IfAyPBcBE5WiKdG6pIv5eXLKYw
3bdaCJjEMNxdoBemhRAP/JbRTllr5v99wccu04GNAKc50FyM/EeB5G3y6kWimfC7
o1YChR4am6md7y1ePnMrahWQaHCcoacPhThA+dcZcXEUMBK8qiO3iqP8qy1o0jXv
ly4UtuATZ2oHKiiHgHo6ywKoa+8OrA9/Yrqf3w7jTCZA2kdsVTspdnygf7J5iZNE
iWTr/4qKE+b3/owzOz3Xye/evy3ifrTWWhj+RN4A5y7Gg6yLGmalVfHE0Vl4x2QU
8aLHoO2zkjYgAPZcHVHlKxO+Dl1yE/tp2CP8c1HEfjrcl1dpEaQuL+WR9pbFgZKv
DoS71RxOAUSuZt7uEvolhlJuKbojz2if/aJaUUMzCOS35Tn9jlxekJ3V3uwZn9fR
NO/j/sVZrA/OvFOyTmLNcPdogw8Db0Eq1IaRNdRVOFIw/r+myWWNagO6IsyyApky
phwi92f9dVenZHz7tspuEUA52B4JEiymgoc6G2UrbtRU8f8YlR6c0bfFi1z+UAkG
rTWFBiwXZm0rIH652I/GlTxDhZ/BT7ZNBNbTy10eEU2ewXmRKDA=
=yPBX
-----END PGP SIGNATURE-----

--w16aVdq29IZPlm5IHoxRAm6sFZeZgoxN4--
