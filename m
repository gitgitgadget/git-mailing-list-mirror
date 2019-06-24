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
	by dcvr.yhbt.net (Postfix) with ESMTP id EADF81F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfFXJcr (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:32:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:49387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFXJcq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561368762;
        bh=b8yPFy+5IXTS3Fuo7zHXLGWyXYehwTsB7bUqmaYZfeQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H31mYFDZdxVl6LxGRkwjunh3h8GG5WmcyXz826HFfCxoDeyIfsg910Hoq3JKNpgcQ
         vxJNgYJI5SSlPhfcrwZrP+VKxDyanu0id44YuarUIXRe7AM6cjVrn+VIks3UCtHJ1y
         rhTNOlcx/om+4hp+sWSo2IkFQPKgbmJ4cf4U5jsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1iQoAJ0bjp-00lknV; Mon, 24
 Jun 2019 11:32:42 +0200
Date:   Mon, 24 Jun 2019 11:33:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
In-Reply-To: <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906241129490.44@tvgsbejvaqbjf.bet>
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet> <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yZRv7oap89hX4IRZpp73l9+HVuOOPFAvyoQ1/6hubxRtveBhMGr
 aexLRsHwGrz6keW+V6y9b56Mvll4IGlIHorRBGeqK3ffDmfKIiqpu7egmhpWQkEY3nfqzRl
 th5FYbCK5B138h0GV7Pa8dZZEtMvPflDoHfmu5Qq+DabXtDrSFwzUDzkfSnNAB5Y6UDAQZd
 keWigV/wnlSEpW1WUL/Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fQbVyM62gc4=:dDi7I/AI2lnZlRg85axwCd
 9kOdlxGPc7yodSfL98X/AXtbUrtvyATsezUdvLzsqfcKjRyE6wI0QOVDF2Hu9YX+IrHnXfYB0
 b6kZm2dGsyRHaYI5t2MiLVkW/rM4gabIToNuW/Qqp7g152JRWdcCo6YkJydzi8z0RBGz3fo7p
 8VaeNCrfxlwpt0AbXvpAD8QaOtEq7iETB4m5TT5f/vNIWcXlLPtDzE57RkUQcz7U8XNkGvAo+
 GQLm8j2xJOJ0DmFFsz4avkFcbOI5Yu5E7UpxrEkCOHTjj/1ZG9Soq1jaCs/dOj4GIpkMF767n
 BmWnBRSCn1Ei1Ay7Lki7my3+RpdKWyTDhHsRBUP0fKdW3+BWbEchZQWcs1Fdty/F8XjB9Kl20
 FZnvJEyfT2RbqSnl+7niz8T573xXNZ7A4nachQ0acPgRKsEcDA/r/XNpP17H9e9PMw6w18vGv
 o1h0+KsJN372OkgHvXszp8Fk0HQYGEXqG/gJNFMTi8kVjg81H0maqop2NC1o/czmCQSZlGBqj
 cUnQ+iBHHnyMImfxRKoaIR29oHp8BLr0SYWbcBZ1T81tB9ewFB2ZcFLJ8EZh0gHPN8ZqNk33p
 wfRLNIttDyhSAdvKPOkFIdWsm0xPGq9shf2BHzl3A6DLvQGR9lp8CcwtA/TuxUpAI9aZmPCxj
 qx91DhIeXy1YYypyu48exIVpyu9pienRz3H2FGzmhABOryZqEwN7RldU+k+v2MAx2xwx4uXN2
 OG+qwkNmLPPQFrA0k5O7D5NNmTV3S/8V3UgoxuB9HM8Ym3scmadDxDdo30ys/GMMNup62DugE
 zDpk+XSnAeZZgyszt7jtVDNjXj/totMMLkFxKVGBodCmQwm4K6Wu1m76xj2+4NZiFUBARTo31
 tfEqQqq678TRGuy+Io+j4sFv/c2EoHsHvK16sW9WbkczK7LTIHHWnAPrP4Colk4pP9hMcEe8y
 lALLUX8sy5HI+SW4hy6NAJ7vn8RZC7hoUYomnRejjmt82R1is35W7
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 21 Jun 2019, Duy Nguyen wrote:

> On Fri, Jun 21, 2019 at 8:16 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > > I think your warning in the manpage that this is for debugging is fi=
ne,
> > > as it does not put us on the hook for maintaining the feature nor it=
s
> > > format forever. We might want to call it "--debug=3Djson" or somethi=
ng,
> > > though, in case we do want real stable json support later (though of
> > > course we would be free to steal the option then, since we're making=
 no
> > > promises).
> >
> > Traditionally, we have not catered well to 3rd-party applications in G=
it,
> > and this JSON format would provide a way out of that problem.
> >
> > So I would like *not* to lock the door on letting this feature stabili=
ze
> > organically.
> >
> > I'd be much more in favor of `--json[=3D<version>]`, with an initial v=
ersion
> > of 0 to indicate that it really is unstable for now.
>
> Considering the amount of code to output these, supporting multiple
> formats would be a nightmare. I may be ok with versioning the output
> so the tool know what format they need to deal with, but I'd rather
> support just one version.

Once the format stabilized, I don't think it would be a huge burden to
support multiple formats, if we ever had to update.

It would, however, be a huge burden on third-party applications. In
effect, we could be lazy, but we would put a lot more burden on others
than we saved ourselves, so that would be a bit... selfish.

> For third parties wanting to dig deep, I think libgit2 would be a much
> better fit.

If we (i.e. the core Git contributors) were contributing new features/bug
fixes to libgit2, that would be a good recommendation.

But we don't. We essentially ignore libgit2 (and all of their learnings)
all the time.

Even worse, for years, even decades, we recommended the command-line as
"the API". If you want to reverse that recommendation, I think it merits a
bigger discussion than a flimsical comment buried in a thread about an
experimental feature.

Ciao,
Dscho
