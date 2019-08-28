Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDEC1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 11:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1Lei (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 07:34:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:44625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfH1Leh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566992066;
        bh=CYvuUwD7eQ+aXkowg9hBlHxYJy7qUwXB9vRNXYFfjGs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lworA08y+UuAQTcG9Rz+05a0bVzxCefb9AJtUSjzIp2GigHsbmCBgMflqArxzzt6+
         ocg1eUay/wHhpO5d92w4gYjIhskQWgUksBk7Jaqj5ia9CiJjSQOMYMLU/WWntR8O+s
         RnaiuAerhHBvcIgkmy3VNW9I+e0hlp0hn5VbvA7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtlG5-1iAwWl2vbR-011CS6; Wed, 28
 Aug 2019 13:34:26 +0200
Date:   Wed, 28 Aug 2019 13:34:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [PATCH v2 20/23] .gitignore: touch up the entries regarding
 Visual Studio
In-Reply-To: <20190826091025.GQ20404@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1908281333030.46@tvgsbejvaqbjf.bet>
References: <pull.287.git.gitgitgadget@gmail.com> <pull.287.v2.git.gitgitgadget@gmail.com> <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com> <20190825120741.GM20404@szeder.dev> <9eed02e7-7e2d-4ae3-6c08-ab17b3c92fb6@iee.email>
 <20190825190957.GN20404@szeder.dev> <e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email> <20190826091025.GQ20404@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1433146975-1566992067=:46"
X-Provags-ID: V03:K1:ostU+HQN8fmfKJsOgt558Mb8OMSYBQ2aZ/5eI7P2jop2kMdoO8v
 0UowsnWLa0qAnuGAaFo23qLgVt9yPkHyMcpSHKWW9vFUhyShJg9CgLHygOpZjzoFmaLQxMQ
 V0foMw+Zk37tLMrMgH3ILLwv3IBfI128TIIKCofAGAOaS7GA3+QqPi9HQ5g6TaeZxAxNd+3
 HJXzSN1Wn58Kuz7M/Ejyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6o7lCNUDvfY=:aAlpEog+ZfWKIztcSWmS0D
 GF/CHJNo0PJNJROSI6eQCMMf4Sb/esNLpyrWk3zHzShvhIWCyUqqfL/pF0Il+LirDFXoe269C
 LXjwuBLvHsVCTAq2mdh84BzLuM6ay76rf/o0VgenbjvG4Qbgs6NHIxVXcDHc74/WvIgF0GzB7
 VeowaFXyMMjPLOif7BCtmvGPdh5GZJWLQpO9dmlptPpZQZrGnddD+L8Vg+T62qQpEwdvyxCqq
 YIZf5j2VJrH8YSBR9wrX8V+wnxZTGHYmgC6TAA6OHrW76CGrXkR1yqc7xdy+lmB2DPeGP0aKC
 yxb1xwG0V+FVGT30NZ7h9Nw1YJLvBN4VnK4UzthGChstzflKWVkyaT5/SULSgYTQPgsjjfVuh
 NT+1bvGEX615IwpHx6i8oFm1oj/OLid7KnEoAVE9rO4ArM+PFeExOkqghute62PqX/XL7e3n4
 Bt7P6XMTDHQEeQq7RfWb50Ua2hNwzMceofvwqcryzb7tpd6d46LSMhu4C5vHCnD1KjU4UA/x+
 Gr7Z8SG5Ee2/3gdNeJFTuh3+N2C35FFX6a5rytyH+Fdve+d6TSe7657+AzbDpyuMZmGnfOM8K
 xtQPjzlf9Xr2lcAwdihWdrEVRDQR7OCLBm4xCpXBBLacAH77MrXZlCURKTe3bNqbCM8SwXUSl
 6cd1X/Tql1zlllwt1QVOwogIM+kn06Gffvi0H8DvdLhsIWgSQ47excsynRI5iv8Eg3lYCPPLt
 LLD55fiYaO/yYpZ5f+Q3YRbVdFB+6cugBSFV7PSqYrYuqZ7KMjOtEW3EAQC3gtYpQOfyszL91
 P0P3olshA7ReI5BbKR6amLASTWMnRMW7HrmvIZrlNiFmKORBt9a7huLXwvc+IiNzMHEggDs3H
 gOsKQJ3h88mOERgf/ct13slXRzYHkrJ2nAQtLu30cjtFvzuG30ylbr/2HBO23GoVPpUkNi+UC
 iuPU81MtuZvnptD35hupca2sARm4fr5VfwdH1FZ3xHp9gCZL9T0bJpLL1JacC4vSOQXq0wo+y
 e+S0ZSJd4ds4oq9yuBgzUAb1dhJPf5l7ysWu2kSdANU99hsz9QiJ8z2Vn3G6Szli8Ok+H5F23
 DzWyTNGe5224lRrJkcwixT19moTRqo2aUeH8DvGOTCHoVAP/XmF11af3y8B8vUqiPomW3M3Ta
 VA36I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1433146975-1566992067=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 26 Aug 2019, SZEDER G=C3=A1bor wrote:

> On Sun, Aug 25, 2019 at 11:21:23PM +0100, Philip Oakley wrote:
> > >>>>diff --git a/.gitignore b/.gitignore
> > >>>>index e096e0a51c..e7bb15d301 100644
> > >>>>--- a/.gitignore
> > >>>>+++ b/.gitignore
> > >>>>@@ -230,6 +230,7 @@
> > >>>>  *.ipdb
> > >>>>  *.dll
> > >>>>  .vs/
> > >>>>-/Debug/
> > >>>>-/Release/
> > >>>>+*.manifest
> > >>>This new line ignores the tracked file 'compat/win32/git.manifest'
> > >>>that was added fairly recently in fe90397604 (mingw: embed a manife=
st
> > >>>to trick UAC into Doing The Right Thing, 2019-06-27).
> > >>>
> > >>>I wonder whether that's intentional or accidental.
> > >>>
> > >>>I'm inclined to think that it's merely accidental, because, as far =
as
> > >>>I understand, this is an old-ish patch from times when there wasn't
> > >>>any 'git.manifest' file in tree, and simply noone noticed that in t=
he
> > >>>meantime we got one.  But I have no idea about how a Git build with
> > >>>Visual Studio is supposed to work, so it doesn't really matter what
> > >>>I'm inclined to think :)
> > >>>
> > >>At the time, it was just one of the many non-source files that were
> > >>generated by Visual Studio that cluttered the status list and also c=
ould
> > >>accidentally added to the tracked files.
> > >>
> > >>The newly added .manifest file does appear to be there to 'trick' th=
e
> > >>Windows User Access Control (UAC) which otherwise can be an annoyanc=
e to
> > >>'regular' users.
> > >Sorry, I'm not sure how to interpret your reply, and can't decide
> > >whether it tries to justify why that tracked file should be ignored,
> > >or explains that ignoring it was accidental.
> > >
> > >Anyway, ignoring that tracked file apparently triggered a nested
> > >worktree-related bug in 'git clean', which can lead to data loss:
> > >
> > >https://public-inbox.org/git/20190825185918.3909-1-szeder.dev@gmail.c=
om/
> > >
> > Basically manifests are a build artefact from Visual Studio [1], so it=
 was
> > just another file to be ignored, from a _source_ control control viewp=
oint.
>
> I understand that manifest files, in general, are build artifacts.
> But does Visual Studio overwrite the existing
> 'compat/win32/git.manifest' file in particular?  Yes or no? :)

No.

The reason this entry was there: at least _some_ Visual Studio versions
(IIRC), auto-generates `.manifest` files when the project does not have
any. But now we do. So this line's gotta go.

#leftoverbits ?

Ciao,
Dscho

--8323328-1433146975-1566992067=:46--
