Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E3F2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 16:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934007AbcKKQNZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 11:13:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:52819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933867AbcKKQNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 11:13:23 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSq5p-1cCYCQ2zlV-00RsP5; Fri, 11
 Nov 2016 17:13:03 +0100
Date:   Fri, 11 Nov 2016 17:13:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
In-Reply-To: <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611111711210.3746@virtualbox>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gvYQjMfRXwGOUV4OUO1nsucJKbcZYVBWKkcKPYyLCn7yIiEIPs2
 h4Fo0LswSZLCcS+bRlSz1bG/NuT0C2mB5ueyh1fX9fgwrYHf+N7GSzu5Lq2bz5ZrlDxnonL
 grjsq9OkTxZ7rosMUAOi9r4FmK70kXzAIXYQxU4y4UldXALGmhR1bcmsBN0Qt4MiKH0E0vQ
 M+Bv3p6NZoQAD0XR9Na1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KZBmTpWhhSQ=:blEkVhFYMtm018I1ATruBl
 6ue778AgDlal2ZMWxNUNLZ3NzvxZ+9aYQ824POkmznvd0LBE1l9tRuQv5SsZkVVGL3LKlaM4q
 cFfamDaPexqiygi5Y3GJzPRM+jsRonrfAxON2SbvP9B95WmErI4S2wKST5UgihUP2A7/iz1KX
 22bo+TY2/gLx1oSMXcoT49LxmEeCYT3WO2SR/Pj1HKREPSyJd1nt5kzBGjZNac8CZ0e91+7Hy
 EtTQtwJ/wFq/nusAU6KpOXsn8d1SGhgA5YpvBQHQ+5dZtAHOp8XOnGYGEMaloMbzRMkDcpczf
 8OVXKGSuoZf2b+VAhBxr8qWPA4MXMIY0+xX+aYkIlJ2mq6HPrDMGUDo11heeUrcxQHPdDr1gm
 OQadMb1ND6KCEQ6HaXNc2l7C/i1VP2IYk6UG8QDfre4JY+LfQuMlrGYFGqK7OVuyOLA8fxSqr
 SkdA8ouLbN9Zj69QJOyx/gxzXjCb7mNFfP/m3pN1MYpfZt+vY9M+akeNC78Nh3hLtqlD2WSIA
 tuA3cwwTKo2gz2GDG1rS3q0a9QAfnCpa25Pmb6zI9ZLZQZATJghUIRXnRaHFDlKkVi9ZRB4yA
 cxlKJapNav/4JNh7Ju8f7AC7sYUcSkwySOWuYrHaeG646oDYeXinr/PHQvPLAAGB/DySB3kd+
 GrUkcuuD5YszTn5BAMym6L4au8k2ud4TwquSDV1KN6yrNVwPOK43vUdx3zO676ddHGj+uTVLg
 RXDZ08j4isIoH80lBaOYZgoao4CBij5OLRvellPBtCfTdrvIYfwsqcr0OCWBxxmMyFz5SZgV1
 LEv7s9K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 10 Nov 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I'll report back an updated schedule when able.
> 
> I pushed some updates out on 'master' today.

Which means that t0021 is now broken also on `master` when running in Git
for Windows' SDK.

To add insult to injury, t5615 is now broken, too. I do not recall it
being broken in any of my CI builds in any of the integration branches
before.

Ciao,
Dscho
