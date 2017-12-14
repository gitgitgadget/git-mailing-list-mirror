Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8191F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbdLNX2D (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:28:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:52713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754358AbdLNX2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:28:01 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK0bZ-1eQSOh0iUH-001NMw; Fri, 15
 Dec 2017 00:27:58 +0100
Date:   Fri, 15 Dec 2017 00:27:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] version --build-options: report commit, too, if
 possible
In-Reply-To: <xmqqy3md85zh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712150027360.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>        <908989103a06291e38c8551c447bc73eb781fb26.1512752468.git.johannes.schindelin@gmx.de>        <20171208172733.GC14261@aiede.mtv.corp.google.com>
 <xmqqy3md85zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8lMuZsFxgA4bNpPZcsLigTE9bA0R0nS4p2kgNMC9ResX/wLCMOd
 6C/rOSOoQksfzFoP2JgEvkbAKLTyJ9JZDxSB8sh2AMFwLLtlpPJ5Cf0StYU+guRq/feegXy
 JgCMSRkvumGTDdSHjqY/VaLZDMv13fPQ5FgJFG4lTaaRj3Nrv99PwrHtV8A1Xoff+lMUm7M
 2qNLi/g89abt8qgIJmDqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/OPEA35K3NA=:uKrPSghkAfWzcU/DS7yaSo
 PW4kgjTcAPLRJ/oQOMW/OaWfJ3/4o9yG5GAo8XiFKFhR+NOG40h5PPVAIOafWSjgW7RuYH0y6
 a8/Nybpo6gxNGPV121CEl5iJOt9G0arfZAjtIvCuywh4YHbD42IXZOg5yDRDW/Fcpi5at7gaR
 ExbNkAYvTmIpWYu0p3Z7tu1dxjyICOfTMUE3/UdNSZtTZbnQusxaju5czNUm2nbVdsfdIoP2+
 e7tNHuLD4MIvem30SgEOdCF4r5mi8Q5UsRiHw84/Knh8oJ9f4iUT1PUlkHj0ier0fNvoWQxwl
 GouMgjC3J5RTv8vNQbB2f8yELsO9nnPWs1WXdweYqD10UhdJP5E4jdVmS1zM7rnv+qXTNAdbI
 5f9pWbWmCXU0JOZv/zf0jHCvZ2JQ9eb6/e7xkxjgNwmbuzqkxgtrCVHrRitIeiprvVIsmtfyL
 Ys1vsXmH9U5bzXBKmCBbKULoA7q+bYUVuSZzTxFFrBm+gbzVK2w27yd7MY3CKdHC/ILW3dyJK
 FoIspBq8xSuHaFlVCqaBLJumojwVA1hyh74z3CLlyHC/260JE7WVpKyUBibvfwfID/dTspiw2
 Nc0wPHFflvUHlcAahuN8SwIYIXoy16sC9krV6SwxlaWcrZlQqcESOWlp4r36ckb8AjfXEtDVB
 PUYaZByQZc/CrCzl85fB2eU80oS6zs/cZPCHcfRa5psOhDDj8s9rHCirOKGkImiFsRhdB+iUE
 5g+iRg3fuVlq+ts+Lk6QYrsNajZq6YK5z4DSpBhy0d441TyT+RCgnAnooATZxEiNHLAQpRTlh
 x/B9ijg56LA6cPlzF2ukoob/kNDdjp8D7h1zYnIkrffJJu362Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Dec 2017, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> We need to be careful, though, to report when the current commit cannot be
> >> determined, e.g. when building from a tarball without any associated Git
> >> repository.
> >
> > This means that on Debian, it would always print
> >
> > 	built from commit: (unknown)
> >
> > Maybe I shouldn't care, but I wonder if there's a way to improve on
> > that. E.g. should there be a makefile knob to allow Debian to specify
> > what to put there?
> 
> Another "interesting" possibility is to build from a tarball
> extracted into a directory hierarchy that is controlled by an
> unrelated Git repository.  E.g. "my $HOME is under $HOME/.git
> repository, and then I have a tarball extract in $HOME/src/git".
> We shouldn't embed the HEAD commit of that $HOME directory project
> in the resulting executable in such a case.
> 
> We should be able to do this by being a bit more careful than the
> presented patch.  Make sure that the toplevel is at the same
> directory as we assumed to be (i.e. where we found that Makefile)
> and trust rev-parse output only when that is the case, or something
> like that.

Cute.

I added specific handling for that.

Ciao,
Dscho
