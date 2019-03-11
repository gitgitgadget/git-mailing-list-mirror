Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A7520248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfCKQc6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:32:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:37855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKQc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:32:57 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVe87-1hZ7DG2kO7-00YvSZ; Mon, 11
 Mar 2019 17:32:53 +0100
Date:   Mon, 11 Mar 2019 17:32:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: allow building with an MSYS2 runtime v3.x
In-Reply-To: <xmqqr2bfmt5z.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903111727510.41@tvgsbejvaqbjf.bet>
References: <pull.160.git.gitgitgadget@gmail.com> <ba1a87e845919804c86a7859abb85ec50125628f.1552060278.git.gitgitgadget@gmail.com> <xmqqr2bfmt5z.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MuXAJVai3rkMkSjdVeJKu5ynYfZ9+nYb7pa4DsoMoyvnhqF+XiY
 nKMEHsRZrV/bhJNrqhhMG4kYmMuSQ5lqWgkm4iZ7WXsW2qqfquPsxorHyBs6NEgEH3vqusb
 Dm1W5BACGXwjzORl2grHFuQGxKifeAvsKxj23Cf0r9H1cXsCpXVtO9X09KXRVXfCgl7W6xT
 EozRQKo6AuoGJKd1vvksg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ub69rAjoxe8=:6I59ZRBk1XKXKvsJpSpmTP
 vonMXEEG/ufu8Fg4LHf8E8Xd0G2MjfREAv3Eq82hNWY260ASQYFtiyJdExYIjYfFPJ0y9Oxng
 3HMhj1+WYJWqTuPd26RBxrt43EX1Iok/KET4d6I1CHfYIWaxo1TaTm2+v+KOUJhW8Y0Gi/dLf
 ymVMBxG/5VWdVdzvxRLAKcXwbr6/1SmOMBe33dmFArXu+0D6fihatcKqBRN08jt94V9gKHD9d
 BNdiYzkkvDCg6VIjRD6B9HzwLkQgfuXm2gTxDXi8aWBLDcv51/l9pzz0bZWkVQinR74m6VxkJ
 TDO3Q9rtbmqKSHxmsrDbIOdcXdkjvJuEIjFT46Vg91aG8VbHMjPeFaM2tC4Qwu2k14v79PN9Z
 L9HaiMk3TI2493oxUJx6Glq5uBZTKWs1Eg3q+wlkIS7U/sCHGI35aoepZf/TJLpvhuDXSHIrv
 ZVHXWPa+yOQoIFHLBcclqfDRRYcMLI3354BAlyfG9PknNsOllZ8hIKN5o9MW5+Znj9B0lMu87
 OMc5G9sQVOPPh+2aCIn+lQkJR4L+fCexsVnmEZWx4tSDL99+Nje+vqwPOlfjD0Ubt5BoIpWbU
 LS8TMqrxVZoHf/wgnJ94esDm+8LKsHQgKkF0tCdmc2awIrRNmm+onzATIxB9HjbMUJ9ZXn5QS
 g7kaAuHi9VkqmKq3bYs1cBpmnAToQYBlyVAMIw1AEApSphnzAwZmvXWVrbPeQxCOzag5GYYfW
 6CS9+iiXc4DMqpLYAtLYBLXRjF+Wo1RC/xThE5+dHu7A/Htb0KLFMGM0ZJH8hWbh9SJ5uYgvT
 r4+D5nXVT5peNXoDbe1Fg0lTe4MClzgvkz03Eg+wG9bOme6q96hse0ryXGN0tXYoWfmLPCZEJ
 yYANr5OBLLINV/lzTks9lPqEv+T6I4DE0/aQK4f8/ECDBEm+u13eeoUdzn+T66ZXqmwivH/G8
 EVeTqKUOPnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 10 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > So let's invert that test case to test for *anything else* than a
> > version starting with "1" (for MSys). That should safeguard us for the
> > future, even if Cygwin ends up releasing versionsl like 314.272.65536.
> 
> An obvious alternative is to do "2" -> "[23]" *and* update the else to
> an explicit check for "1", *and* add an else that fails the build when
> it sees "4" and other unknown ones.

Right.

> I do not know how compatible MSYS2 runtime v4.x will be with the
> settings the part inside the ifneq() we see here protects, but you
> probably do, so I think this would be good enough.

I would expect Cygwin v4.x (which will be the basis for MSYS2 runtime
v4.x) to be as diligent as Cygwin v3.x in maintaining as much backwards
compatibility as possible.

Read: I trust "2 or higher" to be the answer.

> The only case that makes any difference is when v4.x _mostly_ satisifies
> but slightly differs, affecting the built binary in a subtle way that is
> not discovered right away.  But in such a case, the more cautious "fail
> on '4' that we do not recognize" will not help much, as the first
> reaction after seeing the error would be to copy the settings that used
> to be OK with v2.x and v3.x anyway (which is what is being done
> here---we start with the assumption that the support needed for v3.x is
> largely the same as v2.x).
> 
> Will queue directly on top of... 'maint'?  'master'?
> 
> Let's say 'maint' and merge that up to 'master'.

Thank you.

For the record, the really super ugly hack I plan on implementing to make
Windows builds pass in our Azure Pipeline is to build the
git-sdk-64-minimal artifact (which contains all of the stuff needed to
compile Git for Windows, such as `make`, `gcc`, etc) is to "install" a
different `uname`: as the MINGW binaries live in `/mingw64/bin/` (unlike
the MSYS binaries, which live in `/usr/bin/`, like `uname.exe`), I can
write the following script into `/mingw64/bin/uname`:

	#!/bin/sh

	case "$*" in -r) echo 2.bogus;; *) /usr/bin/uname "$*";; esac

This will be the stop-gap solution for branches that are based on commits
*without* this here patch.

It's ugly alright, but the only hack I could think of that actually will
work.

Ciao,
Dscho

> 
> Thanks.
> 
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  config.mak.uname | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/config.mak.uname b/config.mak.uname
> > index c8b0e34c31..0207e895a4 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -569,7 +569,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
> >  	NO_GETTEXT = YesPlease
> >  	COMPAT_CLFAGS += -D__USE_MINGW_ACCESS
> >  else
> > -	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
> > +	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
> >  		# MSys2
> >  		prefix = /usr/
> >  		ifeq (MINGW32,$(MSYSTEM))
> 
