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
	by dcvr.yhbt.net (Postfix) with ESMTP id 427521F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfJGKCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 06:02:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:50917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGKCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 06:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570442522;
        bh=KfyA7vSu84dVqaFl1Cf2NczwAngmFTxEDhBB2yYXhvc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V+S+ntxbG1Gj6zGuOqlBrF+8b8dEZyI9VFYGW8ceOM52cxRqg6xO8FU9JdhLz5LZL
         34pMQxqL2J62f0ANEV3QcgipPBjpJkh0a2Xbn5YR9Xw2bT3A3o1YVn9LQ3nLKbHUHq
         iSxoDqwqD5HHxOBu0rqkn1SAmwnH733mRPVjhF+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1ho9pp2VY3-00lCMw; Mon, 07
 Oct 2019 12:02:02 +0200
Date:   Mon, 7 Oct 2019 12:01:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Harish Karumuthil <harish2704@gmail.com>
cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
In-Reply-To: <e71835129c0628ff3b9a0653febc3737128fa23c.camel@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910071159530.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>  <20160331164137.GA11150@gmail.com>  <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>  <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
  <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>  <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>  <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>  <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>  <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
  <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet> <e71835129c0628ff3b9a0653febc3737128fa23c.camel@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1y1r4laG+ih07B1K3ZgDnL05C1dWEFxOXTauiYagvCqd4+64bGJ
 4KeK/svUQR6Vm8SyyBucBgHYZqBTu0rAer7vlj+GScvfCG75LOtXfHOd1XxpFRRyiTKYpcN
 z67Sanfu+lW3UmsbQ6+KK9gkidygf+hGUdfO8QPt+hKflV+APSar/8U9cqoVrC0IX768H+s
 ljoTkoMU/0xF72jezxhcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+qLK3AvBrk8=:EOtBER6+YsthvNu0AmV5Lt
 1yC9YfF71Zaw+NXrW5ccXxR01O2xyosOMJ1HYI1VCyzepmSOfcWSELVMigxZv8PloRSs6BM0Y
 G6oR83K/F9G3FaP/kJ7NKn8ZLLBte2QQ/wWVvifg65g0+NWv/tVpTp4Ts5xrMRl8O/zpoYOsZ
 MD9wLoUbDhVrlAr5E2jR9kK9Lp3cLEsz5VFLJZMHIgTyYyj0RtUg/6c899O6LGwQlVGHzkCIb
 sXWcYi4U0gPxthiRzmItfuJKN4/RoR6rJMwYuzETxeSYaVu3AIXILD0+25UvK78xub9Bv632N
 imWz5iEJppyimdDB8uH87yG/fcrWi4Lh5VrkGpk3rLLwNyToaXW107bsmcQ3pI1u3Sf7bWKQN
 2mctzJgbU3KGRq0vB7ntmg+dlBXj3p7/nYKNpRvacagaYvL4xsfUPY1zof9hQW766JNzL06Yg
 gvYSjSvdazbsVFx3td8Eh8+Gc1JLzuXUOHWEVd9MB+7cSmocF9DLs8z4PJVnfIt7pkss/Wb9D
 1mtQYeoF6Tkf+90p7wIQcHHICbJO88bAqW5DrooeFJrvYVtFOE3a4ZqZhtFwG1RPd0HQN3szg
 nxbe5GFk/E16qLEfKccOuqpYIAK7HZ8IomFnH2h/kKOQFy3oKqe6KIejk8a7MK6D0mUSB8WPs
 Pmthgsofp+zluG///plNMjBcR51g5jGEttI938wM6d3jUotfDLngpifhP09mIREHEoYwrQgW3
 IbP1A0Fjy2YGyuxtNHytO/tiidApiOilOlZZ9FbbeCOfbA8KCJQAP+iGwNCZtMlOYUCBdvEns
 FX9TtLYi4CYlMssqryHTP1W3IBn6lPR+7n/ysFxnKyarKeoaNMKuTSyL/5gIJ3QSOw+CWJ8s1
 0qz3yQw/pKB6iGvgbHlnIWxBhEYJdbdm8KaosY42idjeJwMeaLSOPDCr7kz0iRNFq2LtUveiD
 BE9a7/mvNm97cTp5YXIHe+/NRQWywBM4n7wlqBLLpairM7XsJhcggYtxX7iyLKDmk2uVNExsA
 WefIwhdc5ELNGu30Aa12uN1FVsVGyi7F/nr5km0QGsYk5d4SOnqnBT3AyDySq/gAqxfQqcijs
 MJy++eFDZALvyFk9afR9Qf6N2RdnEBLslPnSEqD+H8f/zHC03/iIltYQhdDCyTT6pmFTkyOGR
 LoPj5dxV3KpEn9HJLBPGf+heTFX3WBkdrR7pWPfXcryZrv181KV+RBtR0NR7GHiLo+cNGqWkp
 jSGOOKQGh1HGwKTr0nFMmVSJcD3Yqc3JsUl/o2gq7KFrWR21kTx+3bIXx6g4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harish,

On Mon, 7 Oct 2019, Harish Karumuthil wrote:

> > However, it might not even need to put in _such_ a lot of work: in my
> > tests, `Control-,` worked just as well as `Control-comma`. To test thi=
s
> > for yourself, use this snippet (that is slightly modified from the
> > example at the bottom of https://www.tcl.tk/man/tcl/TkCmd/bind.htm so
> > that it reacts _only_ to Control+comma instead of all keys):
> >
> > -- snip --
> > set keysym "Press any key"
> > pack [label .l -textvariable keysym -padx 2m -pady 1m]
> > #bind . <Key> {
> > bind . <Control-,> {
> >     set keysym "You pressed %K"
> > }
> > -- snap --
>
> I tried this, but unfortunatly, it didn't worked for me. My tclsh versio=
n is
> "8.6".  The script crashed with following error message
>
> ---
> bad event type or keysym ","
>     while executing
> "bind . <Control-,> {
>     set keysym "You pressed %K"
> }"
>     (file "./test.tcl" line 6)
> ---

That's too bad! I tested this on Windows, and I imagine it just does not
work on Linux/macOS...

> The complete ( or modified ) script which I used is given below
>
> ---
> package require Tk
>
> set keysym "Press any key"
> pack [label .l -textvariable keysym -padx 2m -pady 1m]
> #bind . <Key> {
> bind . <Control-,> {
>     set keysym "You pressed %K"
> }
>
> ---
>
> From the error messages, I understand that, "<Control-,>" will not work
> instead of "<Control-comma>" .
>
> >
> > So I could imagine that something like this could serve as an initial
> > draft for a function that you can turn into a "good enough" version:
> >
> > -- snip --
> > proc QKeySequence2keysym {keystroke} {
> > 	regsub -all {(?i)Ctrl\+} $keystroke "Control-" keystroke
> > 	regsub -all {(?i)Alt\+} $keystroke "Alt-" keystroke
> > 	regsub -all {(?i)Shift\+} $keystroke "Shift-" keystroke
> > 	return $keystroke
> > }
> > -- snap --
> >
> > That way, you don't have to introduce settings separate from
> > `git-cola`'s, and you can reuse the short-and-sweet variable name.
>
> If my previous observation is correct, then we may have to translate a l=
ist
> of key names ( in addition to atl,ctrl & shirt ) to get it working .

I fear you're right. Hopefully we can get away with a relatively short
list...

Ciao,
Johannes
