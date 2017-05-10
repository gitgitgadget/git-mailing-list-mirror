Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C665120188
	for <e@80x24.org>; Wed, 10 May 2017 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbdEJPwo (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 11:52:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:53098 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbdEJPwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 11:52:43 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZw6-1dV2ac3X4I-00WYme; Wed, 10
 May 2017 17:52:40 +0200
Date:   Wed, 10 May 2017 17:52:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH v3 1/1] t0027: tests are not expensive; remove t0025
In-Reply-To: <20170510140619.22808-1-tboegi@web.de>
Message-ID: <alpine.DEB.2.21.1.1705101746470.146734@virtualbox>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de> <20170510140619.22808-1-tboegi@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-249887116-1494431560=:146734"
X-Provags-ID: V03:K0:pp3o+9RFN81B7UE+dVenXXBvtKquoROrF2zMNZ8dD+3VdfuwTLE
 uo6uyrw9Y9AKQQUgcl5TIZyMlaZzNlPb5/bD2UVXXi/jtJveZtD33huJkj1IcBgZJPw1wQX
 CfppFwKmImD0KpbMgfIOrAS/OWwzk7g+CpkhTdz0CRJn3SyJNm1fq1SJ8W8cEFym5iprNQu
 lYGFsUQmDAJyLMNGn00HA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I4X3J2zNBN0=:29nomF68V8JwbmbOVgjICh
 h87Zlw0Rc1tEV96KriOot7nxPk59kcmNuarKGDncl2WAUfuccihoCqiNzsWHbMi7o2RMJvBW+
 TsotsShUx5q75eIfjjuX5ca+mWEp2zpvoJJmCvqazS2RE1kTlWxcC1SLbk0JirIBy4GHaRMnt
 3cbh9aAa+x8Y0ZchAufiu59McGIpwZ2/qAl0wczMyVLIO9q71QW79xG2r5ysCDWXGeXoJtMW6
 evlfWcQcdGEocvRuwAVd0nFraIqZ8fjw+b69aNVjFmXwgIpmCBlsOVeyFvNDBugu1lQ+1oIbi
 11Uy3PiMqPsAgLZE3RQKoVVeLFQmr6XffGmI+PArDu4u+nQ5xPnpWX5mAeYNcrrxpIQ2yfGRa
 1SWHtaUPQk9znLVjzKEEF/uWNAjR+X1qK5CG4J0Rol8XHEMNtPJVa59PCsDar9I0PXGiNSUrB
 7iOQO8yQUmf4wZMUbfHJp1auy7sr2teBn9Eigdg1OqqTMbbyxuXD//Qr82MlsIAJRNp/ybEDz
 O3s2udGKIBUW0uM4LMp7gZ+uheKhIQW+wLlvSzrM4CS+JBgjI5QTz0p9+jeZsOHw8LMW/Eubu
 byTVdILg2egG1bMKEUvXO/ygF5LlKLofZzhCdZ7nhxYC5RCe2OlEck9rtTh9WavoiK2hqyknW
 dW18AwafZxBPNAguAg58oabtx1F0mm2pb9jq+Pz1MAcmLp72cubgw4sYm/ePbQrZdpDNzT+gm
 Yt04CqqNfIe3KtBjBnaZUkiwt4+F6oZ7u6bFEPbrTqNxumCyzStAr6HQzXhuHHhKUVJU3BT7L
 dcVm0GF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-249887116-1494431560=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 10 May 2017, tboegi@web.de wrote:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> The purpose of t0027 is to test all CRLF related conversions at "git chec=
kout"
> and "git add".
>=20
> Running t0027 under Git for Windows takes 3-4 minutes, so the whole scrip=
t had
> been marked as "EXPENSIVE".
>=20
> The source code for "Git for Windows" overrides this since 2014:
> "t0027 is marked expensive, but really, for MinGW we want to run these
> tests always."
>=20
> Recent "stress" tests show that t0025 if flaky, reported by Lars Schneide=
r,
> larsxschneider@gmail.com
>=20
> All tests in t0025 are covered by t0027 already, so that t0025 can be ret=
ired.
> t0027 takes less than 14 seconds under Linux, and 63 seconds under Mac Os=
 X,
> and this is more or less the same with a SSD or a spinning disk.
>=20
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

This is still formatted very awkwardly. How about this instead (I fixed
the formatting, reworded a little here and there, and fixed the order of
the footers)?

-- snipsnap --
From: Torsten B=C3=B6gershausen <tboegi@web.de>

The purpose of t0027 is to test all CRLF related conversions at "git
checkout" and "git add".  Running t0027 under Git for Windows takes 3-4
minutes, so the whole script had been marked as "EXPENSIVE".

However, the "Git for Windows" fork overrides this since 2014: "t0027
is marked expensive, but really, for MinGW we want to run these tests
always."

The test seems not to be expensive on other platforms at all: it takes
less than 14 seconds under Linux, and 63 seconds under Mac Os X, and
this is more or less the same with a SSD or a spinning disk.

So let's drop the "EXPENSIVE" prereq.

While at it, retire t0025: Recent "stress" tests show that t0025 if
flaky, reported by Lars Schneider <larsxschneider@gmail.com>, but all
tests in t0025 are covered by t0027 already.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
--8323329-249887116-1494431560=:146734--
