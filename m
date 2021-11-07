Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876FC433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFDE61357
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 14:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhKGOoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 09:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKGOo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 09:44:29 -0500
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB9C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 06:41:46 -0800 (PST)
Message-ID: <74eec375-e7e1-dd2a-870c-cd46d870a4e6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1636296105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNXZBXOBwdhnfX0Ol9ZQWhJp5QJW/frVXKHYBWXOIkc=;
        b=SOiEz8SGUnmIqJK4FA2efGOd14atxJE9RGmNKTpDBcoTMQbyqwMu7ZanPyDzat/BFFTgzA
        wIeAGwSvawdpKWcUfArjNmcUIwhlUXh2mTkiwjqZsosSa6l7aXt7MBfiTyoWCQUr5qRXfw
        PrH06ntJGGsxlq/xvNbpYDbHkLkp69BvFM/ASnDCkJWCPOkl37FBeSTiYQXqZvnBhnkd9r
        5bPDmTrA4sJw8ULX7EdTEvSUHR3J8BEOzWbMQNPoe9uqz3HK1rVsMOdon0ual352Vr5K+h
        h4G/oaUeIvIeb3/fluPy2pUyRnvz6oY43BNg/EQkMKThtiP1eygkSi8VskM91CZrt7tonX
        jIRsX1u18pUh/aKomx92YeeHfUzy6DUIaP55ZaC8oooDsbwMKNWCTVAB1nACGPKLKM5Wk3
        ONapkKjvbrXsq8fPEi3uDXzIWW2sOA+EgMA5d9zGGLqlWoK27W0uI+2o1lZ/JyI+SiECiX
        O/hOBk+OC7+vSofmCjQRTraZvvS6yjbJ8IPiIrUJvtC2Re4nVPM8o0XQqJy7Rg7lj4j8xo
        FvkDodUxPadCpRoZ4hzr1ILZqlNV5bu92dGjM4SrFGoyTw1OTBbDP78zOZdhzNekGeK8ce
        Evuwe6kHcK6QWy5Q1alMcnYRzD1xlZj29Ad9AUjHZGOXdYuhDrLZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1636296105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNXZBXOBwdhnfX0Ol9ZQWhJp5QJW/frVXKHYBWXOIkc=;
        b=l8a75fiZjY5h9w9muQOzt4GZbHN/EXJnkqErzXWsSS9qcMhPWKO2E3v0tqbvQy0btTKr4B
        IYkAhDHRFKkVaIBQ==
Date:   Sun, 7 Nov 2021 07:40:08 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
Content-Language: en-US-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
 <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
 <2803948.JoDkH9avOM@cayenne> <xmqqmtmocqz4.fsf@gitster.g>
 <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com> <xmqqlf258aq3.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1sRoxO3RP4anH3vxmGON0CLJ"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1sRoxO3RP4anH3vxmGON0CLJ
Content-Type: multipart/mixed; boundary="------------F80mHZ0Zot0q8GuOyaB7j90n";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>,
 =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
 =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org, =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <74eec375-e7e1-dd2a-870c-cd46d870a4e6@archlinux.org>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
 <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
 <2803948.JoDkH9avOM@cayenne> <xmqqmtmocqz4.fsf@gitster.g>
 <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com> <xmqqlf258aq3.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet>

--------------F80mHZ0Zot0q8GuOyaB7j90n
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/3/21 8:38 PM, Johannes Schindelin wrote:
> I fear that it won't be as easy to send the next iteration as one might=

> think: GitGitGadget works off of open Pull Requests on GitHub. And the
> branch for the Pull Request corresponding to this series has been delet=
ed,
> thereby permanently closing the Pull Request (it cannot be reopened
> anymore): https://github.com/gitgitgadget/git/pull/1066#event-554168943=
7


In fact, I know you *can* re-open such a PR. The author of the PR would
need to restore the branch in the fork, and ensure that the latest
commit on the branch is the same commit that it was when the branch got
deleted.

I know this is possible because I've accidentally deleted branches that
I thought were already merged, when they got reused for another PR that
was still open --I restored the PR by restoring the branch immediately,
I *think* github may offer a button to do that on the PR webpage but I'm
not sure.


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------F80mHZ0Zot0q8GuOyaB7j90n--

--------------1sRoxO3RP4anH3vxmGON0CLJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmGHySgACgkQzrFn77Vy
K9awoBAA1+nuJuWWCHUYITYDggetJXEaaFFYNbGnzod85FtuEzq2WOdVjvbtoHZj
yBh2err54mCqDT2wqeSknuOHJDAcfE9+4VERGQOVLdBAcABU0+hZFCXmm0umiJ+g
xf66SwPtDnPLuybLJV1JFZqp2DjgUkrbTCJA+zjYTwn1kwbglfT8xI0RlIYBO1PH
6QTUZtpS8PJj7Ka47IWXkiVDsjUWkfz0XgPxwc87COrdTSwLDzhO7eIcX0NXKCFw
nLjuNQzfkdWD0xS3qArfn/bIBG1Rp7hOQDu1oKHxCpm30H0ILBTPQhAgz3od/7mq
ZK5Q/yRRc4coWPcv92zRDIIfh97tmoNIUgWrexsdPUYw4AkRyveKZi8EBdAw4lqG
4nDwvQYV9s/m59haVE/RovCJZwEiI0XeE45a6AlEck1NCzca+nc5OHKMhDqMG3gz
d4kXgz6Cu6OCfiZr2dgLgN0Q1HKyd6MfqiR7lIayzNYzdMiJiZhG+5Wu0b3YSx1W
2smyDCtifmcqqTwLY+rBETd7LN4NPRDg7yu+XinmY0w3/wxrRcJnocO6vblopdhc
ytRaMhN5W0edDlsEm69CaCaWf5liypQanPY9IdveMn8l9b813AZewMuPhi9406JS
CtTHOpn3Z35dz3g4wCNjTPIw9h3ZF158VlJRE2CN4yAE/V72IlE=
=MmIg
-----END PGP SIGNATURE-----

--------------1sRoxO3RP4anH3vxmGON0CLJ--
