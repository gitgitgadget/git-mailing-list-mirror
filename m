Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2DE1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 12:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbcGSMOf (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 08:14:35 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:60219 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbcGSMOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 08:14:35 -0400
Received: from teco.navytux.spb.ru (95-55-81-113.dynamic.avangarddsl.ru [95.55.81.113])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 2DC35BF0321;
	Tue, 19 Jul 2016 14:14:32 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bPTux-0008Bj-KJ; Tue, 19 Jul 2016 15:14:31 +0300
Date:	Tue, 19 Jul 2016 15:14:31 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160719121431.GB3947@teco.navytux.spb.ru>
References: <20160713083044.GB18144@sigill.intra.peff.net>
 <20160713082653.GA18144@sigill.intra.peff.net>
 <20160713105216.GB16000@teco.navytux.spb.ru>
 <20160717170649.GA3830@teco.navytux.spb.ru>
 <20160719112907.GA12916@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160719112907.GA12916@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 05:29:07AM -0600, Jeff King wrote:
> On Sun, Jul 17, 2016 at 08:06:49PM +0300, Kirill Smelkov wrote:
> 
> > > Anyway, please find below updated patch according to your suggestion.
> > > Hope it is ok now.
> > 
> > Ping. Is the patch ok or something needs to be improved still?
> 
> Sorry, I'm traveling and haven't carefully reviewed it yet. It's still
> on my list, but it may be a few days.

Jeff thanks for feedback. Have a good traveling and good to know the patch
was not forgotten. I will be waiting for the time while you are on trip.

Thanks again for feedback,
Kirill
