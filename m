From: Jeff King <peff@peff.net>
Subject: Re: [RFH] bug in unpack_trees
Date: Thu, 13 Mar 2008 10:00:05 -0400
Message-ID: <20080313140005.GA30348@coredump.intra.peff.net>
References: <20080304115940.GA5260@sigill.intra.peff.net> <alpine.LFD.1.00.0803081417040.5896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnzD-0007iU-NF
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 15:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYCMOAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 10:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbYCMOAI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 10:00:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2957 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbYCMOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 10:00:07 -0400
Received: (qmail 1990 invoked by uid 111); 13 Mar 2008 14:00:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 10:00:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 10:00:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803081417040.5896@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77088>

On Sat, Mar 08, 2008 at 02:25:03PM -0800, Linus Torvalds wrote:

> But when I just tested the bug-report case that Jeff described, it seems 
> that I fixed the bug just with my cleanup. The current git "master" branch 
> gives the following (incorrect) output for Jeff's script:

Heh. I never meant to just dump the bug on you and run away, but I
haven't had much of a chance to review your patches until now. Looks
like Junio shook all the bugs out, though. ;) Thanks for all the hard
work on this.

The _real_ bug which started this, though, was actually a git-rebase
problem reported by John Goerzen on a private repo. I'm 99% sure that
this read-tree issue was the problem, but it would be nice to confirm
it is fixed.

John, is it possible for you to re-try that rebase and confirm that it
works with the current master? I deleted the repo you sent me after
narrowing the bug.

-Peff
