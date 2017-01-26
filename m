Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592601F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbdAZOp5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:45:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:63249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbdAZOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:45:56 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrrRi-1cMXx62DJm-013gdn; Thu, 26
 Jan 2017 15:45:30 +0100
Date:   Thu, 26 Jan 2017 15:45:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <xmqqefzq936b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701261535100.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com> <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701090825510.3469@virtualbox>
 <xmqqh958y44c.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701091207480.3469@virtualbox> <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701251327090.3469@virtualbox> <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
 <xmqqefzq936b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wA9I7JrDYpdVhkKjgYH2aI26qHsRtcvVNBufbwjmaXCeC3l33Yl
 2K9mfXpta6qiNysWRfhllPZzUGUEz7fNYHFu0A0n0MtpKCHzqLzoXuw6FmHoaFAbGprPOYs
 qp+dT8kDXhxVA0BihyOTAF57z45dU+rYefp11VPiYstNBde1dMDZIhnY2Btbrxf6NKbSAf6
 AfRDgq33s8l5xm+r40C7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LLfaveXjpho=:pm92YbxQYuabn7xvAFM4gC
 d+OxO2J+27jfF3qBpcy8GanXvf0UysuuUFRwDW2fksKQmNs36rjTy9oAY2kcYBC6pnJRuJNwp
 Elpxa21hKMJat0TVDSEksdp/d2v4OjDvcAsAWGxbcCTyy8JEQdAZbB6iR719fcu4d2rBvIC+B
 +a3NcNn3rMEcnqn2yOVr82hEmiGCXTnWLeJSW05IE7onMAA2MCD8hZGbKFPM8n5b6dk8DkOvB
 Ko1mK2VDE3fRxJc+WSxw1UtALbiMU5lrG7W+13tpGrQCDfNkstXtzEJGk7ok48xBpSJ14qyM+
 Cros9G2eiST+HfTqpdOVJZlNoPHFL6pIFcb05sf8NYzBiDSj4geyy/Su3DwgkkCxJdeqWs/pC
 SyRKWpMn8ZHSoE6TP374k5snwXzcJYd4OLt+EYw+V8Ct64QorvmzYjGKq5RQVA4u5mrh/AAnQ
 8JMfenUzet/EPxffD/LXXAixi8hc9JEh0fDFj2KMu3zBrNIZMehy14/yVCXPS7Twjtr+CX8GY
 3MEMyxCET02YZeyVopgn4X+gieU8k4jJmbudObnojOjgjtLmGJWtqHQn1gZUb//tHEto7JuyD
 lDocx/EdqnkdyNmzrf9Wmhkhr6YoS/R8fIEBqyZCOrGI/ry9AstRRoV69Sxpv8Z06cQfnWSrY
 TyQIuxzQ6rwLOH9XcCCmbupzz8s5K52hfWPkfgdZLl07dYIJZ+JiVP4a1zS9aixIa1O8x9fk8
 Bot31UK17AczHptFfV4mbedpmo8nLAKqwzZv3yt7Y60lDMT7qdZBti+5JzkA/GHq+oi/mU04V
 LPPNcMAqJOh9Q1hkJtgl+Kua3iFSDExVboGNdtsWFPetPUDfartnRncNGYOGCTUVZXn06OuMG
 w9ugfiqBrVLx3CoF1V7Y9JIM/XdVdwbJVxxGN4UOQ9neNxW4dkTxDWPCzPC3Y+PSlQMucxca7
 Og6U22PC6zHA93f+dqJuFC06+hbKtgkPY71/nH5A0COW7IRLz9H3W+PzjdmSAcokdO9nNdkFL
 +sN8uEBbSJwv02BOwtbuKb0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 25 Jan 2017, Junio C Hamano wrote:

> Subject: [PATCH] connect: rename tortoiseplink and putty variables
> 
> One of these two may have originally been named after "what exact
> SSH implementation do we have" so that we can tweak the command line
> options, but these days "putty=1" no longer means "We are using the
> plink SSH implementation that comes with PuTTY".  It is set when we
> guess that either PuTTY plink or Tortoiseplink is in use.
> 
> Rename them after what effect is desired.  The current "putty"
> option is about using "-P <port>" when OpenSSH would use "-p <port>",
> so rename it to port_option whose value is either 'p' or 'P".  The
> other one is about passing an extra command line option "-batch",
> so rename it needs_batch.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Apart from an overly-long line, this patch looks good. It made my life a
little harder, as I had to rebase Segev's ssh.variant (why this should be
a core.* variable is not clear to me) patch and it caused conflicts. I
resolved those conflicts and made both patches part of this patch series.

Will contribute v2 as soon as the test suite passes,
Johannes
