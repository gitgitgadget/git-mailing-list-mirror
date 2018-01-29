Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5D21FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeA2Wxn (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:53:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:51704 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbeA2Wxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:53:42 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LikE1-1fBmZh2C1l-00cw4e; Mon, 29 Jan 2018 23:53:36 +0100
Date:   Mon, 29 Jan 2018 23:53:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] rebase -i: offer to recreate merge commits
In-Reply-To: <xmqqwp08fhea.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292352290.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <xmqqwp08fhea.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o0cW/pTlrza+fqka2lQVKcpIOTR3cktej5r0Jb7jU31LwKb5TRi
 P6b7Mnj9Em4oDLKo3no2ayIHHQCIbgGZYZyV0fAmnZedWgQWiDmir5dexV7Ee7lMQxp/Dm0
 GQmyqi0+y/CzA76ae9pMvYDBQ0qiH5DpgO/Gfz/BxX3DlOCUpQOJwoGGbqpiO7nOiDWtWLr
 GRqo4A7NbwOgLPz6q4eAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y0x/ZbgZdkE=:vSJkPVDXssZF5ceHLyWvoi
 DSMXbgKJKzuTGYT48g/CmtjGuS8OXCUKY/vrsl0msWW6RQLVdADHcUdLE2UtcgsvzxKtNJEAT
 u87JrFnuU/voTH6OvuQYOE1tb63+MIiBUxt5m/yLoQFRCnCtS57vShKxZBCaEZJweW6ehmE1Z
 hRGD9aO1H4HIibCfAO2niuymMEEDSpPwOMb4VE68P/Ezn961gFCBIi+/ePxvjYV5nCnmIwHTC
 zBXYYnR8y5EQQVdyn90Vq6mnGRje7OLgaiV+VV6w73b54N0ntFylZtHuJd8gKWWlsC/XNb5v5
 vYLF5BHQiFtIcnUVHzaqD6NJ3955sU9NZlH9gcBdblxE0Z732d6LXaYyJ3naeWmy3tu5hsK5Z
 hKT0u0W5rIthgqyJMZfurRGtocgNNsozjl9m6Ac/M7Zxi585/VFVB5AuR7hFyCBAJPPoLATkF
 mkwf+szC/s9quje19LrSbVRB4c4vNR8f/Ny5w8D2gBZZRvdBZ/oC+vP5SO3lSHUg6nEB0sJ5z
 0LHeAqAVTdeLOltv+KldTQb5f4H3dNOwRELb9FZn/C+0UpXPNaIp+66k67Tww+FTAUd3hMbHU
 VfLsHVMh+YFsMjiWzGtDndIOMqQeXHynzKhJHtjOHLHYIX9UbjocNVl/y15fhh9c+VpjFiLiS
 mnkwAFKKHYaaGQgjysNvF4UPZ5+85s4+3stUjJgmBdblOapnHoju/HCkTtWyNV8vBA4r5kun8
 VbxgrUsh+R/bxjCkIPwC1tJWTGTLH8WJUv7pL7WnKmo1QAeJYtWlgOEJW5CL4dfQkrLb5MH5N
 S8d7xY/aq9H1RFw2WIYiTW+MNR4NUtOe69J0t2Ef1Tf2AKsZflUYkpJ5KWwU0brTMMts3My
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > My original attempt was --preserve-merges, but that design was so
> > limited that I did not even enable it in interactive mode.
> > ...
> > There are more patches in the pipeline, based on this patch series, but
> > left for later in the interest of reviewable patch series: one mini
> > series to use the sequencer even for `git rebase -i --root`, and another
> > one to add support for octopus merges to --recreate-merges.
> 
> I left comments on a handful of them, but I do not think any of them
> spotted a grave design issue to be a show stopper.  Overall, the
> series was quite a pleasant read, even with those minor nits and
> rooms for improvements.

I objected to a couple obviously problematic suggestions, and I
implemented all others (even those to which I did not respond
specifically).

Ciao,
Dscho
