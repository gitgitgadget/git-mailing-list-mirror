Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB021F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfARNms (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:42:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:58853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfARNms (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:42:48 -0500
Received: from [194.114.62.122] ([194.114.62.122]) by web-mail.gmx.net
 (3c-app-gmx-bs22.server.lan [172.19.170.74]) (via HTTP); Fri, 18 Jan 2019
 14:42:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-95604a8d-44ff-44a9-916c-5acbd3ec8cfb-1547818966751@3c-app-gmx-bs22>
From:   "Steve Keller" <keller.steve@gmx.de>
To:     git@vger.kernel.org
Subject: Why does git cvsimport create a branch named origin?
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Jan 2019 14:42:46 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:GRE5JcyKVZhKXTtE42u31qBR8LO9+mcqRl9gh5zXf1p32OTqBm7xEZGzVAROEiEbt15TT
 6TqvV/QyLD88cfZ4Velf8I5FO24LWP/bCLUol40/cWSyPx7Zgh9rMwjp3c4GuhaVL/QKG6S2xzjm
 AoXz4ras8fyKQsHb3JkrUlhFsGk7Ad9ol74056nZQO+lErdq8I3RcW6pFf5c0MbGqey5fuYOAXgZ
 L05PMxqu70FEcQGXaI5Ru0opMHiPyGh2O0GtaFYKdmYGazFir5SMIx2eD3Idyuo3P9qEqFq+KCNa
 8Q=
X-UI-Out-Filterresults: notjunk:1;V03:K0:t30qo2yhUI4=:/NFnP0TNXWzbTuc1UXVKAA
 EITSwPQYVy0bpfDHlFq/OXTnqTK6LuIOcEYKQJMy7IDXqYguVfyKt+Kj4beI5LCjb39tWYOHJ
 FMHtimapAcHjK1HTg0kjLKC2U1V1Sb0GOOq+2pGlfjq7bnt67pJ3wJ6pIqaKAUS7nGcSDs15B
 TqiSN7V0Kw9pZuFG89ZsEHckOvX1bikF5kalBAs210rf3+hCDooZ7JopaQMZxOblhhMk2wUwV
 J7bm5JxDhcmfLOWvWZYhR0LtWfcBZ9bXSv9NoVvV84xkNdhANx3HGVUei3RLktVoEOHPRNXSP
 gQgctyuVKuYIaDNlnyxFWvjU2iDjJE++gRwrMuWwcA5URRyf+8reGqJ/vopGJd4c7SJWOgZOL
 1//FGw4keZJOYTx/wA79jqDeeSHk6jq9kVCkR6C+ZiELgd4vvLrDOKZb43N89Yi9r2sFrIldE
 RzmVhu5xwbfZ/qU2WU8U2Zah9PrASqjk9IbiFed0gkrkVQHiEGMLtgj+4Q0cOvqpfKk6zAa6p
 yoBuZgj0qCgxbE1RgILv1nTCJNoCfuER1t31/KOoDOQKJimXzRIvW8c1cTxEYtil15HH7iIKR
 3XDq9BWUevGMg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After converting my CVS repositories from CVS to git using

    git cvsimport -a -m -A authors repo

I see that two branches, master and origin are created:

    $ cd repo
    $ git branch
    * master
      origin

What is the branch origin for?  Should I delete it?

Steve
