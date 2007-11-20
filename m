From: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: gitweb: kernel versions in the history (feature request,	probably)
Date: Wed, 21 Nov 2007 00:30:23 +0100
Message-ID: <47436E0F.6080003@o2.pl>
References: <20071120142042.GA4157@ff.dom.local> <20071120215904.GF1001@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762610AbXKTX3X@vger.kernel.org Wed Nov 21 00:29:54 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762610AbXKTX3X@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IucXI-0007rx-0T
	for glk-linux-kernel-3@gmane.org; Wed, 21 Nov 2007 00:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762610AbXKTX3X (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 20 Nov 2007 18:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbXKTX3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Nov 2007 18:29:06 -0500
Received: from mx12.go2.pl ([193.17.41.142]:36656 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754982AbXKTX3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Nov 2007 18:29:05 -0500
Received: from poczta.o2.pl (mx12 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id A2A943E8064;
	Wed, 21 Nov 2007 00:29:02 +0100 (CET)
Received: from [83.27.8.67] (aua67.neoplus.adsl.tpnet.pl [83.27.8.67])
	by poczta.o2.pl (Postfix) with ESMTP;
	Wed, 21 Nov 2007 00:29:02 +0100 (CET)
User-Agent: Icedove 1.5.0.14pre (X11/20071020)
In-Reply-To: <20071120215904.GF1001@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65580>

Petr Baudis wrote, On 11/20/2007 10:59 PM:

>   Hi,
> 
> On Tue, Nov 20, 2007 at 03:20:42PM +0100, Jarek Poplawski wrote:
>> I see gitweb is much more usable (faster) than a few months ago, but
>> there is one thing a bit problematic: in the history of patches I'm
>> very often interested in which kernel version of Linus' tree the patch
>> appeared for the first time. If it's not some big problem, and maybe
>> somebody else finds this useful too, I'd really appreciate adding such
>> a feature.
> 
>   in git terms, you'd like gitweb to provide output for command:
> 
> 	git describe --contains
> 
> This is interesting feature request. I guess the support would be nice,
> though in theory this operation can be a bit resource-intensive in case
> there is not many tags and a lot of development (with uncached
> repository, this query took quite a bit of time on my copy of the kernel
> git tree). Probably this should be an optional feature and somehow dwell
> on a separate page, which doesn't fit too well in the current gitweb
> page structure...
 

I don't know git, but it seems, at least if done for web only, this
shouldn't be so 'heavy'. It could be a 'simple' translation of commit
date by querying a small database with kernel versions & dates. And it
would suffice if it were shown on the commit page only. But, of course,
it's not urgent at all! (And alas I'm no webmaster, so I can miss
something.)

>> Petr, I hope there is no necessity to subscribe to the git list for
>> this one question, so I'd really feel greteful for forwarding, if you
>> find this request reasonable.
> 
>   Yes, there is no necessity - you can post this on the git mailing list
> without subscribing yourself.


Great! I misunderstood the page message. Btw., I know it's not the kernel,
but IMHO there should be some place for it in the MAINTAINERS!

Thanks,
Jarek P.
