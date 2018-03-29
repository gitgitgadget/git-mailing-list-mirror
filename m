Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E161F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeC2Rup (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:50:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:47622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750866AbeC2Ruo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:50:44 -0400
Received: (qmail 18072 invoked by uid 109); 29 Mar 2018 17:50:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 17:50:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20736 invoked by uid 111); 29 Mar 2018 17:51:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 13:51:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 13:50:42 -0400
Date:   Thu, 29 Mar 2018 13:50:42 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] set_work_tree: use chdir_notify
Message-ID: <20180329175042.GD31833@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net>
 <20180328174215.GC16274@sigill.intra.peff.net>
 <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
 <CACsJy8DP_D14ZwJnNjkqPDBXCyXYkW9mK_boqZDRxiTUFhMmMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DP_D14ZwJnNjkqPDBXCyXYkW9mK_boqZDRxiTUFhMmMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 07:23:17PM +0200, Duy Nguyen wrote:

> On Thu, Mar 29, 2018 at 7:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > ...
> >
> > It's less code this way, but it uses up more of your (or my) time
> > because even though the first set_git_dir() call actually happens at 8
> > places. Is it worth trying ?
> 
> Never mind. I took a stab anyway. The setup code should have much less
> side effect before we can do stuff like this.

Oh, I should have read this before responding. Oh well. :)

-Peff
