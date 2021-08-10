Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_DEOBFU_INSTR autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD364C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5F860F41
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhHJWZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 18:25:38 -0400
Received: from wes1-so2.wedos.net ([46.28.106.16]:57995 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHJWZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 18:25:34 -0400
Received: from kuhadatko-gl552vw.localnet (pc-213-194-247-202.valachnet.cz [213.194.247.202])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 4GknZZ5y3mzq3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:25:10 +0200 (CEST)
From:   =?utf-8?B?RHXFoWFuIMSMZXJ2ZW5rYQ==?= | ACRIOS 
        <cervenka@acrios.com>
To:     git@vger.kernel.org
Subject: Git merge improvement - "remove spaces/tabs from beginning of line and end of line"
Date:   Wed, 11 Aug 2021 00:25:10 +0200
Message-ID: <2632907.cDO7J6XS3R@kuhadatko-gl552vw>
Organization: ACRIOS
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3237495.fZOt1v9IPZ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart3237495.fZOt1v9IPZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: =?utf-8?B?RHXFoWFuIMSMZXJ2ZW5rYQ==?= | ACRIOS <cervenka@acrios.com>
To: git@vger.kernel.org
Subject: Git merge improvement - "remove spaces/tabs from beginning of line and end of line"
Date: Wed, 11 Aug 2021 00:25:10 +0200
Message-ID: <2632907.cDO7J6XS3R@kuhadatko-gl552vw>
Organization: ACRIOS

Greetings,

i was interested if you already considered this as feature, or if you may=20
consider this as good feature. I know that during merge every character nee=
d=20
be considered. And at the end it will be. I described my problem to another=
=20
developer and he named this feature as good noise merge reduction.


Issue:
Several times it happened that i added or removed condition in code but a l=
ot=20
of code stayed. Only indention was changed. If there was also other change =
on=20
some line i had a conflict. And several times it happened that a lot of cod=
e=20
was appended instead of replaced (if some line was similar with same=20
indention). This made merging messed and confusing. If we would remove this=
=20
spaces noise from beginning and end, we could get more acquired merge. What=
 do=20
you think? Of course this is only for looking for most matching lines. At t=
he=20
end the code should keep all necessary spaces.

=20

Thank you very much for your opinion.

=2D-=20

=20

Du=C5=A1an =C4=8Cervenka | Software Developer=20
a: ACRIOS Systems s.r.o. | Razinova 2257/5 | Ostrava 700 30=20
e: cervenka@acrios.com | w: www.acrios.com=20
m: +421 918 715 117=20


--nextPart3237495.fZOt1v9IPZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE+N59X/uQmQonbTmvX9i+KMGf63gFAmES/MYACgkQX9i+KMGf
63h98Af/YXd0wefaz8U+14JgJyzh/KbPyQn5U5HDbRI4tJQpBdcYfSStTMzdjK3D
WX1m+ELrdi8k9yc4w5W5s0XySV75/MrvafAQxkA6JzHrlOClwQkWdstWG9sYZO/+
0ZCvoSTSGZUg7807zhJ77/ehQ2Td0NdRk2jq2/44bM4BO/VFz0vVsBSIU5Bkd2X4
TyunmxDt4SkhLUEM3R8JsLTMONV9EN/Aw+DrN8EDVN6urwrPICxzesrwgrO/J69k
QAkhUwwLObjpb6EHhcNKaUEQ5b5kqQhhyYOJlxyRtGiv/i+J/XdqN28859TY33Zz
q+cJ24nk40Q7NGBmp8QwmbSQFYD3DA==
=tKfE
-----END PGP SIGNATURE-----

--nextPart3237495.fZOt1v9IPZ--



