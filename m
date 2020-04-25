Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE2C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE41520704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ExwzJC6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDYNq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:46:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:37335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYNq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 09:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587822381;
        bh=UsOFgz6MKA8QwtL9DKjkeMpxOoJT3hsR+K/qRbYQtzc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ExwzJC6nAiDEZDyNXIwNJP87EhJ0tvraUY2vh1xq5WpQARnu9cPvMOu7Ljew5mieV
         HKDHWRp1naE783u2MYCTWmhPCsd+dXkchDuhBbReM4E9qZBWHeDZZg4ZP/ap2koGtf
         r9aQbfkLLckdaLh2AREw3/7QIfRusghcBdK7f804=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mf0BM-1j0OyV0yF8-00gc3J; Sat, 25 Apr 2020 15:46:21 +0200
Date:   Sat, 25 Apr 2020 15:46:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Rapha=C3=ABl_Gertz?= <git@rapsys.eu>
cc:     git@vger.kernel.org
Subject: Re: PullRequest: gitweb.perl: fix 'Use of uninitialized value
 $params{"action"} in string eq at gitweb.cgi line 1377'
In-Reply-To: <903700aa01abb139e9bf422835b26ca2@rapsys.eu>
Message-ID: <nycvar.QRO.7.76.6.2004251545140.18039@tvgsbejvaqbjf.bet>
References: <903700aa01abb139e9bf422835b26ca2@rapsys.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1388893439-1587822382=:18039"
X-Provags-ID: V03:K1:zi0TSWfkD4+X5I0ub/rhut/2pTa/jXclq//L4tyejVer2duvDe9
 uNPm1LwX3aoZUVJKQbT884HPXM5AWXdLwuTDNhBVa3AUZ5z1obYC/VolNjqiSzLWsO5QtqM
 bKbQYqcI1w9uabIeqpMZOtlLMs2nYYsw0A3riZDCD+XPfKHaZdwegoVB1sstuVztPbJudhc
 ySCqrvI9bahzCwPNECQdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sE7T6q/Wadg=:Z9t1sKsvsKfvrhLyELpgXW
 chTfbf4LsvybXLpCFUSFC/vvJ2aUS229KMO7Qif7mKT+Q6wxVFgHDtwalNPiVqw+swYwbVbMu
 Yx7NosL8op6w84WQsApJ6OS9UCiNbNGVsEEBJ9fjt+MB5BF94oSF+Tu28mUGq7jOMVPnmv/gw
 dRgczPdtcPdmWsJIw8b7PI/uxgoh8B6EqC8roCoEDIZ1b1iyDe2vUFLLszkYBbjgOt3Qo/oJR
 pcYEnljy1IxF4SRhs58bWPisAOkKP/WOyWSbUawznfHycJpTs5yDr8y2pGkTBFxrycBwzGaSF
 Ek53M+IprJ4k0KcrFSBUqPulugNxZsGV4d7zY4qeFkVIHPIPeHql1YTlh7UjY+2QbUCHW7ZkP
 Nm7PpQ1NqNlp75LXDzDbGau4prYuy07GyLP30GSI1IXeIMaGOKiuNspwn4XjyT22yFc9IG3KW
 At8EcUWik9LhG0mZZ4ZFvqN4iatehc6Be29b2k7SMjyE60fFw6cPwMfqHGSDNgSQX4EfVvjgh
 +9MNbXhu35ERrVdvX8+PAKxtftplUri9o15IekdeCE4bo88z4Q9pZ7O1BK9Cf4Nc0ifcsnPzR
 gSzaouPpFMZHgpfGvgWSL48vU8MCoawDxs4hWy1FGgphdFCzgS0nn2EISg6SOyhlg4OW4Rx7j
 c9M6a6CcA6ToJ9EutWJZxF0ThVOeMSKQ6csynJwww/4usg07N31Qt2230/krP0oR2x2PTLSjr
 8ZlOR5NhA7iiQZzCeryLE8JAbBqCJsa7My0YkBK0efnEGXPKbAaI4nI8WiSmqNwIFbLvj8MU9
 8jBilTdXWKQD2x6mwkzwIZsZ2O0kn3ySX7C7nFo7zX92/EJKtPxNZynMC+vguYF89ktDI1Akf
 WVDB54DYC3+aVI/kKMcdml7UdHWxYwOZFo1tt7SokwMWFht43rs4sn2oim0yONbgzy8TBjwSK
 xn4xQNo+Fyfw9aUGn1Q9R+e3yHwMsqIdfFLNT/SLeEmEwe9lgnidIlg9iXlnMju/y97yoqpDo
 heJvwYdu+LYuTHDrV6h0bDtCB4p0ALlxK4KKAQAMGSMCJjSvW0P7Ff7QWE9MB0aPpcU5qVL5d
 0du/jrV4GO/QE2ePpOT6oBkJ7tg1yo2cBGJn9avNXfGu0eTYaKsFjXSPFS5KmSaMvkNP57nL1
 GG9P9q8kzJN0DBIg+wr9lE9191TWboL53vEQJwvoiLbkN5vjYBLbuot4dUGehiW//mnDLPGjP
 4a9QwoECWIDmuYdKv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1388893439-1587822382=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rapha=C3=ABl,

On Fri, 24 Apr 2020, Rapha=C3=ABl Gertz wrote:

> This is a small fix in gitweb/gitweb.perl script that I tried to get app=
lied
> long ago.
>
> The current gitweb.perl cgi script generate lots of warnings in the web =
server
> logs without reason by skipping defined test.
>
> Pull request was done here against "maint" branch :
> https://github.com/gitgitgadget/git/pull/617

As pointed out by GitGitGadget's Welcome message at
https://github.com/git/git/pull/767#issuecomment-618976608, the idea is
that you submit the patches to the mailing list by adding a comment to the
PR that says `/submit`.

Ciao,
Johannes

--8323328-1388893439-1587822382=:18039--
