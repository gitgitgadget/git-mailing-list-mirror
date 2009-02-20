From: Jeff King <peff@peff.net>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff
	--no-index'
Date: Fri, 20 Feb 2009 09:53:31 -0500
Message-ID: <20090220145331.GA3515@coredump.intra.peff.net>
References: <499E92FD.8000900@alum.mit.edu> <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 15:55:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWmO-0003R6-8U
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 15:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZBTOxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 09:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZBTOxf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 09:53:35 -0500
Received: from peff.net ([208.65.91.99]:41415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbZBTOxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 09:53:34 -0500
Received: (qmail 2714 invoked by uid 107); 20 Feb 2009 14:53:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 09:53:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 09:53:31 -0500
Content-Disposition: inline
In-Reply-To: <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110850>

On Fri, Feb 20, 2009 at 03:12:28PM +0100, Johannes Schindelin wrote:

> 	Michael wrote:
> 
> 	> I can't think offhand of a more portable tool that could replace 
> 	> "diff -r -x" here (suggestions, anyone?).
> 
> 	Maybe something like this?

Great. Using "git diff" was my first thought, too.

> 	Note: before it can be included in git.git, documentation and 
> 	tests have to be added; also, it might be a good idea to extend it 
> 	to the "non-no-index" case (maybe I can beat Peff in the number of 
> 	double negations one day...)

Maybe a config option "diff.denyNonIndexExclude = false"? *ducks*

But more seriously, how would a user expect this to interact with
.gitignore? I know gitignore is about ignoring untracked files, but I
can't help but feel the two have something in common. But maybe not. I'm
sick today and my brain is not working very well.

-Peff
