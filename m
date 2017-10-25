Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21B6202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdJYN06 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 09:26:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:52466 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbdJYN05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 09:26:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaWlT-1dTO7x3xK3-00mHP3; Wed, 25
 Oct 2017 15:26:51 +0200
Date:   Wed, 25 Oct 2017 15:26:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kevin Daudt <me@ikke.info>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: do not get confused by submodules in excluded
 directories
In-Reply-To: <20171024082029.GB7987@alpha.vpn.ikke.info>
Message-ID: <alpine.DEB.2.21.1.1710251522530.6482@virtualbox>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de> <20171024082029.GB7987@alpha.vpn.ikke.info>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Tz96wlt7k3mLAByo+8e+/hgDfhjVy+M3jBd//fq37zxNYm28rTo
 s+R3KzkAdwe5kuEpxV1sUWsaaeDIWzBh8F9dxztIFsyO1LrB++mxmopMBLY1APNvKFk/gwC
 8dPVXz/pTtQBfBTqRFtAehFShibiKU+zHpiUJmhruoirtxQrMXjYpvNJJCXFkjNp4PeVcBt
 0KGv7uhVVTugyYaHjizHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f6+0MQfq15A=:A3LNgmKtR+KIlEQv9cPf+/
 utrmLb1S6AKPqAS72hW8YcOxzTjI9+41zAoHJBpGJvUPSPKBf6TV5BXipkS2wWregeV8iUtUL
 cirjMyLNuSetMFoTi4ga4gUrbnBQp+KNc4xr++ucebujoQDqXw0L4fM6ZNI4jtqoyCQ4gMwDS
 c2Z8twklc7385mlyeTfYspy1W0Sc4VKz5ylXfC7mzQCy5uKTEW163mO6QZBFT3ztsiznq6WBR
 Xa9GJfHML2wE6rNB0SBl2a0DXgFceI6UaqmLUr6rL85LsJRPqZoPoJDPFL5aoiXHPYJpPbvLH
 bIv+V6H0nEpWxmiaSrciOEgYVXfE6scP2B6wdPwc/lKAkqWxlslZt2t2MjUWzXyNMXLEwxd2K
 WhgVLPiAYYorjyS/GJ7QDu08QYApDL38Uqx6xme90YVo4WOUzFXalcrkdRRcZlczE965C1wRe
 afNTbLgcngZebRaEQnC6v5HHoph2bN5RL1tVOsD03VoI9g3aKXGkNFPT9R/xLUDw4lHwbmfaC
 TsYhdoLjZGziHanNC6LGdrximuYX5wbjkI23gH8XWe4g/L8wsWEfSznTx23x4YRKSc4xrvRPt
 47fFx0OTfmTVTHYgqsoE9LXlahGHHr7S7W5zDR5y9LYb/MltRwm83Ju8aJuQL54hsRFcpO8s+
 Lp7BjnfPB1o3jNctfsp9JTMZpVSzgkflz/69QzeRz9aRAxFaSbaqwnwTHu8N2GtZXE8P1S7m2
 eX68fpRPNDomlW5TOSc4edwaUwPT8yix9IkfrM680vqB1LPrUZPapp6R5FqYTeZEP8Rlh51rL
 lQ8d5WzfcHca8pxiu0x6jojf6mq7GSmhplpwaxDjYdoHb16s6qvfBzH4u1Cyckp3DeF84qb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On Tue, 24 Oct 2017, Kevin Daudt wrote:

> On Tue, Oct 17, 2017 at 03:10:11PM +0200, Johannes Schindelin wrote:
> > diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> > index fc6013ba3c8..8c849a4cd2f 100755
> > --- a/t/t7061-wtstatus-ignore.sh
> > +++ b/t/t7061-wtstatus-ignore.sh
> > @@ -272,4 +272,18 @@ test_expect_success 'status ignored tracked directory with uncommitted file in t
> >  	test_cmp expected actual
> >  '
> >  
> > +cat >expected <<\EOF
> > +!! tracked/submodule/
> > +EOF
> > +
> > +test_expect_success 'status ignores submodule in excluded directory' '
> > +	git init tracked/submodule &&
> > +	(
> > +		cd tracked/submodule &&
> > +		test_commit initial
> > +	) &&
> 
> Could this use test_commit -C tracked/submodule initial?

Yes! Thanks. For some reason, I did not even think that test_commit would
accept the -C option.

Ciao,
Dscho
