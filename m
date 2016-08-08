Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE132018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcHHSN5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:13:57 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:58735 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcHHSN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:13:57 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-29-27.dynamic.avangarddsl.ru [178.66.29.27])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 94492BF034A;
	Mon,  8 Aug 2016 20:13:54 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bWp3h-0000bF-Ht; Mon, 08 Aug 2016 21:13:53 +0300
Date:	Mon, 8 Aug 2016 21:13:53 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap
 index when generating non-stdout pack too
Message-ID: <20160808181353.GC3995@teco.navytux.spb.ru>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074746.31862-1-kirr@nexedi.com>
 <20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
 <20160808154054.GB3995@teco.navytux.spb.ru>
 <xmqq60rbf80t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60rbf80t.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 11:08:34AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > Thanks for the info. I did not knew about show-index when I was starting
> > to work on this and later it just came out of sight. Please find
> > corrected patch below.
> >
> > ---- 8< ----
> > From: Kirill Smelkov <kirr@nexedi.com>
> > Date: Fri, 29 Jul 2016 10:47:46 +0300
> > Subject: [PATCH v5] pack-objects: Teach it to use reachability bitmap index when
> >  generating non-stdout pack too
> 
> Please don't do this (not the patch text itself, but saying "Please
> find ..." and attaching the patch AFTER 60+ lines of response).
> When going through old/read messages to see if there are patches
> that fell through the cracks, if it is not immediately clear in the
> top part of the message that it contains an updated patch, such a
> patch will certainly be missed.
> 
> Please say "I'll follow up with a corrected patch" instead of
> "Please find ..." and respond to that message with just the patch.

Ok, I see. Should I resend this v5 as separated one or only starting
from next time?

Another question: I'm preparing another version of "pack-objects: Teach
--use-bitmap-index codepath to  respect --local ..." and was going to
put

    ( updated patch is in the end of this mail )

in the top of the message. Is it ok or better not to do so and just respin
the patch in its own separate mail?

Thanks beforehand for clarifying,
Kirill

P.S. I put updated patches in the same mail not because I'm trying to
    make maintainer's life harder, but because this is the way I would
    expect and prefer them to be coming to me...
