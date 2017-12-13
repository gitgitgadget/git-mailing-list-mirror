Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9511F407
	for <e@80x24.org>; Wed, 13 Dec 2017 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbdLMQkG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 11:40:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:55060 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdLMQkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 11:40:06 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKHMk-1eQny93URS-001eSc; Wed, 13
 Dec 2017 17:40:03 +0100
Date:   Wed, 13 Dec 2017 17:39:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Simon Doodkin <helpmepro1@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: feature-request: git "cp" like there is git mv.
In-Reply-To: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712131739080.23267@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AO42Cfga1k76Bq4f4TYVm6ZTevmjF1lr4WJm6TFY70cT0boCwzD
 77UNBjzW494Y7DCGztt88VOj3picHD9Z2AkotPL/7fV6utLwCSpP3rfpzNx98kz2HppW+gU
 UraHmm9THNM4PaxzqYt02KRDzXRbib7sleU7WFLcRA9TREoyWXxi8RX/CjJim90LiBJku+3
 +ZshVpLVXld02U9QCAehg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ng9AlYwxYsg=:6+sT8yomvOmFmy6cT9850f
 gfeLtdWBw2ibXD7vqM9nvi+Nd727xcY3ayq9+k6osJAYNJj9/f6sEDMMIZ14QbjPun0F9UqyN
 c2mSu138ACgowrgpAk0b/Ns8kIvV1BTWmy2jWGJhOhHWczU88WjJsaWFVC8lPexnDLlv2NgC8
 j4YZBzdNNrzu12iqpVIp3II2fCq3IjjS6UAdsHGqCI/3Q8Umb9o5LRlWtkSmVkQgq1MDARbrx
 N0OrWQzpWJMCqlwz0Fdgd/6/4D1xzkIPL9qLZycpNlr6nP0ihgjiegqtFCV1fEv5KKbRgnjDI
 kA09caqJwiuFrhDy9O1k7bxmcTcO53x6bLSsO75ZcNnofLv3QDSEAXyKuHeP3qEs4gmJzJWsr
 Htc9cuqV/M3uiQRMfWXChPjonbacHe6Ivryx+mhGZtl1bGEAm6ep3IoGI4k+XVQQLC32Kl03c
 GdUr72iwxjYRjlzlfFQihvgUlJSp9wbomfREqJvBQRRSXScOQiC4SY5cyMzPVF8aqhprCiL94
 b+ewtFJaiWkOsEK76PS3okkEvB2FHY2YdVQ+dFULARTI4Dh0wU+/qpuYItyNsho0h34OtYe9+
 tS20AYi2B+h73p9U94+P8/D2PhyBN/MDXvWSIqSdWQyc0ehdo53uRDNIaDAfylQNZKeijCayw
 Sr2tOhJUhp6BsvlgHXVqSc31i+0/Mosx8Mjj4A+mgZv4wcnHcpH+9FyqirKNkL22UEdplYsk+
 QQc5FZzWPffOfnkJq+5WqfqZz3DRvTjaKAdzmOKBzN0K8GcwbuR3s8w31CtD/m7ovN8SvZcVZ
 7AMDjp6nhvWzlZnqwlXhHphYZcRpAaXdatwp7QkrsZg36bFIXed3OqUCucp3ti+ndn3jIeL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon,

On Tue, 12 Dec 2017, Simon Doodkin wrote:

> please develop a new feature, git "cp" like there is git mv tomovefile1
> tofile2 (to save space).
> 
> there is a solution in https://stackoverflow.com/a/44036771/466363
> however, it is not single easy command.

This is not how this project works. The idea is that it is Open Source, so
that you can develop this feature yourself, and contribute a patch.

Ciao,
Johannes
