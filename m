Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF4C1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 15:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932831AbdCGPWH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 10:22:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:51757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755623AbdCGPVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 10:21:01 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWCKz-1cnie41fvF-00XOuW; Tue, 07
 Mar 2017 16:19:01 +0100
Date:   Tue, 7 Mar 2017 16:18:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
In-Reply-To: <xmqqpohy6o2a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703061803230.3767@virtualbox>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de> <xmqqpohy6o2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NVsgF0jQHbsTKQu0MP+EtEk/5UpbNRmwDAo1Z/0ONTXjaHih1jG
 uwNNcQB03wQqI2AWY8oBQ4cQKnkPLLMFS3JM1YrKEzqMOxHQnFDXWvPPGyU05LM8hp1QiSM
 OYgqqDpxox7huqUsRA3xh5XE9mmfQiTb8VzmYPogxkiOpO7OE1XLvRfh7e/LxG69amsD2tJ
 Y4xDB0XvIqaIp3tax3Zcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8ozOF/WLT60=:bmAi9BWW2LegWMQ1fQ5E2m
 ClaCqI6ACOjOlbNxcuuDWASyIOh/+qUj3yYrdmvQXhHVPSBsjazWTmu+klPbnmqvi4wkBQ3MA
 Fh4l/IiPQqlwyjUHni0fwWdHewMHC4hEAPgkfcN0DdIKjRGl2s9iSSnUOZwuPidt3Atew16sf
 IVi0rS21AnfBeS1rWQSu8AitPLjBvqgNZyxAHDYezooMFbWbAGw81SggeN0n/HwhuQMt3nDly
 73SzIUdyBdpO/5qZ9hz7Oax2RcDeJOl0GBp9CY0VWy0qXHI6ec2P+IsRZVLZ1KYc3lP/IudMd
 2uMj7XBrEjq3il5Oa/Y99u2ypaGNKO/0AhRJNI7T10dN2libL8to1pGf7jKf9O54xqPsu/WYk
 Qcy0GivdTBW0kTouzZ//qIWrBqd5jtZu41Jjpnwhz8XWKlZbIAIDLCggYQxvPU4F+EG41hLRq
 Dp0GKXzoK01OmLKcVszzm71BWxhvGf6zwhBD75OsKBHxlEUWKXmUaaCNDcgjpaBPHrUqDot7T
 ME0XRJ5LL/2WRfvwIjA17eWA94vDeD+H8sAckTKB6IVckGFJPgEAJSuutgqJQVwgNX+12aJwU
 bvvsInT77q4mlZGx2GXyZ6Pm6fdi2pJ1uQ7VEmqDNhwStHExtkp7lx+fTTEjuUjyE4P48K/Tf
 cyPFUwtqgMNyaxqAl2KkYB81IpfUzwwdy978SNlU8VrV1QB19iagoEkNG5DaDhqW3SiK/Rkgt
 fFWDj4VKT0DEdWnKNmXZiP6O+SD9cWw2EWwi51GlbynOZhJvWiNYkRRnaH/XtRYaMA/8HIbrA
 Zl9xFEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Notable notes:
> >
> > - In contrast to earlier versions, I no longer special-case init and
> >   clone. Peff pointed out that this adds technical debt, and that we can
> >   actually argue (for consistency's sake) that early config reads the
> >   current repository config (if any) even for init and clone.
> >
> > - The read_early_config() function does not cache Git directory
> >   discovery nor read values. If needed, this can be implemented later,
> >   in a separate patch series.
> >
> > - The alias handling in git.c could possibly benefit from this work, but
> >   again, this is a separate topic from the current patch series.
> 
> As Peff said in his review, I too find the result of this series a
> more pleasant read than than original.

As do I.

> 2/9 and corresponding 4/9 triggers "ERROR: trailing statements
> should be on next line" from ../linux/scripts/checkpatch.pl because
> of a line inherited from the original; I'll queue them with an
> obvious style fix to work it around.

Thank you. I'll try to pick it up for v3 (which is needed, as I found
another issue that needs to be fixed).

Ciao,
Johannes
