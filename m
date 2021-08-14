Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F78C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348D660EE0
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhHNWSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 18:18:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:39351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233549AbhHNWSa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 18:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628979479;
        bh=/L4wQAFmEE2g1qJff4UvnbW/2tQ4zO57IaAvFcMtE0Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NCbFIoHjgIKptA+5DD3kN4Ee+ShKWR9hL0aWgq0JQcHCflRZlxGidBOnSeSrtmt+8
         v6+xEIuquwC1MrMxQ9+PPESwW9VGrZHNt5tN+Ea+IxdQcQ4lUYPa8jCsZAMzecTPMh
         Rzg9gIz3zkAzk2JnYLeUJSBOcDuP+fLxUXIdiQhU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1mcfXF27Yk-00WYId; Sun, 15
 Aug 2021 00:17:59 +0200
Date:   Sun, 15 Aug 2021 00:17:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ci: use upload-artifacts v1 for dockerized jobs
In-Reply-To: <20210813091349.88574-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108150013510.59@tvgsbejvaqbjf.bet>
References: <20210812065234.71399-1-carenas@gmail.com> <20210813091349.88574-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-659242017-1628979479=:59"
X-Provags-ID: V03:K1:17EEPpnsqkC/Nhqz7GwAZYpQF8PtuHys/mZJaZVsawNrz9fLKKm
 LzAHCjwN3s+syhTvTE6rIRVAJCIF5wUF/8NI0eNeKqgIRc07KD6Lu8GcXidXJa7233Vr6Di
 beAZ6x9K4ObH3pNdM+wiOOTYma2vSTg/bnbZoQcHnXTZzJsaf0nfup6eTg5Ni+L+10xmR5g
 oX8Xu1yiBZUgEykIWkw7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ETOsmiJJD/Q=:MRWgo/Hl87M+n0/x9UlhS6
 8xkKu57lvWuit/rCnd/CIvKQgz6eAbJhkOAN9DeFdyaMiTVvuEeQBkl26m/PRdH9sguX2n2KR
 N3x3MCwku83g0+7bu6VNjUco0RLV2T02RDrPaJhXdh55CRs0UXbwo2G4hOydy7wdQ0yfaBsqz
 8l9rReOqA5PdpxfW++47AJ9mn/iIjIwaWfCq4be0Ab/pAnGzMBMXD95WY2VVARvPPZdPKgWWe
 mGvC/t3zp686LAZWs6gMgctWgHpeVv3L5WgLyw3muOVkHqIWg8gBUUr20HuyqJhNNMwGLKE1X
 OttOBu3fMYlmmXHjXKVAHi4iUTti7qLCn0Di2you3q+r1QgSZuoqrqVq1GqhxcQw2nfiitsz3
 M6t8XoY2lIhG7qXh0tskpGhx9M0VPWwLKv3/eyM7/PZOP3uh3MtIUS/aOY67DZC8B5ACWQ7GH
 62JDsOtW3Vkc2SWEK+u7b/BiwZrHRZguWDSh9SlJFsCyWkIQI5t/+7UeZ5QoWD+SFgrFnwmiN
 VQF7OBn8hQkBPt3tcz7BzTdc1mx7HytWVeW6mQyt/MXE0apS+B3XKtMKk6LFiaOQOMxjg6qgQ
 XMXotB//mvd/orMgRSdCyi2zUzWzhjyaSRVOA9HTVR+SB6+EE5TUDnZiUJpIjM2hsb4Cs4U6A
 0ys3SKpgJJBXl3owKDiCRx+AE7QScYiT2xHylM6tm3aPOSNbIEMv78IHoQVlRKNx0k4eSESTi
 ZTsaiD0j3KLilgazA7LvqX+kmjEAvpIvdY92GJc2vz+4ugUmfZoFi0+0ZJcHXj8ObgL7guWKy
 6R1BpFLPwDKb8C31buK4m3zYbET7VFz1rjmabhaxx0Mrz964vqMAzddAaFcjB3iD/NfmNyYyc
 dtIwmmDds8jo7O4XdKjN6WTr5pJse/92YGrKmW335F2G+Ay6lP7tcFlAi5JpYHBrxb5odydbU
 rkD8IEJbecWA/G7bDUVOJ9xl6zkzJTB0da7+AJ/u2h3GTsXdKWzh3vXwKBHKFH9y9vrCormk4
 mzUUkzl3qMTvIRSYyDASCWyhu/eZvXwoIonWw9nMGR84R3F9lihBYymJsH6rQaXHA4UZFfwv1
 +2DqhCUGJr1KQrZ503+9I2cbmmYVdK3hzkRai3AI35DGtCokoshSsnx9A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-659242017-1628979479=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Fri, 13 Aug 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> e9f79acb28 (ci: upgrade to using actions/{up,down}load-artifacts v2,
> 2021-06-23) changed all calls to that action from v1 to v2, but there
> is still an open bug[1] that affects all nodejs actions and prevents
> its use in 32-bit linux (as used by the Linux32 container)
>
> move all dockerized jobs to use v1 that was built in C# and therefore
> doesn't have this problem, which will otherwise manifest with confusing
> messages like:
>
>   /usr/bin/docker exec  0285adacc4536b7cd962079c46f85fa05a71e66d7905b5e4=
b9b1a0e8b305722a sh -c "cat /etc/*release | grep ^ID"
>   OCI runtime exec failed: exec failed: container_linux.go:380: starting=
 container process caused: no such file or directory: unknown

ACK!

This seems to be the same issue that didn't let us upgrade to
actions/checkout@v2 in the `dockerized` matrix (but of course I did not
notice the `upload-artifact` issue because the test suite did not fail
when I was working on e9f79acb28).

Thank you,
Dscho

>
> [1] https://github.com/actions/runner/issues/1011
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> v2:
> * dropped unrelated chunk and better grammar as suggested by Junio
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 47876a4f02..68596f2592 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -271,7 +271,7 @@ jobs:
>        if: failure()
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v1
>        with:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
> --
> 2.33.0.rc1.379.g2890ef5eb6
>
>

--8323328-659242017-1628979479=:59--
