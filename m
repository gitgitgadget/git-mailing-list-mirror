From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/2] Add getLong to RepositoryConfig
Date: Sat, 13 Jun 2009 12:21:22 -0700
Message-ID: <20090613192122.GT16497@spearce.org>
References: <1244848986-10526-1-git-send-email-spearce@spearce.org> <4A335BD7.60107@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sat Jun 13 21:21:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFYnD-0006KL-NP
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 21:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbZFMTVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 15:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZFMTVU
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 15:21:20 -0400
Received: from george.spearce.org ([209.20.77.23]:54560 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbZFMTVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 15:21:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 87F67381FD; Sat, 13 Jun 2009 19:21:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A335BD7.60107@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121517>

Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
> Shawn O. Pearce wrote:
> > This supports parsing 64 bit configuration values.
...
> > +	/**
> > +	 * Obtain an integer value from the configuration.
> s/integer/long/g in this (copy&paste) javadoc part

Its still integer as in from the integer number space, and not say
a floating point decimal.  Thus I didn't bother with this edit,
I figured the method name was clear enough that it would return
a long, but the concept of it parsing only "2g" and not "1.5g"
should go in the documentation.
 
And again, please trim parts you aren't replying to.

-- 
Shawn.
