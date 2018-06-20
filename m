Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C32C1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 06:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeFTGNY (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 02:13:24 -0400
Received: from mout.web.de ([217.72.192.78]:54545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeFTGNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 02:13:23 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfKp-1gFkNz393r-017EoB; Wed, 20
 Jun 2018 08:13:08 +0200
Date:   Wed, 20 Jun 2018 08:13:06 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
Subject: Re: t5562: gzip -k is not portable
Message-ID: <20180620061306.GA7813@tor.lan>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
 <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
 <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
 <20180619205310.GA30710@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619205310.GA30710@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:x/NTXa2wsfVLpZwWNb5tfqKT3zfTnikGiAcCzJ0/Gjybj2BUSXb
 fs1IlQpBqQPT6ir4s79eOlXYrRmWAfsLj8Cwp7ID0EfdUng4fXoo+XrwhXh6Crw4up3jp4z
 uFF6VXdhS/Low0pDRtlBvAoMu1L4GYxte9NhEFdMXeMpv4uMAMV4JmHexOr/X5sFM+KOQGH
 jo6ZJsU7yvSJDNad+65vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fmZp6+V3yEE=:58kfLo6J1CJm8Jpw9yqSI8
 O8hEJ7luuNYI76YtSFT1CYucF0XYKyR+pUfkia5DDNSamU5qQoMgFWpSaDaSbiT9GNIbI8q0m
 52Cisk5dcuZ7hIjR6iqQ0g7dtgNBgNPH+5myYCLevlFffZmvXkTu4oJVhgT9s2/6z4Os9Mokn
 yE93csoC9x0QbO9ev8fyoNNr3+LI5GFyncJKScY+D7v+9e4DMv6it1g7ly73Mb09HPhB3BBmE
 0gQJ+Nkhx1bOn9Cw6AK/iOYLap/PSOwCzbPxzp4qOdrDz95jVBU4vD0rZ7Q+tTK8RezsWl2GW
 Du0BnEk5ZA95cWzgNiRt+ZecsQLRmhM9Yy8jSzfrvB5N8JP87lUrPyZaWxxLt0pRmHe3KHcrw
 bc6BBF+M7+501bBk7jK9Pw6bqrqTC16Ormu8FBdj14Q8UOxwdSVVzyLyEx/M5l9qAYKD2ejCc
 9YI8xtSk5UvIIw7GCnRqsAb1azqzBg1gaotedalEsYgzhwgrUitzTf2KxNnYOIqOaH2KGUZ4S
 3g7h0MAXf4ZShjft0VPq3qEiOiAR9ofzaQyrA9mh3kQOXS70ob/Tb5jDLowxTGmhzOJp3Bp6f
 RSDeVYzJ7Ai8VjTSwz+mBhK1h2TTBny8y4e6UfsE8mbwsBI3flQzShPt5ugNPWxuyDBe7fFng
 WUNwT6Zw1O3cqF5gnTygdCCFugXmUYiv0VULWFnkDVskw8A+4vIJ3un7zMVfrMKlfyorHabm5
 CiEno1vIyC54fzZeZvLIGRaz8ZWyTz4cuk/oR1KHVD0NRzP0CQ5a//21iqY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 04:53:10PM -0400, Jeff King wrote:
> On Tue, Jun 19, 2018 at 10:40:16PM +0200, Torsten Bögershausen wrote:
> 
> > 
> > 
> > On 06/19/2018 08:22 PM, Eric Sunshine wrote:
> > > On Tue, Jun 19, 2018 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > > Torsten Bögershausen <tboegi@web.de> writes:
> > > > > t5562 fails here under MacOS:
> > > > > "gzip -k"  is not portable.
> > > Very odd. Stock /usr/bin/gzip on my MacOS 10.12.6 _does_ recognize -k,
> > > and the test does pass.
> > 
> > This is the test box running Mac OS X 10.6 speaking.
> > The -c seems to need even -f.
> > But this doesn't work either:
> > 
> > gzip 1.3.12
> > Copyright (C) 2007 Free Software Foundation, Inc.
> > Copyright (C) 1993 Jean-loup Gailly.
> > This is free software.  You may redistribute copies of it under the terms of
> > the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
> > There is NO WARRANTY, to the extent permitted by law.
> 
> Ah, that's it. "-k" came about in gzip v1.6. That's 5 years old, but
> obviously some people are still running it.
> 
> "-c" goes back quite a while and should be safe, I think.
> 
> > expecting success:
> >     gzip -f -c fetch_body >fetch_body.gz &&
> >     test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
> >     gzip -f -c push_body >push_body,gz &&
> >     test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
> > 
> > ./test-lib.sh: line 632: push_body.gz: No such file or directory
> 
> Typo in the ">" redirect (comma instead of period)?
> 
> -Peff

Good eyes, thanks.
The "-f -c" combo works:

-       gzip -k fetch_body &&
+       gzip -f -c fetch_body >fetch_body.gz &&
        test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
-       gzip -k push_body &&
+       gzip -f -c push_body >push_body.gz &&
