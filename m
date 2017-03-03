Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4872013E
	for <e@80x24.org>; Fri,  3 Mar 2017 01:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbdCCBvf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 20:51:35 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56314 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbdCCBva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 20:51:30 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89_RC6)
        (envelope-from <mh@glandium.org>)
        id 1cjcMp-0006LQ-QG; Fri, 03 Mar 2017 10:50:47 +0900
Date:   Fri, 3 Mar 2017 10:50:47 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170303015047.p4lpkdzp4hbpz5vi@glandium.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
 <xmqqk287be9l.fsf@gitster.mtv.corp.google.com>
 <CA+55aFziZRA29foAMbM-HS5fiup7T0TuYf4XQ1kNT_SR7FfSgw@mail.gmail.com>
 <20170302215457.l2zhxgnvhulw2hl5@kitenet.net>
 <CA+55aFzdJcFZQdJ78rvZ92nNZRsKfcUKMCiXwTVYR34JAuznrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzdJcFZQdJ78rvZ92nNZRsKfcUKMCiXwTVYR34JAuznrA@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 02:27:15PM -0800, Linus Torvalds wrote:
> On Thu, Mar 2, 2017 at 1:54 PM, Joey Hess <id@joeyh.name> wrote:
> >
> > There's a surprising result of combining iterated hash functions, that
> > the combination is no more difficult to attack than the strongest hash
> > function used.
> 
> Duh. I should actually have known that. I started reading the paper
> and went "this seems very familiar". I'm pretty sure I've been pointed
> at that paper before (or maybe just a similar one), and I just didn't
> react enough for it to leave a lasting impact.

What if the "object version" is a hash of the content (as opposed to
header + content like the normal git hash)?

Mike
