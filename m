X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Tue, 28 Nov 2006 08:56:14 -0500
Message-ID: <20061128135614.GA29505@coredump.intra.peff.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> <Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de> <7v7ixge8j2.fsf@assigned-by-dhcp.cox.net> <20061128131139.GA10874@coredump.intra.peff.net> <Pine.LNX.4.63.0611281439500.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 13:56:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0611281439500.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32526>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp3Rk-0000jx-Di for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934366AbWK1N4R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934459AbWK1N4R
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:56:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8599 "HELO
 peff.net") by vger.kernel.org with SMTP id S934366AbWK1N4R (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 08:56:17 -0500
Received: (qmail 9479 invoked from network); 28 Nov 2006 08:56:24 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 28 Nov 2006 08:56:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Nov
 2006 08:56:14 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Tue, Nov 28, 2006 at 02:43:49PM +0100, Johannes Schindelin wrote:

> BTW merge-recursive is a perfect example why this approach will break 
> down: most of the rewrite in C took place in a private repository with 
> quite some commits. This does not show in the git repository.
> 
> I fully expect the linux repository to behave similarly, since most of the 
> features are cooked elsewhere, and not all of them are pulled, but some 
> are applied (i.e. they appear out of nowhere from the repository's 
> viewpoint).

Yes, I think this would be more useful in concert with some sort of
grouping. If we can make a group of commits related to merge-recursive,
and score them as a single item, then they can be compared to other
groups (which may consist of a single commit or several).

