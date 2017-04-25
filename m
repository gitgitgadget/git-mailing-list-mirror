Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A768207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954987AbdDYV4m (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:56:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:61321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954980AbdDYV4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:56:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mg3h3-1cfhuC295B-00NQ48; Tue, 25
 Apr 2017 23:56:37 +0200
Date:   Tue, 25 Apr 2017 23:56:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, computersforpeace@gmail.com
Subject: Re: [PATCH] sequencer: require trailing NL in footers
In-Reply-To: <20170425190651.8910-1-jonathantanmy@google.com>
Message-ID: <alpine.DEB.2.20.1704252355440.3480@virtualbox>
References: <20170421220155.GA142345@google.com> <20170425190651.8910-1-jonathantanmy@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LjvAwa6A/bg32JkKSHlC7QrIxEilRLejYVvHOm4kVetOGNZ66yB
 2Xqw6rvjlIe3QPqPB+DiANg+EWaxI7qGHnDhgA4pfNtD4a0E5mqQRkoif0R8d8cpDOrLTA5
 vaRR9JoeGl4IBS2ndxq7S9/wiJ/Sa3yNcwgIS2xZxlN4rwcZVS9/yYuFcFX2EyicdhMX80Z
 ZQiUZGYu11jO4ovi5CJBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rCmnioon8do=:ghbNHSq27V+tQVbeYiIpNr
 1ctuAeIiSMeBEKH+6NboOiYKx7dxPIr8h6k3ooql4X0J2iAhe6bowgy9JyWPG/L/bw/pXVgWF
 JcSSKCXmreJwO/Qj9m4j/cSYYaJf/+L+SjHA3DBR1skZ5bXFXYTzuCZrC7tL20zDQqp6jmxuq
 8y4EoiTGe30c6TSTzTSNoLOAM0xIB52iQhDdw9qLrH3GoxnOfORWHfvOJ61fpPR3V3RNzZPK0
 IKi4Xj94tueSmh3O+hge4VwXz+zn9OnGFUbb/BVw6wh4JhXLkZgAfbL6GHD42LBQdJazstPOL
 6A9ZTXo7RgHQHqbjjA9IGro7oBkpjO+mAI4lfosCamFMMiG9gP5PUKa5mLZ6MVaIxhMdZHJC6
 7MIDsMewIJvqiMAW6d2b8ad0rFYqppOj6tdj/YtIvSaPsxe4eFcvuCiYaKMxqJGHAmPsbxHAp
 L0muurVnbXcCbOCJKNGVPPvmO1ucpQ8Bv71rLAfY1pRc1Vgbg/FrZT1tEC0qBkhlbarQ0S3H2
 17HRNs5sTHIStriuq713/hxj9fcsxasCK+ZBie+QLWDYeFG/6R/lSn8LAB0i5cmYrgzXecJi/
 fj7DJUA9qJkcnciqkvVY/tLofF7IV0lPx70FdS6Lj/5EO8/6ewHY7QHCQwnGB213C/Nq4K6t1
 3DAUUMe/TN+eIPGHdsWb7zP75hrwumVXvftT3LtQdhwv7gL/esYTgcfprZQjeZFVud2VWbHAz
 YEk8zXs5YI1WZmxY7O3Av88Yx/8O5PJ3GkVpogAgcQFPQRPUgv/vN/29ceEzdYZwpWOdmGbo/
 PtIfjkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 25 Apr 2017, Jonathan Tan wrote:

> Thanks for the bug report. Here's a fix - I've verified this with the
> way to reproduce provided in the original e-mail, and it seems to work
> now.

If there is a straight-forward way to convert the manual test into an
automated one, it would be good to make it part of the patch so that we
can stave off future regressions of the fix.

Ciao,
Dscho
