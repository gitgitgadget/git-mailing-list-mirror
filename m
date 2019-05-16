Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272031F461
	for <e@80x24.org>; Thu, 16 May 2019 08:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEPIfZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 04:35:25 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50652 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfEPIfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 04:35:25 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hRBrD-0002T1-GH; Thu, 16 May 2019 17:35:19 +0900
Date:   Thu, 16 May 2019 17:35:19 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190516083519.5n6qmdw2aaqhjudd@glandium.org>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
 <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
 <20190515220834.svurujspjt3bmath@glandium.org>
 <20190515235339.GA3579@sigill.intra.peff.net>
 <20190516004802.fmtdz52xxcplkgcf@glandium.org>
 <20190516032802.GB4596@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516032802.GB4596@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 11:28:02PM -0400, Jeff King wrote:
> Totally orthogonal, but I think we might also want to introduce a helper
> capability so that import helpers can say "I always send 'done' to
> fast-import". And then we can pass "--done" to fast-import, which means
> it would detect a truncated stream.

Doubly orthogonal, but I wouldn't mind a helper capability that allows
import helpers to deal with creating git objects on their own rather
than having a fast-import spawned (git-cinnabar actually doesn't use the
fast-import stream it's offered to use, but can't be a fetch helper
either)

Mike
