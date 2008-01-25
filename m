From: Jeff King <peff@peff.net>
Subject: Re: What's a "work tree"?
Date: Fri, 25 Jan 2008 16:56:54 -0500
Message-ID: <20080125215653.GA16694@coredump.intra.peff.net>
References: <4798E26D.3040707@talkingspider.com> <20080125061421.GC21973@coredump.intra.peff.net> <479A4C9F.3070200@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:57:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIWYY-00089s-CR
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 22:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYAYV46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 16:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755387AbYAYV46
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 16:56:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2751 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbYAYV45 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 16:56:57 -0500
Received: (qmail 5439 invoked by uid 111); 25 Jan 2008 21:56:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 25 Jan 2008 16:56:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2008 16:56:54 -0500
Content-Disposition: inline
In-Reply-To: <479A4C9F.3070200@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71743>

On Fri, Jan 25, 2008 at 03:54:55PM -0500, Mike wrote:

> Yes, thanks, I was actually following this tutorial:
>
> http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html
>
> Which is how I ended up with a "bare" git dir.  Which actually I think  
> I'm ok with, seems to work ok.

Ah, OK. The normal use case would then be to clone that bare repository
(though you seem to be directly exposing the work tree with the
webserver, so you may not want to have the .git directory there -- there
was a long-ish thread about that a week or two ago).

> Also- I found out I needed a newish version of git to get the
> --work-tree argument. The CentOS repos have an older version,
> 1.2.something.

Yes, that is ancient in git terms (in particular, pre-1.5.x has a number
of interface differences). The work-tree option was added in 1.5.3.

-Peff
