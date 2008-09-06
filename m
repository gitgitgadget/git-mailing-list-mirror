From: Jeff King <peff@peff.net>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Fri, 5 Sep 2008 21:29:41 -0400
Message-ID: <20080906012941.GA2009@coredump.intra.peff.net>
References: <48C1D2AE.3010001@feds.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Gerlach <egerlach@feds.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Sep 06 03:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbmde-000867-KK
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 03:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYIFB3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 21:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYIFB3p
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 21:29:45 -0400
Received: from peff.net ([208.65.91.99]:3887 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYIFB3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 21:29:44 -0400
Received: (qmail 21086 invoked by uid 111); 6 Sep 2008 01:29:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 05 Sep 2008 21:29:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Sep 2008 21:29:41 -0400
Content-Disposition: inline
In-Reply-To: <48C1D2AE.3010001@feds.uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95055>

On Fri, Sep 05, 2008 at 08:45:34PM -0400, Eric Gerlach wrote:

> I'm trying to test to see if "git diff --cached" will fail because there  
> are no existing commits.  I've come up with running "git show-ref -h -q"  
> and testing its return value.  My hypothesis is: If and only if  
> git-show-ref succeeds then git-diff will succeed.
>
> Are my logic and assumptions sound?  I'm a bit out of my git comfort zone 
> here, so I'd like to get some validation from some people who know  
> better.

Maybe "git rev-parse --verify HEAD"?

-Peff
