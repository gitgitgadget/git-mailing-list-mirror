Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D861F859
	for <e@80x24.org>; Mon, 22 Aug 2016 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756275AbcHVTQa (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 15:16:30 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33665 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755484AbcHVTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 15:16:28 -0400
Received: from mfilter17-d.gandi.net (mfilter17-d.gandi.net [217.70.178.145])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 9EA84C5A5A;
        Mon, 22 Aug 2016 21:16:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter17-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter17-d.gandi.net (mfilter17-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 5vExb_6wKUR3; Mon, 22 Aug 2016 21:16:25 +0200 (CEST)
X-Originating-IP: 75.98.193.200
Received: from x (unknown [75.98.193.200])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B4867C5A5C;
        Mon, 22 Aug 2016 21:16:23 +0200 (CEST)
Date:   Mon, 22 Aug 2016 15:16:22 -0400
From:   Josh Triplett <josh@joshtriplett.org>
To:     Richard <richard.maw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Adding more namespace support to git
Message-ID: <20160822191622.6cok5tbbbc3ysu6f@x>
References: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
 <20160821020537.eiyh4vnhmnuctgtz@x>
 <CAB2VqoZdj1rhdt-4gUhXTAMQjJTOqCuwXiO6yfB2Fzyy_qSWHg@mail.gmail.com>
 <20160821140710.qpbm37nhhvbkmxgz@x>
 <CAB2Vqoa+1QKD-7zjNUJBuu2qNowgY7n9fLM77zUdzf8aJi4XaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB2Vqoa+1QKD-7zjNUJBuu2qNowgY7n9fLM77zUdzf8aJi4XaQ@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 07:36:31PM +0100, Richard wrote:
> On 21 Aug 2016 15:07, "Josh Triplett" <josh@joshtriplett.org> wrote:
> > I'd like to see it work more automatically than that.  Perhaps a
> > separate environment variable to set the client-side namespace?
> 
> How about a config option? That could be set globally, per repository, in
> the environment or on the command line.

That might work, though you wouldn't normally want to set it globally or
per-repository (since it affects access to a repository and you'd
typically want to use multiple different values or it wouldn't have much
point).

- Josh Triplett
