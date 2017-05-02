Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B062E1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdEBQLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:11:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:63901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbdEBQLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:11:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8RK-1dR6cw281G-00Pz6f; Tue, 02
 May 2017 18:11:12 +0200
Date:   Tue, 2 May 2017 18:11:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH v2 1/1] t0027: tests are not expensive; remove t0025
In-Reply-To: <20170502155631.24848-1-tboegi@web.de>
Message-ID: <alpine.DEB.2.20.1705021809340.3480@virtualbox>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de> <20170502155631.24848-1-tboegi@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1017927838-1493741472=:3480"
X-Provags-ID: V03:K0:GONkL3rh5QDZzH2Ee1oyeF6YCw0sYObcApg3ZcTN7kGjzlnaJNT
 uTlDalmLSkuccnzSZ7I3WBkfjU5tjvg5tz9JLTd5KD4MKkULfSFChDnAdhtF6bCFIlDuZYS
 sTnF5PlEUNLV6Iwuw8+6HDOrgWgs7/KzCBfp53gdUgABkesUgmgkm2iNlAIc8Q6YLMY+uTV
 miZiJzaDpBIu0cFXP9f8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jGE1feutmGw=:f0sGwcspaSRUd+Dgd9/nJq
 SayNrQe1SK0zsgardY69S6By2bJa9yE3Evre42R5H4wt/d/Czzmy9Tgu68WlkEJoKneS3caI6
 a2hnNCpQC8WYh3jx6GnASJ42mXdyXifmGv8Zw4V/hIQPRwh41DHPPCMfRSl6HY7jP/5GLPykD
 IeAzOARh3K+JZm31HDierNKnh6y3oTE8Fe4aPNneCZt81zEXJsDQx9Nsi+/n2jP1m2L8RwJ2I
 ZmzZsyB5nuqzx2gN0ariJeJDuhCqcmb6grGRXqfFozFhYtcIA1r+emu9LsEkgZWdzC4bWusDS
 nDbhAbXWd32C9tCcaYWc1zvxbk5yhUqXhkn4fnBJKDiQoHUuMEG6lEYcNFn2Xu4wJ7RdCZuxU
 KupyMgNSlbzSvlMtk2QpsqH01MjZGpDMSIXaDZBnchxYFJXJMNLPjT7NJXhrT7+v2R6uBwWY7
 IBVbfcM2muaLfQ0Iwll5AoPKsoQupSsg2sHFnNR5hDAvH9RLCSMgbpdyhXLssLkH4bbcfOVG5
 j3XTC1WB5oY6tDcvXwPteNb3/LZPCw2MLP9L7Ia7UHurcwsJNx+PggedNrt0W0M/sBU60BfZC
 +HJ2hC3OoHSqPk5NoYW/7+5m5FtD/2yMaseQ+x89Qwe3aXSZp1le/x2QrTT1xW3NmiclHAjBh
 tJxkYPSsjnNQKhLLqR9FOS9b5dN8TBqPJLbJD1saGlAX9XPrxIft99anwJw895i1KXk64N3dC
 /wU7CYYOPz0plA+H4PTZl5CtD78/PuyE23IJoeefCE4FhqiqbrE/Gjj/DOVMjpm8mYUwmyF6Y
 +tjbAt7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1017927838-1493741472=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi B=C3=B6gi,

On Tue, 2 May 2017, tboegi@web.de wrote:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> The purpose of t0027 is to test all CRLF related conversions at
> "git checkout" and "git add".
>=20
> Running t0027 under Git for Windows takes 3-4 minutes, so the whole scrip=
t
> had been marked as "EXPENSIVE".
>=20
> The source code for "Git for Windows" overrides this since 2014:
> "t0027 is marked expensive, but really, for MinGW we want to run these
> tests always."

Indeed.

> Recent "stress" tests show that t0025 if flaky, reported by Lars Schneide=
r,
> larsxschneider@gmail.com
>=20
> All tests from t0025 are covered in t0027 already, so that t0025 can be
> retiered:

s/retiered/retired/

> The execution time for t0027 is 14 seconds under Linux,
> and 63 seconds under Mac Os X.
> And in case you ask, things are not going significantly faster using a SS=
D
> instead of a spinning disk.
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Thank you for this patch.

Apart from the tyop, would it be possible to fix the formatting to look
less strange? (Unless you use this to transport a super-secret message
steganographically to an alien planet or some such, of course.)

Ciao,
Dscho
--8323329-1017927838-1493741472=:3480--
