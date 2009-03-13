From: Jeff King <peff@peff.net>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 12:49:41 -0400
Message-ID: <20090313164941.GA16504@sigill.intra.peff.net>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 13 17:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiAcg-0005eS-Mg
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 17:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759083AbZCMQts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758920AbZCMQts
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 12:49:48 -0400
Received: from peff.net ([208.65.91.99]:48327 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757346AbZCMQtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 12:49:47 -0400
Received: (qmail 8542 invoked by uid 107); 13 Mar 2009 16:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 13 Mar 2009 12:49:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2009 12:49:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113208>

On Fri, Mar 13, 2009 at 08:48:55AM +0100, Peter Krefting wrote:

> Doing "git push remote" pushes all my local branches by default. Is there 
> a way to set it to *not* do that, and (for this particular remote 
> repository) just push the current branch? Or failing that, not allow me to 
> run "git push" without specifying a branch?
>
> The git-config manual page leads me to believe that I should recofigure  
> "remote.<name>.push", but it points me to the "refspec" spec on git-push,  
> which is a tad cryptic.

There seem to be a lot of responses in this thread, but nobody has
suggested:

  git config remote.$remote.push HEAD

It isn't mentioned in the git-push manpage; maybe a documentation patch
to give an example using HEAD would make sense?

-Peff
