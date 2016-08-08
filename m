Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42042018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcHHS6u (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:58:50 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:33364 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcHHS6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:58:49 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-29-27.dynamic.avangarddsl.ru [178.66.29.27])
	by mail2.tiolive.com (Postfix) with ESMTPSA id B9267BF034A;
	Mon,  8 Aug 2016 20:58:47 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bWpl9-0001nq-5r; Mon, 08 Aug 2016 21:58:47 +0300
Date:	Mon, 8 Aug 2016 21:58:47 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap
 index when generating non-stdout pack too
Message-ID: <20160808185846.GE3995@teco.navytux.spb.ru>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074746.31862-1-kirr@nexedi.com>
 <20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
 <20160808154054.GB3995@teco.navytux.spb.ru>
 <xmqq60rbf80t.fsf@gitster.mtv.corp.google.com>
 <20160808181353.GC3995@teco.navytux.spb.ru>
 <xmqq1t1zf74d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1t1zf74d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 11:28:02AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > Another question: I'm preparing another version of "pack-objects: Teach
> > --use-bitmap-index codepath to  respect --local ..." and was going to
> > put
> >
> >     ( updated patch is in the end of this mail )
> >
> > in the top of the message. Is it ok or better not to do so and just respin
> > the patch in its own separate mail?
> 
> That would force those who pick leftover bits to _open_ and read a
> first few lines.
> 
> Definitely it is better than burying a patch after 60+ lines, but a
> separate patch with incremented "[PATCH v6 1/2]" on the subject line
> beats it hands-down from discoverability's point of view.

Thanks, I see. I've resent both patches as separate mails.
