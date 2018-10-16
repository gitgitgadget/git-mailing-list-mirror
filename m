Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406991F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJPU22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:28:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:53923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJPU22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:28:28 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmrZY-1fiXRL2a0S-00h6Mz; Tue, 16
 Oct 2018 14:38:07 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmrZY-1fiXRL2a0S-00h6Mz; Tue, 16
 Oct 2018 14:38:07 +0200
Date:   Tue, 16 Oct 2018 14:38:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] getpwuid(mingw): provide a better default for the
 user name
In-Reply-To: <CAPig+cRbOOrC5_jCnR2ohMZWoYXfNqvWtj3m_JTpudJhV1mQng@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161436480.4546@tvgsbejvaqbjf.bet>
References: <pull.45.git.gitgitgadget@gmail.com> <11025b1639785577924b2020fb20d076308e9c69.1539596822.git.gitgitgadget@gmail.com> <CAPig+cRbOOrC5_jCnR2ohMZWoYXfNqvWtj3m_JTpudJhV1mQng@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rRC91hspNJHn/syqIxpprR2Zr1ZiDOo6sYWZfWL8zhtxymZ2eR9
 1Wq/VmrfC09/zXN5jE/Pi1/09wntGEOehFVDLyaXoXju/TdNu1UIq1HuEUojv3iyljcN9Ya
 wcRkvFSzjMjSlXCCxz4p9ejfSeCuEw7ConWoUPa4UFkUB3hwwn4m8K9bGF8HxXqRqzDwF79
 owDIe1Tcav4083s2fzkcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b4HaUSF4Ls8=:9fYaG5F+PoxDmsBFsVsZFo
 O6df0XpqZndiWJPgNoQRiFZQOFCTdSIsGY+kkEb94VON25CB+Rq3hh68upvAZS+B9t6yViAx6
 k5AFm+Jme6ReHxug7Xycdcp631PA7sQSJH/kWbvDhlixW43hsXwWykOYwvsCZ54PF5kWrjGzt
 5/p+M3LauvUYWUAUS+sp8Qa4R1/inE7MLG57ezBMzT/B5SWRehveX3BZBcomu2GYLN7RvhBLI
 keyqPtuEDqqdlizImLnhRZq8/VVfa0ahR1CgBKp2PQ4lXViPs97PNbkcp5EPT4pvgUMj5ghRS
 iTd4x7I821PsPksY+fhOSAyGeneuNNC8ZB37q6crgcRLd72L9Pl+Kdnr6TC1zeSXwgx2EA34f
 TQp8S7bf8Vi1xbH/7Lc8WQnrzXiIi6qWz7ZQQ1ifv4WB0ZindqYr2LujPD0rSRsF738DQHVu7
 W3QIbvS4Isd7uLQ2XYpKzgi+g9+ecMk4BnZ7xt2meepnmdaRRf22Mv4YslLRtQO8CCtXNTUWW
 EwC94Vldpgb8CuDZcmy0FIOsVhKT/eOgpE/JiA6+opBOiHCmMYfpQLW6ODhk/14OSA3CHjMfY
 suvUxdBpSJdXWfqA4yEVLu9QsnZK65VXHAgyQqRdNee6zNSSClS8x02Cs6bFctjcHjw3L6MLd
 WCx0Qaxc/KT8QQKsOYjY1S0enZaPp5vn6YhU8AlGjxCwpfU3fd0vN9++e7CoEpTrM4dtIqY8i
 dyvMX0kjscbC1s3g2p9VPFu/nmY48nDtrmCxPgyuKEebqIbkxzGNFds1EJx5SKQqebr37Xchq
 e3CChHckU1+MHu0InTgFL/q5ceF5nJ/RIN8ZselW6Pt9bkqgQc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 15 Oct 2018, Eric Sunshine wrote:

> On Mon, Oct 15, 2018 at 5:47 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > We do have the excellent GetUserInfoEx() function to obtain more
> > detailed information of the current user (if the user is part of a
> > Windows domain); Let's use it.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > @@ -1798,6 +1799,33 @@ int mingw_getpagesize(void)
> > +static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
> > +{
> > +       DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
> > +               enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
> > +       static wchar_t wbuffer[1024];
> 
> Does this need to be static? It's not being returned to the caller.

It does not. Fixed.

> > +       len = ARRAY_SIZE(wbuffer);
> > +       if (GetUserNameExW(type, wbuffer, &len)) {
> > +               char *converted = xmalloc((len *= 3));

Oh wow. I *just* realized this. It is an off-by-one: the `xmalloc()` call
needs to receive `len + 1` to accommodate for the trailing NUL. Will fix,
too.

Ciao,
Dscho

> > +               if (xwcstoutf(converted, wbuffer, len) >= 0)
> > +                       return converted;
> > +               free(converted);
> > +       }
> 
> If xwcstoutf() fails, 'converted' is freed; otherwise, the allocated
> 'converted' is stored in the caller's statically held 'passwd' struct.
> Okay.
> 
> > +       return NULL;
> > +}
> 
