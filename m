From: Jeff King <peff@peff.net>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Fri, 10 Aug 2007 12:11:23 -0400
Message-ID: <20070810161123.GA14875@sigill.intra.peff.net>
References: <20070810154108.GA779@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Hetro <whee@smaertness.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJX7V-0007wq-0u
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941073AbXHJQLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940801AbXHJQLa
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:11:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4131 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S941061AbXHJQL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 12:11:28 -0400
Received: (qmail 3860 invoked by uid 111); 10 Aug 2007 16:11:33 -0000
X-Spam-Status: No, hits=-1.2 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 10 Aug 2007 12:11:32 -0400
Received: (qmail 15540 invoked by uid 1000); 10 Aug 2007 16:11:23 -0000
Content-Disposition: inline
In-Reply-To: <20070810154108.GA779@ruiner>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55550>

On Fri, Aug 10, 2007 at 11:41:08AM -0400, Brian Hetro wrote:

> Hi,
> I have a problem with gitk not being able to show one of my
> repositories (git version 1.5.3.rc4.41.g7efe).  I get this error while
> gitk starts:
> 
> can't unset "idinlist(f1d795add789ec43d3ccf1d35f3c39fb464f6e72)": no
> such element in array
> [...]
> 
> I performed a bisect and commit
> 1ed84157a21a3e868228b15588e4aadfbe5a030b appears to be the culprit
> (Revert 88494423 (removal of duplicate parents in the output
> codepath)).

This was fixed in e1abc69b, which is in 1.5.3-rc3, covered in this
thread:

http://thread.gmane.org/gmane.comp.version-control.git/53126

Can you confirm that it is still a problem in 1.5.3-rc4?

-Peff
