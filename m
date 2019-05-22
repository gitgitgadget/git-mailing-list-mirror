Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D94C1F462
	for <e@80x24.org>; Wed, 22 May 2019 14:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfEVOyW (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 10:54:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:46477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfEVOyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 10:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558536859;
        bh=Jq9r33mdnuzxJ4HbgY71uOESrtlxapjSckpRHrQ6Psk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Mhn/1P+XXG3LC7pcMfiSYdXpaIr3OZ5xOhX1Qt2/RN++Jr3S80yYqnpDj2TPgMdd6
         rxaRDp8pWJP7tArvDgVjo0w58c0BznCWbzq6Em+sVrj5UTXX9RrBVpkJGRK+/lqAVl
         y/7vVmR5P4WF89kKqk0NHWMZR8OCn3lIHjRPIco4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1hNNpZ28ny-00BZTi; Wed, 22
 May 2019 16:54:19 +0200
Date:   Wed, 22 May 2019 16:54:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Oussama Ghorbel <oussama.ghorbel@iopsys.eu>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: strange behavior of git diff-index
In-Reply-To: <VI1PR08MB3454100258C23CB1F2B709F5EB000@VI1PR08MB3454.eurprd08.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1905221651270.46@tvgsbejvaqbjf.bet>
References: <VI1PR08MB3454100258C23CB1F2B709F5EB000@VI1PR08MB3454.eurprd08.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-388345071-1558536859=:46"
X-Provags-ID: V03:K1:gVXLuWBcYLr+995RhDBNjil8NiMWk+sdfnPScXyBc5TvBgaGVrk
 Yd73PfUnzZXuqL0c/nQkcU5gbuCnxxUGaTm84ykLGyZ+h+fWFZ09GUqCrFtfmv/addls2VR
 K4LNM3LAJCnbyaZ3jJM3erhQby1TO2ts9HvzXGA4L/SS1QX9Zej3gca9KMvxuE9Y3o1ZFTw
 bi1NLnYX1kaypiNUSSIuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UO61dwYfRZ0=:qig8c9KeqwblYQilksHoh0
 DLoqqP1G0waQPasn/DDZQt1mky0/RTLj1zLXLDCc9sNFPI2djqISm1jlH7GhlPzkhw5cSj68H
 KKhTGHcVh7gIuVK8fPGxuX3SeM9FiteURbknxL6mCasEa67V8EFrkWLucvLRuZJsRi4tEMQqE
 Grv7U6l7Vm7Q8LM9XTgxP0yMWRmyzgrZW9IppshKjfleEjEMU4VWsV7tuHcIernokV66y1f4o
 BSu/q5gakqbkAyzqQARoibwymFUDrioa6x36MT8Evl1lYU5HfxLr8WkKEifO5reBIYKE8xEC8
 W9TLpXnqdUznpwx8i6l/0s4vrmkEBsf5M+e0iBnGySSHkBOQPumL1qc4EtEnm3i3FU1UVqSJm
 61Zmi5mAoD6O3wN86idqO6mf8w8doyhVKxujIA/qudiuurI/Wn3nPMSro7+7QIm+c2EUKXSjl
 Hnqo1shlBAPeAJwaP3glA58lcfgH/h/SWVeu82TY3+2Deo9xNeDVy/AEA58zvLw//Z7CsLbqN
 SO58/LQGcSvW2nn1YCN7Sb0nke0LoPktm1XKJ9dwRWU8eNRmPdJ0lzXqW6zyPyFKn84vQP09/
 GfhijTvEDFB/S2AHInGX9QoZMbNg9pASikgERduvUFWMe7HaQwSMPYaqTqTgyOXHdB9epCV24
 w6GW6Ab1IM0/PD+fj1DwCH3g4X8Gas/JQr4XL/ke+H+lSHMM/7k7Z4ilLnmI+oOeE/Km8eXi7
 pQEgNDWA/+vXIP2O/njYYPuXczdvOEhXqUlhi0VFYQ0G6ryoUg/ZefdoVCyj4v0oXBHuSbmD6
 kx4JIPXLyCFkwnCuPZWD9GTDUNnat6TIGVrzHdkeBYBEMsQ2/yrcp3RLQfz2XHoP/z5nFJZWt
 ReiG5XR0z6rsAxwpYO7PydlSqechNMCbR3u+nZVy8zbY1/QbpDOCtmHO3TKy26MqH4oqFpOSO
 i3YkfRcBSFdw+OMtZdg7uzKFy6hEpxJ8ExGES6vu7RlGSwYk9mBuJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-388345071-1558536859=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Oussama,

On Wed, 22 May 2019, Oussama Ghorbel wrote:

> git diff-index is giving me incorrect information, however if I run git =
diff, then git diff-index again it will show the correct information.
> The steps are the following:
> $ git diff-index --name-only HEAD
> git appears to list all files in the project irrespective if they modifi=
ed or not
> $ git diff
> $ git diff --cached
> will show nothing. So I don't have any modification.=C2=A0
> Now strangely if I run git diff-index, it will also show nothing which i=
s correction behavior.
>
> my git version is 2.7.4
> Any explanation?

The low-level `diff-index` command is meant to be used in scripts, and
does specifically *not* refresh the index before running. Meaning that it
could possibly mistake a file for being modified even if it is not
modified, just because it is marked "modified" in the index [*1*].

Short answer: use the high-level command `git diff` that is intended for
human consumption.

Ciao,
Johannes

Footnote *1*: It is actually a bit more complicated than that: the index
stores metadata such as mtime, size, uid, etc, and compares that to the
metadata on disk. If there is any mismatch, or if everything matches but
the mtime *also* matches the index file's itself, the file is considered
not up to date, i.e. marked as modified.

--8323328-388345071-1558536859=:46--
