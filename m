Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1711F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeKUHX1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 02:23:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:39593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKUHX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 02:23:27 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNIAz-1gNHCa0nDl-006yN7; Tue, 20
 Nov 2018 21:52:17 +0100
Date:   Tue, 20 Nov 2018 21:52:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] msvc: Directly use MS version (_stricmp) of strcasecmp
In-Reply-To: <xmqqefbgcxwl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811202144390.41@tvgsbejvaqbjf.bet>
References: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de> <20181118215820.GA14514@sigill.intra.peff.net> <xmqqk1l9esey.fsf@gitster-ct.c.googlers.com> <15a7df69-25d8-c168-dd43-a43b7f0d34c1@cs-ware.de> <xmqqefbgcxwl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LtjtIEm6owHx45pCOLLd/Q4gQUVpeJUbslY4EDS6kmTwqCxmOZ8
 reBEByqlF68f/XdnoqgOOF4IVmi/sz5wY3doLFIwHB42yBuNMY+OLjcFVMgitPLNe4UcR/u
 QtDglRjA9F+xD+eFF4I1jeMaHRr8FZw3uZqO436Mq+3uMTclRibLbaFjGKpgay3S3lD4R8c
 oDN0yWe8kWXeoAvKv7U2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z+Lv5lt4vik=:A3ssXQkR+LDSJwib4GqReQ
 u7iqtE4H8b4DnKrGQz4Wk6yu/Ao4qeG33vLv8RpAO/2IoVFO4s9YAoUYvNiNjM3RTslT7YskM
 ga6MmPEZMYI/dTb2IspLmD/RX3WoIjO0i0sNx48yE2i/OXJTqO0N7dbRT5bI9A6oP0cu2+HH+
 T58HwrTqtSp1/DfrL54cvMesXTYtKhQSEU2t0dnHH500C0js6ZnjXaynL1kIqHAsz0g9KMOWk
 BIulFujDsJJQK58hEPmg1KqlHOa8fJhPjq4pRIPCE8F/OtdpLekN6LH+cjSYlMpAwHUCmgKPG
 lT0ljW127R5Fa63UVYrLbBUpg6gV6bGbZNqoQE0m48nuS3Ry5D9S0G25kAtH/EQC4vy4SgRpo
 p0EBRDa8DMQcMeBGt9zyQWX0Fthx+MpEIMn1gUzhzz6kxvgpFfjNft0sV6e/+C54iOf1xgASS
 v5pyW5CT2Fa/nWj1yHuuv1nlLqc8SH7IFFvEV2Z97AW8IrGIY1i2QYqL5LtXT6Hvkj/4YAjM4
 t5Y/BThTQ/xZ45M3y6fMnhLPXJhkmVl1AGxsjPVvPtxVt/MPftTYOsUsRAnDwwNTouGakCiE5
 qreZEukiEjrLplPa7tcustuhCYsubuGLDPzbb5XtsQlSdQiDU/5q/JwVU/bAEFCEg3UjBV4DT
 bL4g30pa56U0U4CxYLCUDiMkMPJfyPsUsmnl22rynbWe2R2gii4DOzWmpqi4yt47MniLgVeQx
 FjcPpbKkFIuhN9yrOTsWOX7ltnbtoUZToWW4qKfXa3avyUCSW6ns59Yx4H6lo/3w2UVO6f83H
 O915h+S6TQt8bZc4ApALJMsYLti07Xsss7WALvudSx0xy77fIJ6fdY7ybLD0S7OuPiKlyNUtE
 YC7Cg/C7SyD4PG33rdllviKft/5BA4vW3T6xR68YbFxc+VsGZwJSIK1N1a+RM9HOXc2q5Vqvm
 kqZqvOH2Lsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 20 Nov 2018, Junio C Hamano wrote:

> Sven Strickroth <email@cs-ware.de> writes:
> 
> > This also removes an implicit conversion from size_t (unsigned) to int (signed).
> >
> > _stricmp as well as _strnicmp are both available since VS2012.

Looks good to me.

> > Signed-off-by: Sven Strickroth <email@cs-ware.de>
> > ---
> >  compat/msvc.h | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> Will apply, thanks.
> 
> The substition from ftello with _ftelli64 does not appear in our
> codebase yet, but it was easy enough to adjust the patch myself, so
> no need to resend this patch.

Indeed, that is only in Git for Windows' code base yet, AFAICT.

For the record: I am currently holding off from contributing those patches
(I am talking about the patch series to make Git compile with MS Visual
C++ on the command line, followed by the patch series to generate project
definitions ready for use with MS Visual Studio) because of the feature
freeze. I had hoped to be able to contribute them sooner, but it took Jeff
Hostetler and myself a combined gargantuan effort to reorder and
disentangle Git for Windows' branch thicket so that those patches apply
cleanly on top of git.git's `master`.

Happily, almost all of the prerequisites made it upstream (e.g. the
nanosecond support for Windows, the patches to require Windows Vista or
later, the patch to use CreateHardLink() directly, etc). By my counting,
only two, relatively small patch series are left, and both are already
under discussion (but on hold, due to the code freeze).

For interested parties: the current shape of the `visual-studio` patch
series can be seen here:
https://github.com/git-for-windows/git/compare/581eb5441089%5E...581eb5441089%5E2
and the current shape of the `msvc` patch series can be seen here:
https://github.com/git-for-windows/git/compare/e9e7bd2a2485%5E...e9e7bd2a2485%5E2

Ciao,
Dscho

> 
> > diff --git a/compat/msvc.h b/compat/msvc.h
> > index e6e1a6bbf7..2d558bae14 100644
> > --- a/compat/msvc.h
> > +++ b/compat/msvc.h
> > @@ -14,18 +14,12 @@
> >  #define inline __inline
> >  #define __inline__ __inline
> >  #define __attribute__(x)
> > +#define strcasecmp   _stricmp
> >  #define strncasecmp  _strnicmp
> >  #define ftruncate    _chsize
> >  #define strtoull     _strtoui64
> >  #define strtoll      _strtoi64
> >  
> > -static __inline int strcasecmp (const char *s1, const char *s2)
> > -{
> > -	int size1 = strlen(s1);
> > -	int sisz2 = strlen(s2);
> > -	return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
> > -}
> > -
> >  #undef ERROR
> >  
> >  #define ftello _ftelli64
> 
