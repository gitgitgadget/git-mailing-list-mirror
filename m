From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gc: improve wording of --auto notification
Date: Thu, 18 Oct 2007 21:24:30 -0400
Message-ID: <20071019012430.GT14735@spearce.org>
References: <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com> <47176AB9.7010409@midwinter.com> <20071019001648.GO14735@spearce.org> <20071019011211.GC3290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iigbd-0000Aj-AL
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534AbXJSBYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbXJSBYl
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:24:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41285 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbXJSBYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:24:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iigb3-0003vZ-3R; Thu, 18 Oct 2007 21:24:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 394AA20FBAE; Thu, 18 Oct 2007 21:24:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071019011211.GC3290@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61591>

Jeff King <peff@peff.net> wrote:
> Shawn said:
> > A patch against spearce/master to revert the prior message and insert
> > something that is perhaps more reasonable would be most appreciated.
> 
> Geez, you really _are_ the maintainer now, prodding your minions to
> write trivial patches for you. :)

Heh.  But didn't I just post a different trivial patch to the
mailing list not 15 minutes ago?  :-)

> I don't see any point in reverting the
> other patch separately, since we can just improve the message.

I agree.  No point in pissing in the snow multiple times over a
simple language change.  I was perhaps a little too aggressive in
applying Steven's first patch.  Which I also now see git-am actually
split the From line incorrectly and doesn't actually show Steven's
name in the author field.  Arrgh.
 
> I tried not to use the word "avoid" since I think we don't want to imply
> that auto-gc sucks. It doesn't, but some people might prefer to run it
> manually, and we should let them know it's an option. I'm open to
> wording improvements.

I think what you have is many times better.  It doesn't tell the
user that they can prevent having this activate at the wrong time
by just running git-gc every so often, but if the message (and
the subsequent packing itself) is annoying they'll read the manual
entry and hopefully figure that out on their own.
 
>  		fprintf(stderr, "Packing your repository for optimum "
> +			"performance. You may also\n"
> +			"run \"git gc\" manually. See "
> +			"\"git help gc\" for more information.\n");

-- 
Shawn.
