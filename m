Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613F6C433E0
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC2420717
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L/u1uDfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgGQK6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:58:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:45633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgGQK6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594983488;
        bh=wMGN+jVF/boVmaN5UbUPBStnXntsRZ/mzV05V1zunvU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L/u1uDfNV18owe6b6UTlr2zTy3ZjhW9/pbyc7scaWtt8Ld1FP9tDc3owmdm7LexNi
         I0814b2crxjlfolzmU8AUT26Wcr3fBFJljZwzOndhUPph+1LgQwU6RrYlZhXfaewJs
         ag1GD3JAERKkfUFZh+qKcVjjPgv6u2m7J/KG8t9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.237.98] ([213.196.213.77]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzyuS-1kkNew1sOs-00x0iz; Fri, 17
 Jul 2020 12:58:08 +0200
Date:   Fri, 17 Jul 2020 11:31:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.28.0-rc0
In-Reply-To: <1B17D6F1-953F-476A-87A8-FA0FE5B5C2D0@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007171130050.54@tvgsbejvaqbjf.bet>
References: <20200710135935.6416-1-johannes.schindelin@gmx.de> <1B17D6F1-953F-476A-87A8-FA0FE5B5C2D0@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-669608368-1594978304=:54"
X-Provags-ID: V03:K1:hZE16qgMZ5qp+Y8vVHEjaAOzMZZMbrZ/YzPoVaoYiHhTDLdSrR9
 k55JRQMynPYc4GpG6/Ox/0SfIHHoCjHTB8PU4mZSVx36XasqpQGXzGL1tSMKkrxrRxFeHQG
 SThdEepu0Y2NVjK1Na7nETC5bCiB6ZGdpf+9vpXVecRANuKUJ9eQF0ufhTXrW/fJ3tI5QUA
 sVoujxRYThbTA5hDWn8ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+JvAEcxiVGc=:tSHp522NdB08TjwSs3NGy8
 M27t5KgloMs8WnwGQUve6Jo3ly3VRo6/VUFUgo7TCr2ud9YIEQAKHKv0CFK91+rPW+JHEncvx
 S2TmL56rJd3LVT0l2F8liSwtXjeYOKHfB7gwsngb+oJugBdqRPtyCj6UBoxgOi/fM/TqBP1H7
 r1paHHbG1/NGBk6FBtVxKyz24lyfJgUGIqFbXtMoM72OIWIfopBfxXAH10XjrW4ApHSFKtp8Y
 BBbe0Oy/XspnXILmyLaAvr74njGF8zQ+V/u4d3v3kqUrvWePPa5kJv6BZywQd4zIMTRYiY5CY
 J9ojPxd7lcqb5CzTt1QTPEHBYipu8DAKbL4kVTNu3e7FpF7NdbZojn4LVehGC3E1eE2baP5Qp
 1VhUyFNT5CSwb05tBsRlhKJm0FcE1tPfuPqHBq0LN9bniitEDPPr/i6xGs05NcKoqnxiGzkc1
 JbtHdKuQQnhZMHt24NxqOzNTCnY6tnXkj6QCRqbh6Hds5Cyg5ajU73HYtfc0We2yk63cBHqKI
 C2s8VVdDzRVcbLOAeLFXfRHcv9F3byp5NuBHbVbQ3EA4ZR27RHnmjb+ltKYA5ypyMel9WYDBf
 hyn/QvqrINA2Zj0nsruzUnhuDDj9MdZm6lDHJhKQMo+HTPQw7O4S69ED3L5krNSQRm/Dmp4hi
 V3FHd/qCF/yStqYpZOxN3ZTKjcIgcZCVh6mFaGrAw9USs7PUW1gJZguQji8RW/Pg9Ragxg9q9
 3NeCE+gWMKutrIJnzpAYC64PY6dj7Es8OUt3atCoX885kF6P5hbgDKbsrEzNg5E7MW+9+F4H6
 z5w+cnytXF0MwpLwQ/Wv+fh4Y9wD5ZyuF+t8BYZC1FwFthqbKNKgrCHNRqw3968NUnJy18FIU
 n87g7cVB+znK8hGQrxPea/YSLirljh2zA/AJtTzOUtSHc3LQmZVFcWvC2oRF8ElgRqPD91Qi8
 3MYEdOtVOkkow6qg7XMraFpXpkD7To8wvTc3WXCiKiV40DA5dmQgZ6HNksQmocS59k761roba
 QKhERjg+IgGKI+zQyxS4BhGW/GCI7mMBvK58v6gtoqHAgVzIkXjEr+Ct0NhRx7lbU3bNz1cTP
 COeDw4c/Ts3fIVZdIhhVFmCDkt6oGMzWzWkecRlDYedP4eRI9cYlDIke1oa5ZC/xjZiG1ND2L
 Eyf/ejFtHWMSEbFYmjOhp+c6J7ebh31yPhZ/MEPkKzBf1PZ38tO2dvSBPJC1c6kUwRtBkaHIM
 CmxDg4QPn2WXtnTFRMQbzjMwMysQTc0rrreVqdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-669608368-1594978304=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Fri, 17 Jul 2020, Kaartic Sivaraam wrote:

> On 10 =E0=AE=9C=E0=AF=82=E0=AE=B2=E0=AF=88, 2020 7:29:35 PM IST, Johanne=
s Schindelin <johannes.schindelin@gmx.de> wrote:
>
> >Changes since Git for Windows v2.27.0 (June 1st 2020)
> >
> >New Features
> >
> >  * Comes with Git v2.28.0-rc0.
> >  * Comes with subversion v1.14.0.
> >  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
> >    3.1.5.
> >  * Comes with the designated successor of Git Credential Manager for
> >    Windows (GCM for Windows), the cross-platform Git Credential
> >    Manager Core. For now, this is opt-in, with the idea of eventually
> >    retiring GCM for Windows.
> >  * Comes with cURL v7.71.1.
> >  * Comes with Perl v5.32.0.
> >  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
> >    3.1.6.
> >  * Comes with GNU Privacy Guard v2.2.21.
>
> The above has "Comes with MSYS2 runtime (Git for Windows flavor) based
> on Cygwin ..." for both 3.1.5 and 3.1.6. I wonder if it really comes
> with two MSYS2 runtimes.

You're right, of course ;-) For the resolution of this story, see:
https://github.com/git-for-windows/git/issues/2746

Ciao,
Dscho

--8323328-669608368-1594978304=:54--
