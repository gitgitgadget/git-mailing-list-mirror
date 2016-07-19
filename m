Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C334C1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 14:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbcGSOfb (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 10:35:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:53258 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcGSOf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 10:35:29 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNZ9u-1bR8gG2fdK-007AEh; Tue, 19 Jul 2016 16:35:26
 +0200
Date:	Tue, 19 Jul 2016 16:35:26 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Richard Soderberg <rsoderberg@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global
 grep.patternType
In-Reply-To: <CAEvc1UT_gmkmOjhs8PMH+vBRE1gku5yYRPhPfOL_B_vyeh23_g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607191634350.3472@virtualbox>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com> <alpine.DEB.2.20.1607191323010.3472@virtualbox> <CAEvc1UT_gmkmOjhs8PMH+vBRE1gku5yYRPhPfOL_B_vyeh23_g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e0SHFvMVcqrd3PO5qJHRL+73YnClblenptqcV5ree5d0TVbYaTV
 FGhxiQXD45XXE+8VTFu707eZzRcEtc0t+XxgAYGWI7AyOpr4Ohup88hW3lx9thb0I67X10+
 Nrtz0Nn7IIVFCBSMToH5qNH7bs8eSoYvE+sZTbDNvZF50gh0xhn4+lVqJIPX92mBmcx+0Xk
 NP4wxFn4uS2oTJb5GxpEA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:IiXCOKwKdMg=:d/EXcCUTpXf98+drTAg7He
 ctfoFO4qTbP8YI1QlZtNvtSuwZLie5q81t0bNKqQk0cLgTHa4Or8J786wbZsfj0iCoodmZMNU
 ApbHHG8PtJYWSlg28fO4NgBKuWUv1tTptYv3iLV5kkkLG9EviFbdFO+PMS5T+i6IwlpAgLqZ/
 DPfVccI9m5uyQOsXvyB0t9R2mS6HoToathHqn4ZnlED3ylVh5kty0CMIjMjk7HskMNvLU/L1E
 JhypmSQpZsGQITEGK5qAm9fBHva/J9e+maYCz8qgWlVXf5ntXPzvbsjjdGMEJCH9SJP6ZMTYp
 WcifAKdvcr8hdBAYOP9V2G5Wu8ku0vmaJqLm5R4iT6yIMSt8KH79Kzs1Ir7wlH+3jsTOiWxEK
 SnoJmq+lRMTyFwl9783Gfi+xv2Wz3lRZ3X04NCjFZWwGyms/SSfMOXdkwt6DGqFpn1j8+dNQJ
 ORP+g3YLrMjaRv167foPnd94FP5lKjHk1ksvo7xR40tqUc7om5MxBlq+VHHkZ4jqW1DzbiPo7
 WSWrNKPtgpdYElImR7WikjBMRa9XeNHYrk+hGNKF7x6cjQbu7SNwTT5KaSF8ekQJteNF83jpU
 aYXRsMbt00Xp5XkiEN9M3fsx341n9AUcZRziGTU0AHz4e8Ow/S4GP/rFQC1EY199d31z0Idl8
 SV53yeZ1y15Wq7/4kWucwNLf2qwV8phg6yK/THQ/jN3xyyY07axHKqZpSkqEf31fgglcQ49KE
 qhFSU5z8Ri5H3tr/2hcq06qgen9HRVIHN53qnvLPJ3yaYYjrOKHBJcbBf4SPzKe1Qz+MztPN9
 pDHm1TE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Richard,

On Tue, 19 Jul 2016, Richard Soderberg wrote:

> Aha! Yes, this works precisely as intended: the prompt works
> correctly, and quickly, with this change in place.

Okay, next step for you: read
http://github.com/git-for-windows/git/blob/master/Documentation/SubmittingPatches
and submit this patch with an informative commit message.

Ciao,
Johannes
