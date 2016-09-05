Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E42D1F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 07:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbcIEHoj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 03:44:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:65526 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbcIEHoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 03:44:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Ld3t6-1bGWJn3xaK-00i9Zb; Mon, 05 Sep 2016 09:44:28
 +0200
Date:   Mon, 5 Sep 2016 09:44:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jan Keromnes <janx@linux.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ingo_Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 1/4] add: document the chmod option
In-Reply-To: <20160904113954.21697-2-t.gummerer@gmail.com>
Message-ID: <alpine.DEB.2.20.1609050944070.129229@virtualbox>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com> <20160904113954.21697-1-t.gummerer@gmail.com> <20160904113954.21697-2-t.gummerer@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QjWK5IC3YfyGz+Kd2MGKegmu7faPyFYOm7grag9O+X4vbpzDvtl
 5OFCANphCyWiJ7NAAVka+j2yXp7l5+QmbTI2we6ZVkyWWGMT2XOdsB44I6PNeUqyAzJCCZW
 GqaTptNBSui9duYIpCDL+h/IHPsj69xG41qeszngadlCHioYqAeQurOTpE9GU1DufoiidOA
 e60EJwZcN1tH6uRnXxBAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OwrhwE0iQVc=:sxaz9apWaL2Z4KeBj5nSe6
 GjjDUkEaXODsoULpv8sqCGPyNPPEEp+GISVRKyvxCQE6qI95/4a2uKjd6JN7MSDbHu4mCnsNE
 XoKXVrm4grW+Yvo2nbXKAxEtQT6xLIkKS9v23Q9t8OQc31yHzMHNXYNFt408oQ93Ya5Q4ItDf
 7X5qWHrxM5fCkSWpWt0Vh239YY5nclIz+Zc43UE/6O+3zojsWuX+72MkoHbC3FK8a2GKJ0pL6
 WF8JmkNOOLMIZ4KcI2tM9501e1YAeNJ4sHjV118Ds8XT67G+mYKqbqwKhvgRbNA5EMBXgz9iT
 k/C5ITv3xBIfLGF9CLRnKPuR85EZNUhJg1/K4rm2grT+f0DcEO4GJM2QtS0B1Abefi2p4uupO
 3v8h5i+narf8tElLCWnr/6oSvP89p+z9xgflCK1SdpmBB+PvzuWo2HEHs1bzvdYksbS/X2PLW
 wY6xnqpHgwF+jfdF0RKusB5DaVVGs55kyt2C2jBK+59E/146Nix7bkvIUQ7O5lsvK+iVdmcj3
 NrnVUuwtnwvBlwj7Rg5oWXrxYFUUf5fmaT58XVD90sa6N0KiWiP2vZIdhrh3X+6eIT/WNEJrd
 neD49OKSdQJtxjudPQynFVLf8KyLSbYy8+GCrYbn7iSA1Ebamler8uIGons3tAFOPKximBIl1
 JQWECOFWRrF4P3MUANoOnmThwIOLwHwkJwhTB7V0aUqI4inGxX1wNeFSDYn/KBi+FZ4BT0+KY
 t9HeRH3NYymCqNcVi+v1olxmzH0u+r7vwQaOTLzDlA7a/plMrxaA/7RSNETQ56ZwBrEEiN3KV
 KJ6HFA+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 4 Sep 2016, Thomas Gummerer wrote:

> +--chmod=(+|-)::

There is an "x" missing ;-)

Ciao,
Dscho
