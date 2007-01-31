From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 18:27:48 -0500
Message-ID: <20070131232748.GC31145@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <epr8e9$i7r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 00:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOrw-0008V2-Ob
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbXAaX1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbXAaX1v
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:27:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1555 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161072AbXAaX1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:27:50 -0500
Received: (qmail 11176 invoked from network); 31 Jan 2007 18:27:48 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 18:27:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 18:27:48 -0500
Content-Disposition: inline
In-Reply-To: <epr8e9$i7r$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38307>

On Thu, Feb 01, 2007 at 12:25:14AM +0100, Jakub Narebski wrote:

> > git-checkout: note use of remote tracking branch when making detached warning
> You can checkout a tag, not a remote tracking branch!

Huh?

$ git-checkout master
$ git-checkout origin/pu
Note: you are on the remote tracking branch 'origin/pu'
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
$ git-checkout master
$ git-checkout v1.4.4.4
Note: you are not on ANY branch anymore.
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>

You _can_ check out a tracking branch (in fact, I believe that is what
Carl was proposing for his users to do, but perhaps he had instead
actually tagged it). And my patch leaves the traditional output for a
tag (since you, are in fact, not on any branch at that point).

-Peff
