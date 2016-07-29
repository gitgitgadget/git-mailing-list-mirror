Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787791F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 07:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbcG2HlA (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 03:41:00 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:37628 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcG2Hk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 03:40:59 -0400
Received: from teco.navytux.spb.ru (pppoe.95-55-164-187.dynamic.avangarddsl.ru [95.55.164.187])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 276BBBF0327;
	Fri, 29 Jul 2016 09:40:55 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bT2Pc-0004ul-3R; Fri, 29 Jul 2016 10:40:52 +0300
Date:	Fri, 29 Jul 2016 10:40:52 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160729074051.GA5987@teco.navytux.spb.ru>
References: <20160725185313.GA13007@sigill.intra.peff.net>
 <20160727201506.GA15204@teco.navytux.spb.ru>
 <xmqqlh0mvmpn.fsf@gitster.mtv.corp.google.com>
 <20160728202237.GC4026@teco.navytux.spb.ru>
 <xmqqh9b9qx5m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh9b9qx5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 02:18:29PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > I'm waiting so long for main patch to be at least queued to pu, that I'm
> > now a bit frustrated and ready to do something not related to main goal :)
> 
> Perhaps the first step would be to stop putting multiple patches in
> a single e-mail buried after a few pages of discussion.  I will not
> even find that there _are_ multiple patches in the message if I am
> not involved directly in the discussion, and the discussion is still
> ongoing, because it is likely that I'd skim just a few paragraphs at
> the top before going on to other messages.
> 
> I won't touch the message I am responding to, as your -- 8< -- cut
> mark does not even seem to be a reliable marker between patches
> (i.e.  I see something like this that is clearly not a message
> boundary:
> 
> than `git pack-objects file.pack`. Extracting erp5.git pack from
> lab.nexedi.com backup repository:
> 
> ---- 8< ----
> $ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack
> 
> real    0m22.309s
> ...
> )

Ok, makes sense and my fault. I'm resending each patch as separate
message in reply to this mail.
