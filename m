Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8551F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfD3Wlu (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:41:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:42825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfD3Wlu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556664102;
        bh=JEXFU5UcXlx70NTl/Tpy4QPIwQfrKgKMLYf+dA+9eCA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WyiNyLJUA1On16FY3NF9U12IABgmU9int86hwOCwu575yG1igytlj0R8dhQk6uzYh
         ODYtqvhP/yOUHT/DVNigLLuZ8/n4Rs0EAjZYAEwuhDzM+9yGHqpQWTYP2+uYUbhtEF
         IsKWuChSVoYVPslNFcV75mesSi2GWwuq/r5xkjgM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN1Gu-1hNoNB3vHk-006gYM; Wed, 01
 May 2019 00:41:42 +0200
Date:   Tue, 30 Apr 2019 18:41:29 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez?= <ismail@i10z.com>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
In-Reply-To: <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
References: <pull.134.git.gitgitgadget@gmail.com> <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com> <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1194319204-1556664102=:45"
X-Provags-ID: V03:K1:I3XFiyR45d4KM8WwmwGK7Ae52jH6KuRlNqL9622odaBO9PxKAi7
 pO8j20Xg3ya3A4iZn/ZJvctwBvf4O2ePb6DbZMqcDG4UiOE1tun6DurIMTYOM7q6x5V+rRe
 AAMy6R4IlgMF1eeAaIR47cW0qFweC7vazIlc9Yikt3lzwi62LEIcajTlshrAs4DEmeTTsS9
 Hv+G/5ppkYbRyx18ui8gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R6CVfTbeIDE=:YKyo/Qy5myY49pdRJhacHQ
 UxzTb31fEHoz7+HA5bgVXPJXdyBnCIu1LTA6jRfpRJhJe/odSdAxw78Dbt+rowx4ojwSLtsNT
 ZqY28q3m7fCvChBewRY0p0asOF8121oDQx2PKIUBxzE6YbxbDJxlc5yhIMKi554WBtIMLsG1o
 GDAL9nv3/XepsT8jbx9Ff5PYGBQFjndBhcYJT0tr0Z8Tc/qiEsL3N9GBlRnrByLvjT+myhRQg
 0AXuRd+024kvVzraHgdyWzosB4Pf1wYZMaZGZay7onFWzdHv9ORWLsz0gtqEQGVyM3OEBBcjx
 l0qnA6E4lrSvBt7s+3IslTSx+h1LLV/U/75Skr/e4RrMRjOjP2rINbeXw39O/DozKGeL/LrH0
 QshXjEc/xcWfNZh0lE7mP7ouvQoSuedHJquQZCeQvkPBvp8Vpb1NEDXwOGu3CtFf3zn/ev72X
 4sBJp0AtIzNIL+hPaVXtthJaywZO3/uFbDLyffFotSarIbazyayCSxYlibUopuIba1G0SRitj
 uPTxjnsB276pJG5lLlVJ4Emaxl1bQZb4jrEm7t8nL0ji4Oa+qwzPOlEFUvoKkhzf9AVI0tWR0
 1/7dlfD6ERvz3ty2dkgc7udDFdozEimLGvf2iqDG8OhageLnq4W8HystNkK0pKUQ9HLyR8rGq
 16dcoxrD8IQ4X+avlWxosmE4NUf75LqJti9hcxs8RETC4KqZY6lXq7DuXKf06AIjVUFu/f70l
 E1WAnR0XyQJmom47Zbe5S86qfotblv+G1D97u2sFSEWcqy1Dx1+KxYU0QMaOCDexS/jxznF+6
 JhE0gwtAtPQobAY+d10nl5nTifYUmX+G+TIYTQtH7T+vkufrbp+AW0azxqO6LUF/66lMnrfFK
 AZIY67sqM7a1PcKGoY2etG3/KS7ZkUZcQ52H5Lsb3dF/uJVa0n2llaamv0pPq7QXpv9a2vxeQ
 qEBQWTO5Zlw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1194319204-1556664102=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Tue, 30 Apr 2019, Johannes Sixt wrote:

> [had to add Dscho as recipient manually, mind you]

I usually pick up responses to GitGitGadget patch series even if I am not
on explicit Cc: (but it might take a couple of days when I am too busy
elsewhere to read the Git mailing list).

> Am 29.04.19 um 23:56 schrieb =C4=B0smail D=C3=B6nmez via GitGitGadget:
> > From: =3D?UTF-8?q?=3DC4=3DB0smail=3D20D=3DC3=3DB6nmez?=3D <ismail@i10z=
.com>
> >
> > Enable DEP (Data Execution Prevention) and ASLR (Address Space Layout
> > Randomization) support. This applies to both 32bit and 64bit builds
> > and makes it substantially harder to exploit security holes in Git by
> > offering a much more unpredictable attack surface.
> >
> > ASLR interferes with GDB's ability to set breakpoints. A similar issue
> > holds true when compiling with -O2 (in which case single-stepping is
> > messed up because GDB cannot map the code back to the original source
> > code properly). Therefore we simply enable ASLR only when an
> > optimization flag is present in the CFLAGS, using it as an indicator
> > that the developer does not want to debug in GDB anyway.
> >
> > Signed-off-by: =C4=B0smail D=C3=B6nmez <ismail@i10z.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  config.mak.uname | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/config.mak.uname b/config.mak.uname
> > index e7c7d14e5f..a9edcc5f0b 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -570,6 +570,12 @@ else
> >  	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
> >  		# MSys2
> >  		prefix =3D /usr/
> > +		# Enable DEP
> > +		BASIC_LDFLAGS +=3D -Wl,--nxcompat
> > +		# Enable ASLR (unless debugging)
> > +		ifneq (,$(findstring -O,$(CFLAGS)))
> > +			BASIC_LDFLAGS +=3D -Wl,--dynamicbase
> > +		endif
> >  		ifeq (MINGW32,$(MSYSTEM))
> >  			prefix =3D /mingw32
> >  			HOST_CPU =3D i686
> >
>
> I'm a bit concerned that this breaks my debug sessions where I use -O0.
> But I'll test without -O0 before I really complain.

Weird. Jameson Miller also mentioned this very concern in an internal
review.

I guess I'll do something like

	ifneq (,$(findstring -O,$(filter-out -O0,$(CFLAGS))))

Does that work for you?

Ciao,
Dscho

--8323328-1194319204-1556664102=:45--
