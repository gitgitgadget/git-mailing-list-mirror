From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 16:40:28 -0600
Message-ID: <17876.57692.818802.89118@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
	<17876.53654.426022.454712@lisa.zopyra.com>
	<20070215214352.GA2980@coredump.intra.peff.net>
	<17876.54845.708466.669437@lisa.zopyra.com>
	<20070215215816.GA3757@coredump.intra.peff.net>
	<17876.55542.236594.121347@lisa.zopyra.com>
	<20070215220918.GB27526@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 23:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHpHi-0003TB-P8
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161586AbXBOWkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161582AbXBOWkf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:40:35 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60657 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161586AbXBOWke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:40:34 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1FMeVE18787;
	Thu, 15 Feb 2007 16:40:31 -0600
In-Reply-To: <20070215220918.GB27526@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39862>

On Thursday, February 15, 2007 at 17:09:18 (-0500) Shawn O. Pearce writes:
>...
>Lets say you patch git-clone to create these branches under
>refs/heads, and also under refs/remotes/origin.  Now someone else
>modifies one of those branches, and you do a git-fetch to get the
>latest.  The tracking branch under refs/remotes/origin would update,
>but not the one in refs/heads.  Which means "jumping right in" may
>actually cost you a lot more time, because you are now starting on
>something that is several days old.

Granted, but this would be the same as creating the branch by hand,
then going rock-climbing over the weekend, while my colleagues toiled,
and coming back on Monday to find 15 checkins on that branch, right?

At which point I could .... rebase?  Do a pull?


Bill
