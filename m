Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544A11F744
	for <e@80x24.org>; Wed, 13 Jul 2016 08:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbcGMIBp (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 04:01:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:60699 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcGMIBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 04:01:43 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LnPnu-1atwkl2ZCw-00hdJY; Wed, 13 Jul 2016 10:01:01
 +0200
Date:	Wed, 13 Jul 2016 10:00:59 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff Hostetler <git@jeffhostetler.com>
cc:	Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Add very verbose porcelain output to status
In-Reply-To: <5785170E.9070000@jeffhostetler.com>
Message-ID: <alpine.DEB.2.20.1607130958130.6426@virtualbox>
References: <1467919588-11930-1-git-send-email-jeffhost@microsoft.com> <20160712150749.GD613@sigill.intra.peff.net> <5785170E.9070000@jeffhostetler.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nUKO0sRaKV23zHgtXEFGHOwiGbOFDn6ow8rTw7SSvFjrlLCit29
 Vf5UkVwIrCFBtZbIFCMy5MOzKi0T80kxgWB2wNhFMQFTWZH+jo8+sQUHkqrKYTSGaS1PYjY
 NFvUyVvtxul6QnDdwGQUhpvnYVhIz7O5ZD1bJjq5t0UT2dCK00lk10sfiMiJbxnpLa0ChqP
 EmeQOmv6lE2MwBw1u+olA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Wrq3FNkb0mk=:WsdX7woXzkYY2AtTUTv4zv
 Apu6U7Sm5wgVPLge0BCkj2ZX0hu0/gtwVw3rpnz9SZ8aFLC0JTKSUS4qPeT1n8Pn32CmdwQrC
 nBzC9bvl9HsdWgVl2nnFAWq/iEzpjUk58ZvN1rmHe4YE/T+eMgV1IYl4sqaxPNeSs4DBy/ipE
 XSheHwBsqtdXF9oxpZd6jBuvqGeFyGevw1O0Tp8s7nPUIu24r6LnmzoJFBdUHkdJswpzbq78o
 umS2Y2qpWqkv74vpP+RPczfsCZAW6voz03EDm88ZOdPl1IKFc7CN6crO0wceWiJmXNSWDAxtR
 ubF5hnT7njB+pI2FA8nMZtRXMe66/elgsl/e8Gjrr4WWUdg/Ftr6RAWA2vRhBUUc5PUGWyG4R
 i818RFJRmjcI37qMzDvbt+TlJ7dAUPmn0azzBK0wWpgXO9m0UavJqQPMeGjUiXNKlFCpVBnRA
 q/ieqdDSC0+RV2M/2gorMwGiUddR1fYaceKs2vLS/Yb5ODO4hEdRTjZ0r24nOEFhMtMgEHDNJ
 ESO7JjxVcaXMy1RDZ+lkf6kfsTH7Gh1barxfGByegLreXN+ZAvcYzmaA6lRIM2bwIFGvOxcLE
 LcJ7Mxt1aaWRpgmDXO4g0H8omxg5e5r0TeHCvxXUllcHsLSigGdtPNVJCU+Y9/NldhoXScWPy
 kWZw+Ng8YCebGOWSaKV+9e/9HWvXgBB5SLhbxUYpuu8omH7Wx4N9+1fZoNWtHT5wwUsh1O1ym
 LuNEFr9Uz+0LBRPTUav7FpYQ4GGFAGBHFbbQrRN0sc7Yfc1gITdHFjBT/4ML8kMqISz/pBsVz
 10q2xL8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff,

[please note that top-posting is discouraged on this mailing list]

On Tue, 12 Jul 2016, Jeff Hostetler wrote:

> Thanks for the feedback.  I like the overall direction of your
> suggestions.  Going for a porcelain V2 feels better than piling
> onto verbose.  I think that would also give us a little more license
> to address some of the line format issues that you point out.
> Let me retool what I have along these lines and see how it looks.

Thank you for working on this. I will hold off from releasing Git for
Windows v2.9.1 until this is sorted out, as I already merged v1 into our
`master` and do not want to end up with a bogus release.

Ciao,
Dscho
