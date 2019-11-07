Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421741F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 21:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfKGVef (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 16:34:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:41643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKGVef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 16:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573162473;
        bh=Tym60imX/GXFIp61OO7GXJJcuz6UzSZnBZSQD5WYxlo=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=KM4dse3u/M1n/BfSsdD6SF/uSaPs9Ge0HQ1Fgc20NQj2KIpNSHEN/2qZValmoJXrx
         7TT7Pi5hZTysO9VL5N/+gU+4wwXQKMfdxc2ha1wWFRUNVTF/UBE7Pq3W/qlX8YegYp
         DYA3YmPkL9LSz3qcYjIVz2TlD9pfYVxPtu75h3UI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([77.183.98.232]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1iZR8D3BKi-006hpe for
 <git@vger.kernel.org>; Thu, 07 Nov 2019 22:34:33 +0100
To:     Git List <git@vger.kernel.org>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Subject: No Checkout / Read Only config Flag
Message-ID: <f3378b7b-c745-58db-55ed-c2c2a6818734@gmx.de>
Date:   Thu, 7 Nov 2019 22:34:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:J0FMKqabY6v6OakpnETrF3h5clEKAiWw36/DExgoTAPDM2a26m4
 AJCjBE+174kdhYomBw+j/bzAdZeuC7vJFvoVODGygGlq9sjLVEaN1y7fbt6RRmF81PgzqKz
 3rXBz+yU+Qltf57aQlxmAGegu5z+xlH+2uzlf0TDLTjpI46u6IyNC5WlbJ2sB8heqWndn/n
 vc7pdnns43lSXw2MgVEFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1EIOfZZlYZs=:F3xp19O3Mi4vs/Dguplf0f
 gQica1fgFHH72W3hytg/VJXyOvRQtxQTgzveKaDAg2jdl1/1vBvz+nJc0Xn9/VnbMW7Kctb3e
 Y4EOW3NxknDS4+Mo3GadQ2H8is5bn5u2Fuoc0ZyfnIgZUk0MUqgibkPFIW/C1H/cOQZtaGhLz
 2jKyH3kQxHlf0DVkFRobMmhvxbFyNxnYyrWg9C6qcwQ8Q0RWIO+yw5b8o4nKDlnG7wbHmVPEF
 bGEDKvdfll5EveUfdILS3vTsnQt8HgrZkNHGCo9M7CLYacD3GW2BAYHzi3pyW4KQEsgN0tpN1
 9EMzvXwhsTQJXJdDZOUSyMgB35wtdnzHW69rf67ADraBZ8o7mwkOUk5r6WiWSdC9tndo1FWYH
 kILmjJhKpl1xdE2PWleI0Aj2hrF5n81/vqEv0pDfXBWL9GtwPAz13TsOO03Vytqf7jBf8BZhY
 PAGLJiR8qd4ZNk6OK0S9rhOR+YZEa/BFLTBTc/V1jAniokUo8fNwFcwETF5MpZjMbNsvcMa31
 5M+er1Zo8nLAgdcmC9SvzE882naNxJeBTwOBV+In4gvNADZR+cqytjlahs6CaNwbHsITAMEgH
 L0HQTAvCUZpHyy1eEAX0wLQig6O9T2EwjIa3umN/ocgpG+/V+IAjBWMmZr1HhbUcjCj1YRwmG
 14DwlsAQNTRDf2dG8OeRDJHNkbawbDd/0C6UuSXcWk2LYPh2M8bwJe9JP508dksJtYtxrwPYt
 Zo4mzd+0xK4Hhx+Xchx80h1GiwOnecGnWEoXASUaXG73hSNh/bNi/UOKQ5sWGwYftDSm6Q3S+
 yUvq6Z4oFoN/2QaBSMSwoq03tY3i2O1l/9egCSnOgVe7YdYKN3dCKjmrMoPlRK55bC2qjelaF
 xtSs04ALbm9pCJE+NRZtjOaBIq0LP8AiiJT8UoeoNzz5a+18JbDGtDdMIsqF/hdWwxoERB9ot
 /LI3zF/Z5B8x4F0yIO7MUm3g0VakByI4Jw1Rx+ifuG2NIJXARIqZfBreU2csWu3b3sng76bFA
 6H8+umtKIuY9/NvOBf6QPpe3Hd4Fg8Er3LyXbM2DTEL/tnjXl4pZJ74t0UwLeJWYVmjHZsieA
 6VhvEddNN4NITYiXlxfFnRn59iJ7KfGGG8X3d3SNrheyHxQrHlzpy3rAdndHXzqqo3Q2fUF/0
 4eqcWCWsdLESp3mLUDI7+dW8q69Tx+UYtax6/jgG0u07tzIUGu3+gQkbAAeZC80AejDDJGpXN
 G5X0wtW1IFUiypHmIIs0v8A+g9XCBPKMKQtVoX1RjGUxolv/XwEvGDxs8rj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

is there a readonly / no checkout flag in the git configs?

I use Git to trace / Backup some worktrees and would like to prevent
changing them accidentally with git.

