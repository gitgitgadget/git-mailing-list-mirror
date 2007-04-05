From: Jeff King <peff@peff.net>
Subject: Re: 'git checkout -f' versus 'git reset --hard'
Date: Thu, 5 Apr 2007 09:43:12 -0400
Message-ID: <20070405134311.GA18163@coredump.intra.peff.net>
References: <17940.64329.10165.993967@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZSFH-0006oq-11
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 15:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992726AbXDENnQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 09:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992775AbXDENnQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 09:43:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3037 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992726AbXDENnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 09:43:16 -0400
Received: (qmail 12872 invoked from network); 5 Apr 2007 13:43:48 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Apr 2007 13:43:48 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2007 09:43:12 -0400
Content-Disposition: inline
In-Reply-To: <17940.64329.10165.993967@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43826>

On Thu, Apr 05, 2007 at 08:36:09AM -0500, Bill Lear wrote:

> After a failed merge, I want to undo things.  I typically use git
> reset --hard, and it works like a charm.  Others have tried to use git
> checkout -f, but I have cautioned that git reset --hard is really the
> way to do it.  Is there a difference here, or are they equivalent?

Skimming through the code (and looking at the output of sh -x), it looks
like both just end up executing git-read-tree --reset -u $HEAD.

-Peff
