Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DE0211B5
	for <e@80x24.org>; Wed,  6 Feb 2019 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfBFRP2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:15:28 -0500
Received: from mout.web.de ([212.227.17.11]:60879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfBFRP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549473318;
        bh=vGIYKON5i4LVQwJdijfbQbYO/OGGB0lSQNiT7dPiTGM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=go0yJ9dlZRAK9ZdFZsQ+b3R7F24kpd5qMl2iklZAR5xDFSPSM020vsP72PSYb0TAv
         WKZOjqJS1M8Ah1VDCYolZvFiye2AR4iFbQTfgq/vv85wwpH7JHFRreqfsUtcFG3REl
         bYKFrSxwTUSyeGHji9TiGMLrXyJ6t0/2KLF4uxPQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSLn-1hHFET2sjr-010esL; Wed, 06
 Feb 2019 18:15:18 +0100
Date:   Wed, 6 Feb 2019 17:15:17 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: t0025 flakey?
Message-ID: <20190206171517.s5lskawpdodc74ui@tb-raspi4>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
 <20190206104243.GJ10587@szeder.dev>
 <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:HQqEiuBXNQ3BFVeBjSGJOVGqjyWK2Vt2K7WK0CRFG5WGcMyYD0l
 fTTVTxJ4P8VwvjJ2ppSPIkGhMaJwJCOmGmlt9iJUSk9wyGQNShhZ4bTwM4AOie+m7dg/hVv
 KBa2NQcGxwdlulbttzGFARHI0fsciM/WeeznAeFnezVaqLrvFH4Xd06M7m8UBo8ESHnjIDl
 tJH+tEjCuHTXJoBNSHrHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PKf76/kyYZQ=:LWUue6ZEz/pT9OZxFBFUij
 zLAqDilNuq2tlcL+ZakVQhAcP3/QdeI+jtX4xvj1DluDafkfxbKd9uoWiEnFAGlIB7WOZ11dz
 lMpDeUrZkF0r4ll0rVtChYmf1aepzmgYFmAl+RDQ8jCtMpu4bkQtfQLbA+r3bMGmdNKCNTX8A
 j1TWr89mgCHCiP8G0UqRsY5+Fpu33vwH1K+1P6/ZM20UpgUuYZ28kYilCEtl9uBwWiSb0X31t
 4TEkDXTy+PVnDXj/qwbgs5L1DIBz+zjeY1Fl5iPPOmDOqIFKOrHxptLPGlAEI8oNjXWSLyfkY
 RpMJbZtFwsEaWvx8Z+/MyHHrHQNSQutRJUP9r6CZAOkJKPNnSMTu7pBoTRp5G/vuet4Y5MmIo
 917jQCX7ZHTDCebhEAfaPNON1Hk7zpa8aKjIGSxJtkPgTpSYbt9c1YwmXAqA0XGRmUZLlegg4
 xieHXEY6G6yqohJxC36gy5vxwdvyeJjuz0H17wnc+wi8JiB1p9EBFu3RBRLyakuts86zpcKE6
 z0rU6i30PDw1bVZVDn5saG0rLVxMPG2P9oEqKt2mTLh2gnX/9e2QlmR7r7k8xQeBNH52K/NVG
 ldSFUbLCBctiqyPO1PlDdAXmx4RuJ8wGA4SqN4zGnBYKsCaBCUrmWbgFVf2CZxWlyUwDY8vpe
 UcPkIC4vNRAV32jeCxe8l+i5DomxuflgqOSSxJHPJDm2Pqb2ubIOhSxsf0P/DpTv/LHVbbCFs
 vnnp6PiRNn1BR3GOB9vnfdNn77S+kHZYk5RtJ9/YLNjIgTjdkwaxcVvz5/puzSls6K2oSR9US
 aZc5kf5uUIsOMBB8B9OQSOqtC7N/Aq11up4iAjsYo7kampNlFJ1xT4m4pp1/f87u8p/pv6UaE
 hmQgzqRbqnngY63KEQzXU3EbzpyEvaKpoQhHD97664bbIUMeyJ1WukkfkDRyrL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 02:52:53PM +0100, Johannes Schindelin wrote:
> Hi G=E1bor,
>
> On Wed, 6 Feb 2019, SZEDER G=E1bor wrote:
>
> > On Wed, Feb 06, 2019 at 11:25:38AM +0100, Johannes Schindelin wrote:
> >
> > > at first I thought that those intermittent test failures were limite=
d
> > > to Windows, but they are not: I can see it now in a build on 32-bit
> > > Linux.
> > > Full logs here:
> > >
> > > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D1032=
&_a=3Dsummary&view=3Dms.vss-test-web.build-test-results-tab
> > >
> > > Excerpt from the failing test case:
> > >
> > > -- snip --
> > > not ok 2 - renormalize CRLF in repo
> > >  expecting success:
> > > 	echo "*.txt text=3Dauto" >.gitattributes &&
> > > 	git add --renormalize "*.txt" &&
> > > 	cat >expect <<-\EOF &&
> > > 	i/lf w/crlf attr/text=3Dauto CRLF.txt
> > > 	i/lf w/lf attr/text=3Dauto LF.txt
> > > 	i/lf w/mixed attr/text=3Dauto CRLF_mix_LF.txt
> > > 	EOF
> > > 	git ls-files --eol |
> > > 	sed -e "s/	/ /g" -e "s/  */ /g" |
> > > 	sort >actual &&
> > > 	test_cmp expect actual
> > >
> > > + echo *.txt text=3Dauto
> > > + git add --renormalize *.txt
> > > + cat
> > > + sort
> > > + sed -e s/	/ /g -e s/  */ /g
> > > + git ls-files --eol
> > > + test_cmp expect actual
> > > + diff -u expect actual
> > > --- expect	2019-02-06 09:39:42.080733629 +0000
> > > +++ actual	2019-02-06 09:39:42.088733629 +0000
> > > @@ -1,3 +1,3 @@
> > > -i/lf w/crlf attr/text=3Dauto CRLF.txt
> > > +i/crlf w/crlf attr/text=3Dauto CRLF.txt
> > >  i/lf w/lf attr/text=3Dauto LF.txt
> > > -i/lf w/mixed attr/text=3Dauto CRLF_mix_LF.txt
> > > +i/mixed w/mixed attr/text=3Dauto CRLF_mix_LF.txt
> > > error: last command exited with $?=3D1
> > > -- snap --
> > >
> > > Any ideas?
> >
> > I reported this and Peff looked into it on the way to Git Merge, but
> > not working solution yet.
> >
> > https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.n=
et/T/#u
>
> Thank you!
> Dscho

I shortly looked into the pointers here -
Is t0025 flaky after the fix from Peff:

[PATCH] add: use separate ADD_CACHE_RENORMALIZE flag

Or has it always been shaky ?
Does anybody know ?
