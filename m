Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7041F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966359AbcIYORp (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:17:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:65295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938708AbcIYORo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:17:44 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mh5h7-1babZH3avB-00MH6p; Sun, 25 Sep 2016 16:17:35
 +0200
Date:   Sun, 25 Sep 2016 16:17:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: Journal of Failed Git Experiments, Volume 1
In-Reply-To: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609251614040.129229@virtualbox>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o7oNKV889bxPUgg+3HmZVfwpmWY9pt9nm8pPk8xtKykMu9wNX1i
 I6nfXGMTF2ODwtFbod1cZGCB4d0eysyKtMCz3jJc6F8TbTan5V1BwYu5QwUmRPa6fLiSoJp
 HRSTdcTc3qBp3ffMOBSvK/rO3RGCSqO1r/Djsj09R0ogJqI3A/gzfQqmYLqEsEbA0kFN3al
 16mtCm8T49WnaRTMKCKHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VYnWom9Yjjk=:euhdtCzr/sJKBiEc+fty2V
 53Ihukre/x+vG4q2fs6VsmwK30lSDWL6PKx/b2ljmAzfQE8qOzDA/NtBoFj82ZZio9b4O4Tmt
 cdgjuDFxBpiDiyM7p0ZUrgljYbJY6QHW3bDt8YdW0gHskWTdjogD0jNGhPGKU3OVReZRvK9Un
 Qv8OANxM/clIr5BUAaL0lW6xYJiDT/xgAZopuYjiBKjwVmb6LS42ENSRtUdbR9rpEK/xUkgKp
 wmSN1lntTtYZS4wHb8Ifx4hVjbQodzfe23v5peMvmoqTGEZnaHb2TVjUq8fGHu7BSA+rU8xAv
 prhniD3IfrwKqODPMtR68hfWEFBc6cISfhmCNFdzKrix5QGyvEro9ySnS7WxrlYXmM9FkzYNn
 Wqhx2Y5d7Q5H/yy6UZnb243oad5/I6KiheclNI97ZD90Yo587Yh1dAySR1Nqv2VvO8dZ9TjWE
 CyyIZu5J1dV4wuHqp8wJWfEuqRDhYM3xdv4QppVDkPniX4Vu6YAPnH5C8TFNBKjFzVzvWGo8j
 Meff1GYDT2cEftw+QxglYTw7c3Py1kIKYpJhhnaANuLQ3EevOKF9etXS2mGE2ZOxLaXIUvuuj
 PumQ3hzEwftXN4cKqga9QYL2/FJSU1AJ6QojyGHUmF8Ga/VONoaoqDSiqVjXgyvmf18eKXyk2
 3uAHOMKYr5GvnRthFUAsZkIs02gb7unx5MhkairSQX9VBZwoyOGNGKiwZAArFMGayCC5Xjha4
 zFjRT5/zqr7uC4xx4HbGUWELr5TDSzDWUJcSyT09obOLm5I8C9xdwpxJg2BiZdlR76YNXF8ha
 EE91OxS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 14 Sep 2016, Jeff King wrote:

> I try a lot of different experiments with git performance, some of them
> more hare-brained than others. The ones that succeed end up as real
> patches. But I hate for the ones that fail to die a quiet death. Then
> nobody learns what _doesn't_ work, and nobody has the opportunity to
> point out the spot where I made a stupid mistake that invalidates the
> whole result.

To show those experiments, with analysis, is a really good idea.

I found the zstd experiment in particular very educating, as I wondered
about the same: could we maybe use it to accelerate Git operations? Now I
know.

Ciao,
Dscho
