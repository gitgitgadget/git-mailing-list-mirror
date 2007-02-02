From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 1 Feb 2007 20:16:09 -0500
Message-ID: <20070202011608.GA18880@thunk.org>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net> <20070201215242.GA1775@thunk.org> <7v64alnz2q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 02:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCn2K-0000CN-Cd
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 02:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbXBBBQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 20:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423053AbXBBBQR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 20:16:17 -0500
Received: from THUNK.ORG ([69.25.196.29]:37769 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423057AbXBBBQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 20:16:17 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HCn78-00023e-Lk; Thu, 01 Feb 2007 20:21:18 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HCn29-0007Jt-IW; Thu, 01 Feb 2007 20:16:09 -0500
Content-Disposition: inline
In-Reply-To: <7v64alnz2q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38443>

On Thu, Feb 01, 2007 at 05:11:09PM -0800, Junio C Hamano wrote:
> Didn't I already point out that you can have a precious
> information while on the detached HEAD without making any
> commit, and that is the reason why we do not use the
> reachability crud from refs when deciding to issue the message?

Sorry, I must be dense.  Exactly what precious information can be ever
be lost in the following sequence:

git checkout HEAD~1
git checkout master

such that it want to train users to be typing

git checkout -f master

instead?

						- Ted
