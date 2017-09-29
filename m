Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8461C20281
	for <e@80x24.org>; Fri, 29 Sep 2017 21:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdI2VoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 17:44:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:63808 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752255AbdI2VoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 17:44:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1dVXt80FIH-00kiRm; Fri, 29
 Sep 2017 23:43:59 +0200
Date:   Fri, 29 Sep 2017 23:43:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
In-Reply-To: <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1709292341280.40514@virtualbox>
References: <20170927221910.164552-1-jonathantanmy@google.com> <20170928004137.GD68699@google.com> <20170928104616.be61b394b50dc5193be275be@google.com> <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:emDNB2ejqUiMO8NdHv6ezEH6VkjfXfifT+M1CDEUhjPUf9MrftQ
 yGQRKaXGaBTP+1u31M20i6F2r2aunhoMxhXt1gsQiCWl075udI/7vU5OcfC/ByNpE8FYhBg
 ndqxRljYuBnSI++fAs/TIy7hjZsVkIvGgAHP8rJk3g4bBmwcuDaSe8Jq/PojiiE1FU4sw6p
 YeqzEAQXvgAmnLq1IljDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3SqZBAmv5fc=:hndy5bdtIN5WzG4u84ZbMU
 h0cB0xAs6XEqVzScPXZ/C2vpFUBH1fRIyTQvLl7U5UOivFyeshTtz0P1FuZ4POg5Zf0VkgSmN
 hs9TxqeqivnLMiwcXVAG01Umk21J80eRELwpGHWRx1MbeGB64Gox5sLBkSxkSCk5QI6RamvEn
 tFqQrrLADVOV0aklwBQji2lgwyLXHDgg5/cJ75sEWkPIemP9AElIYhBZ65tGwIMnARLe+K+xk
 a1bKEVOcWjOdSe6OYseDBqZGZmY7MFVzwb9ZTUckatbnBl87aLdu0R3qv33CWilVRmwzkqVZl
 sqK3/JNgebX6cxG5A9Er/G9Ij8R08CloNUhWqUOLz9Q+rdoYaaPAQeoqKNxD5CTX/ZqLIKWmM
 3yeB1hrszNm8naODlNNhe31FRjAuoRB1vBuu7Jwvib6kcNyjKgBYH3vaOOavJuMA8oD7F8MU7
 Mo32c+FGs5rrKHza9ydqdPwj9URMDsHLa2/p3l/20MN4CDWhWzDZIYzn1END6wGSRfIDtSokK
 nvSARn5kUaQKhs/7YX7lzmA6spiyCZEvqncMuOdr5bVZ5E4l2QoprE6T9+xON6JAZXgmO9V1L
 3etEkn5Nlg5GQlpf/vppMV6vawPAXbBz0rHcFTqcgQ5hWvSHkEdMb8IpsCnSbwKkkGyu9Fky/
 EmLf1WSLjks5dL1zKTwSzkAckelLAaxRK0/V2OXwRWmf9smAMnKF03Ob9uAx03SYewRzcOQ53
 EcYUGBbHRWs59IpaDdYLlNAPodFPpvVXQx7I2pbbTJq5BPQ5ijIf+BMetXjzTx/m5FcbC9iMS
 RsR3HMXZi+naCsayLu7Cl3jerbyMo2M25M1t2RKlt1fnqeFvBc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 28 Sep 2017, Jeff King wrote:

> If you're planning on using an oidset to mark every object in a
> 100-million-object monorepo, we'd probably care more. But I'd venture to
> say that any scheme which involves generating that hash table on the fly
> is doing it wrong. At at that scale we'd want to look at compact
> mmap-able on-disk representations.

Or maybe you would look at a *not-so-compact* mmap()able on-disk
representation, to allow for painless updates.

You really will want to avoid having to write out large files just because
a small part of them changed. We learn that lesson the hard way, from
having to write 350MB worth of .git/index for every single, painful `git
add` operation.

Ciao,
Dscho
