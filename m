Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732CF1F859
	for <e@80x24.org>; Sun, 21 Aug 2016 08:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbcHUIso (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 04:48:44 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47245 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbcHUIsn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 04:48:43 -0400
Received: from mfilter41-d.gandi.net (mfilter41-d.gandi.net [217.70.178.173])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 3A7C5FB882;
        Sun, 21 Aug 2016 10:48:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter41-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter41-d.gandi.net (mfilter41-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id u0pHr_RSRJMf; Sun, 21 Aug 2016 10:48:39 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D49D0FB8A3;
        Sun, 21 Aug 2016 10:48:38 +0200 (CEST)
Date:   Sun, 21 Aug 2016 01:48:37 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Subject: Re: Most recent revision that contains a string
Message-ID: <20160821084837.nyfnwefx5hteipcq@x>
References: <87d1l3ce40.fsf@thinkpad.rath.org>
 <20160821013040.4sfmg2v7rcovxxmb@x>
 <m2mvk6iloy.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2mvk6iloy.fsf@linux-m68k.org>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2016 at 10:13:33AM +0200, Andreas Schwab wrote:
> On Aug 20 2016, Josh Triplett <josh@joshtriplett.org> wrote:
> > If you want to find a change that introduces or removes a particular
> > string, you could use "git log -S".  That doesn't allow regexes,
> 
> It does, actually, see --pickaxe-regex.

Thanks; I found that after looking up "git log -G", which Eric Wong
mentioned in another reply.
