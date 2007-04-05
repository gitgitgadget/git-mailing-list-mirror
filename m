From: Bill Lear <rael@zopyra.com>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 09:25:29 -0500
Message-ID: <17941.1753.893556.725405@lisa.zopyra.com>
References: <17940.59514.150325.738141@lisa.zopyra.com>
	<20070405134954.GA18402@coredump.intra.peff.net>
	<17941.655.192938.792088@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 16:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZSu9-0001EG-5v
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 16:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767010AbXDEOZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 10:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767008AbXDEOZd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 10:25:33 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61088 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767010AbXDEOZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 10:25:32 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l35EPU514624;
	Thu, 5 Apr 2007 08:25:30 -0600
In-Reply-To: <17941.655.192938.792088@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43829>

On Thursday, April 5, 2007 at 09:07:11 (-0500) Bill Lear writes:
>...
>Hmm.... I wonder if his remote repo is non-bare... I'll try to find
>out.

Yes, it is.  Here is the reply I got from my friend:

>Bill Lear writes:
> > So, the remote repo to which you pushed originally is non-bare?  That
> > is, it has working files checked out?
>
>Correct.
>
> > If so, that is a problem, but
> > perhaps not the cause of your problems.  Never push to a non-bare
> > repo: you need to go that repo and do a pull instead.
>
>I've been able to work around such problems.  I know well about the
>double-commit reversal whammy that can happen (since it happened to me).
>If I push to a non-bare repo that's otherwise got no file modifications
>in it, I can do a "git status" to see what files it thinks are out of
>date, which tells me (by the file list) that the push succeeded.  Then
>I just do a "git checkout -f" to sync up.  Up til now, has worked like
>a charm.  Alternately, I switch to some bogus temporary branch in the
>non-bare repo I'm pushing to & switch back after.


Bill
