From: Jeff King <peff@peff.net>
Subject: Re: status letters consistency in log and ls-files
Date: Fri, 26 Sep 2008 18:45:46 -0400
Message-ID: <20080926224546.GB24817@coredump.intra.peff.net>
References: <ee2a733e0809261128h4c50d27bq3942bd1b3b66d3ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:47:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjM5T-0007L4-Q8
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 00:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbYIZWpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 18:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYIZWpt
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 18:45:49 -0400
Received: from peff.net ([208.65.91.99]:1181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbYIZWps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 18:45:48 -0400
Received: (qmail 8677 invoked by uid 111); 26 Sep 2008 22:45:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Sep 2008 18:45:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Sep 2008 18:45:46 -0400
Content-Disposition: inline
In-Reply-To: <ee2a733e0809261128h4c50d27bq3942bd1b3b66d3ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96888>

On Fri, Sep 26, 2008 at 02:28:50PM -0400, Leo Razoumov wrote:

> So, depending on which of the commands above are used status "R" could
> mean either Renamed or Removed, "M" is either Modified or unMerged,
> "C" is either Copied or Changed.
> 
> Is it possible to make it consistent across related commands?

I think this is rooted in historical reasons. Unfortunately, I don't
think it is possible to reconcile the two outputs at this point, as we
would be breaking any scripts which use the tools.

Out of curiosity, is there a script you are writing or some workflow you
have where you see the output of both? Or did you just notice this while
exploring git?

I ask because there may be a way to alter your workflow to always use
one tool.

-Peff
