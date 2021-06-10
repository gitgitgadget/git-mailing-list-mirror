Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9426C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3096139A
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJVg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:36:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47672 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhFJVg7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jun 2021 17:36:59 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BCBA360400;
        Thu, 10 Jun 2021 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623360902;
        bh=woeB5goId8NVBOg/+DXo7xYiLT4Bun27PHx8jkORgUo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GDMgS5vAWrFnu80OVd7p5QTo5RavoyqPqH0BXkjj4Ztx8JRpQPeTpkuyQMhFlO6EN
         rAQ1fSjls9S41p+bzxZnFztRXBjpGPy167/2O9gdZU/fppOVLd2yIu5jASzJ7As0qe
         7cK9o+d62nRN57IPNyjTvjR9eXCODoLlSSSMTEroOLg61Aqxf7lM8WUiPEeZXTcUOJ
         rRMwzqeMDW+F/qVAyOx6/KC27eUnlvIDbru+JESMzPwcUqK7DMOTO4N1/wWI9k8prp
         LRBePWcCSX5nzHJ2gMPNlTFuzr/SUR77gVEY135EtPdBcUec3KsF837A6W3GIK5djd
         v5ZCBhMpGu1hbxS8fCjBnc/UIg1Zc9NO/e7BdI6vLadevM7YN+UUArUkVTDbmf2IeB
         24hTipgltkfyiFocWSR6Dhwze7k9bkIew3USYK1xoSZhkoSdWzRX2fkbx0gUZ1Ofzu
         mG4o5QYQWM+VIHPpw2vNSpzHLW+BP3kLBWVaU0LAFS3OaBBxnlP
Date:   Thu, 10 Jun 2021 21:34:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Message-ID: <YMKFeZdwD/BSeKmx@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <xmqq4ke9v6za.fsf@gitster.g>
 <a66ed39c-926d-d887-526b-dc0f9c049085@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9tSlZzdRigiKVkvW"
Content-Disposition: inline
In-Reply-To: <a66ed39c-926d-d887-526b-dc0f9c049085@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9tSlZzdRigiKVkvW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-07 at 19:05:19, Derrick Stolee wrote:
> On 6/7/2021 2:56 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >=20
> >> To futher justify singular "they" as an acceptable grammatical concept,
> >> I include the careful research of brian m. carlson who collected their
> >> thoughts on this matter [2] (lightly edited):
> >=20
> > The use of "their" here I found going overboard, given that (1) it
> > is outside the topic of this change, where you are not referring to
> > a non-specific person, and (2) as Brian's siglines indicate, the
> > preferred pronouns for the particular person you are referring to is
> > "he/him or they/them".
>=20
> I'll admit that I was trying to be instructive in my commit message
> whenever possible, so specifically chose that option among brian's
> preferred pronouns. If I misinterpreted the purpose of "he/him or
> they/them" then I will absolutely change this instance.

The intended meaning is that either is fine, whichever the speaker
prefers.  Most people do use he/him for me, probably because most people
are more comfortable doing that, but either option is equally
acceptable.

> For my part, I did run this message by brian before sending the patch,
> to be sure that my use of the quote was appropriate. (Also, I'm
> purposefully lower-casing "brian m. carlson" to match chosen email
> signatures, but perhaps that is also incorrect?)

Also correct.  I typically lowercase my name, and I prefer it that way.
For legal purposes, at least in the locales which are relevant to me,
case is not considered important, and most legal documents scream my
name in uppercase.  But when I have an option, I prefer lowercase when
that's possible.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9tSlZzdRigiKVkvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMKFeAAKCRB8DEliiIei
geMGAP0fEf9OXnHp+6cegDuWyenMKAg+53TcyKkW5gNgq7JtVwEA2EX2vqD/kYyZ
OTR8cf+1cCOBoVcW8TPWfPXKsdzEBAw=
=8aap
-----END PGP SIGNATURE-----

--9tSlZzdRigiKVkvW--
