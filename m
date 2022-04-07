Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCACC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 12:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbiDGMjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiDGMjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 08:39:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD32571CE
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649335034;
        bh=O9f1FI2A/nb0Nbk2DvbFEEi93cezTd5OgSryMtcH2HA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZPwFvEikwoKpTcbfoPIZVk4dJKsUfD8y4IJM6f5VZf+xZeDcfijocZfxM+kAhSr9P
         FrjA5BQTvs8Hyu1KZaWh/R7CWGYQ8/Jf41KTLk8gqHWC5W0U4L/SzPo5PeQtlMJwks
         p/DHVYe/f0MYqUBOZrnPHSQwCTgWCpoFxh7Bf/i4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.214.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1o4q9a1lU0-016Py5; Thu, 07
 Apr 2022 14:37:14 +0200
Date:   Thu, 7 Apr 2022 14:37:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Teng Long <dyroneteng@gmail.com>
cc:     bturner@atlassian.com, avarab@gmail.com, git@vger.kernel.org
Subject: Re: Git 2.36, ls-tree submodule regression?
In-Reply-To: <20220407022207.12542-1-dyroneteng@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2204071436150.347@tvgsbejvaqbjf.bet>
References: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com> <20220407022207.12542-1-dyroneteng@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1170198910-1649335034=:347"
X-Provags-ID: V03:K1:aoQ3ffyMfBFekGhBmEUINEC6hLWqwqhjlXPJzHXLiglH9nmkn1p
 QdkGorlBiwe3Bw5MCY6j4++xIUVMPFSEQCjPmQr1Bgqj7QNduHh3iUSpPlApkh8v4ClH5Cw
 +1CThSrN7/S5qzBRvk3oq+6DfAe7shN120BdHNHb1dQgwE5PwD/jpuop30ZDHPrR/V/+ouL
 n25P22F7l0UL3DtQm74lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vjeN+44alxQ=:KsOzIdtSi5w1pKr7+v+ja6
 Cg1DxbAtZZebHdlQWSVaIfOUSHdRxEjS86dHqQKsBwptqCy+hnVuwiQtuYvKJtbs5xb8sHS3l
 DyskVgD5YKolVILsJZasA8f+nmRSKJ9g4xTxoNG/DIZFr+vLDcEauJPOI58o/5QTyUYIWuSY2
 ZIKoUiQOj5NvXOtH8G2j1kg1VXEjC08mATtl4vq1vqivhKt3pTHUYl1GcdxCMc55cytIDEciK
 aAnpJ+LnQmvgJWo9vKnMwpDnePQSv6dHaZyyUo5rCMSKmTzYhlbnHS7pgKIszB6NUigt/IGZ1
 q3aoa4EIFn1V52yodY0ffaKe8+ykR0cCavYTt1etBRXIM/lrMDDG6o2GOl8EXN4rm6BZOs/Bw
 WthF3ezpTIz14X/02LxgzuGyq32yk9kZagIDzkLjzoaEHjc2KoxNbUR5LFKaWpy9m2G3O/4EH
 upOpj03QXgLg81Otci1e8i9kA1hXI4bI4LsrdM2/TiRiiqmHLf1aLnjv4MONx3JyV2j5XnDTs
 tfjsG1/5GJHFQnM1AUEuB7vC7X2TWQvKW2R1UfxS8pljwL2tXcKIsLSFkxHaBhxESyXsOGl7s
 sdCFEb4yr7X+GjhbbgOwNcOQPrITWC0wa/E3kiSTfH/K2W0Hry+bjYw0ejo27jLmnsKOilxrb
 qe9eWIE05DDZEE/gdFFAjz5v38YNKldqFDmFhnNTYNb+F34C1oB9/Zhdx6cUWE70ZzL2WqiF+
 6NECrsMm/AingU0bDy2yLkv+eoGlpt2q52gYYjq92EthmPoM6TAdkkhA3ZPrsGwdnCSQUpDLN
 DZu27qXr8mdi6BNW9QUi1SQJZP7m0cduTcJr/T8KvClOv2McLUM78om4S4ZM6Lbts6CJafH+Y
 ECCsU4sBAAZIxqGvYhvi3pBf2rnh/tMBo8HkKlbW974ryMaJVFZI3xUuH45ajEse+j4XIHv46
 gzv8x/gwp4jIOlfcKfpfOO9pWF88xGHF7TomV+YWi886oXv5tfQ1KmvATjFRgJbiBekGdHtbU
 rhcx6LNzsBvO9cnFyRRB+Xgglk9fuPYBtoLDdrOHOdTphl9A5YphalaE395cv0/8FHVKYT+Zn
 sKAg+il3ZwgTec=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1170198910-1649335034=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 7 Apr 2022, Teng Long wrote:

> > Bisecting the error selects:
> >
> > $ git bisect good
> > 9c4d58ff2c385f49585197c8650356955e1fa02e is the first bad commit
> > commit 9c4d58ff2c385f49585197c8650356955e1fa02e
> > Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Date:   Wed Mar 23 17:13:15 2022 +0800
> >
> >     ls-tree: split up "fast path" callbacks
> >
> >     Make the various if/else in the callbacks for the "fast path" a lo=
t
> >     easier to read by just using common functions for the parts that a=
re
> >     common, and have per-format callbacks for those parts that are
> >     different.
> >
> >     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
> >     Signed-off-by: Teng Long <dyroneteng@gmail.com>
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> >  builtin/ls-tree.c | 199 ++++++++++++++++++++++++++++++++++-----------=
---------
> >  1 file changed, 125 insertions(+), 74 deletions(-)
> >
> > (I've CC'd =C3=86var and Teng on this message.)
> >
> > Looking at the changes in that commit I see differences in the
> > handling for long listings, so I tried removing the -l. At that point,
> > the command works again:
>
> Yes, it's a bug but already found and fixed by =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason.

Correction, it was fixed by Josh Steadmon, and =C3=86var proposed an
alternative, but Josh's version made it into the `main` branch:

https://github.com/git/git/commit/350296cc78912c245847ec65e55143053450cce1

Ciao,
Johannes

--8323328-1170198910-1649335034=:347--
