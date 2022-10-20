Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8837DC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 21:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJTVDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJTVDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 17:03:39 -0400
Received: from redcrew.org (redcrew.org [37.157.195.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F833207513
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:03:36 -0700 (PDT)
Received: from [192.168.0.2] (unknown [185.22.237.37])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by redcrew.org (Postfix) with ESMTPSA id 62AEDC4;
        Thu, 20 Oct 2022 23:03:34 +0200 (CEST)
Message-ID: <5c12bc9c-36b0-578b-2403-54a9bcf920b1@cepl.eu>
Date:   Thu, 20 Oct 2022 23:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: git-send-email with GPG signed commits?
Content-Language: en-US
To:     rsbecker@nexbridge.com,
        'Konstantin Ryabitsev' <konstantin@linuxfoundation.org>,
        'Jeff King' <peff@peff.net>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
 <Y1GJAart+/yFc5MR@coredump.intra.peff.net> <xmqqr0z2s7w4.fsf@gitster.g>
 <xmqqk04us77b.fsf@gitster.g> <Y1GUDbtFIGZu0BKD@coredump.intra.peff.net>
 <20221020190117.va67kbrmvg4xxit5@meerkat.local>
 <004901d8e4bb$c3338360$499a8a20$@nexbridge.com>
From:   =?UTF-8?Q?Mat=c4=9bj_Cepl?= <mcepl@cepl.eu>
In-Reply-To: <004901d8e4bb$c3338360$499a8a20$@nexbridge.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------K9PeCxggf5RSR4g0nsAHg0g4"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------K9PeCxggf5RSR4g0nsAHg0g4
Content-Type: multipart/mixed; boundary="------------QoNscTxY4lgearbEq7JOMw8a";
 protected-headers="v1"
From: =?UTF-8?Q?Mat=c4=9bj_Cepl?= <mcepl@cepl.eu>
To: rsbecker@nexbridge.com,
 'Konstantin Ryabitsev' <konstantin@linuxfoundation.org>,
 'Jeff King' <peff@peff.net>
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5c12bc9c-36b0-578b-2403-54a9bcf920b1@cepl.eu>
Subject: Re: git-send-email with GPG signed commits?
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
 <Y1GJAart+/yFc5MR@coredump.intra.peff.net> <xmqqr0z2s7w4.fsf@gitster.g>
 <xmqqk04us77b.fsf@gitster.g> <Y1GUDbtFIGZu0BKD@coredump.intra.peff.net>
 <20221020190117.va67kbrmvg4xxit5@meerkat.local>
 <004901d8e4bb$c3338360$499a8a20$@nexbridge.com>
In-Reply-To: <004901d8e4bb$c3338360$499a8a20$@nexbridge.com>

--------------QoNscTxY4lgearbEq7JOMw8a
Content-Type: multipart/mixed; boundary="------------Dk0Wye1VHvl2JgegjLMIgTMa"

--------------Dk0Wye1VHvl2JgegjLMIgTMa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dne 20. 10. 22 v 21:40 rsbecker@nexbridge.com napsal(a):
> As I see it, if git commit signatures become a requirement (maybe
> resulting from supply chain discussions), then using existing
> capabilities may be the most practical alternative. This would
> involve submitting signed commits in pull request via GitHub instead
> of emailing patches. I know this is not a desirable position for the
> git team, but it is currently available technology. In a pinch, that
> could satisfy the requirement.

I just think that this future is much closer than one would think. I
think that for example electronic signatures and hashes are one of
reasons why even SUSE is probably now going to ditch osc as a versioning
system and switch to git (yay! \o/). Our partners just forced us to do
so. And I really liked the true independence of git distributed developme=
nt.

Best,

Mat=C4=9Bj

--=20
https://matej.ceplovi.cz/blog/, Jabber: mcepl@ceplovi.cz
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8

Every true American would rather see this land face war than see
her flag lowered in dishonor.
  -- The Episcopal bishop of New York, William Manning, 1916

--------------Dk0Wye1VHvl2JgegjLMIgTMa
Content-Type: application/pgp-keys; name="OpenPGP_0x79205802880BC9D8.asc"
Content-Disposition: attachment; filename="OpenPGP_0x79205802880BC9D8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
k2RqtabpH9mrN7M=3D
=3DjR0O
-----END PGP PUBLIC KEY BLOCK-----

--------------Dk0Wye1VHvl2JgegjLMIgTMa--

--------------QoNscTxY4lgearbEq7JOMw8a--

--------------K9PeCxggf5RSR4g0nsAHg0g4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEPHagJ8pFrXCYtbwdeSBYAogLydgFAmNRt6UFAwAAAAAACgkQeSBYAogLydgQ
Nw/+PzzcrgB4lb+YWKyQl6t2cxm3RIjPTmPXLweEEi2GEjENT2Pu8fzuNpiyrLaZjITrJ1Zun9Yb
SrLsXjHhwXS8M1R0qwJQPbv9/j9y3GatXOt0VFCQlZtm5Y9id/4B3jbHB/maKgNVrduPldtaVYhg
ATZonfGtSgdKOr2/3F3cXshH60ckOD1BPplgzKa2MISDT7jKzvSk3brOPxD5zULuSxCqgRWO74Wk
9i8kD2IhvNfjj3afL0HH16YTIUBhKQRKMxUU+O7FfbE8iH2FM3GsvEXS15ohKKQv14/aWjBXhSt4
wj5uYBn/byjRAR7FMVNIbV5lOLLATRHRjdtZaD3MVm/0gxeaAX7gHnwS2RAbZHbdlNVhvVbcKBaq
APLpIFGCm5mScLm1u5Ng+XaOKjkcAvu6/Fhm1vwrSKxrPm6+2H1g2p3Ta5PCz0ljE6BX6770uS32
UZfw5ERkJ68w6n3IXcNSglRh4oWNxCCFw1hCRHT5Mdnl4GUBzVtHww8+nW+VGp1d5KrDUeS0hp06
0fJ3h7swy3Ov13p1ME/P/SO6Jl9RE7yUtsZS00vk82oTpPZ5pcH66JkTzeBQJjZZ7SxkOARPbJrr
cOevf3hSJySTCcvPhjce3p4qqr2PRII6PmvjukRCevVDMr1jy8d0EjyX1I9j7F5lemyNdx/XitwG
OSY=
=VFIA
-----END PGP SIGNATURE-----

--------------K9PeCxggf5RSR4g0nsAHg0g4--
