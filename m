From: Jeff King <peff@peff.net>
Subject: Re: Git - index-pack missing
Date: Wed, 17 Dec 2008 22:16:39 -0500
Message-ID: <20081218031639.GA20749@coredump.intra.peff.net>
References: <54F47863-AF55-4FB7-8A43-A4253E1F782C@michaelbutros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Boutros <me@michaelboutros.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 04:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9Oj-0002QC-IR
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYLRDQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYLRDQm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:16:42 -0500
Received: from peff.net ([208.65.91.99]:4884 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbYLRDQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:16:41 -0500
Received: (qmail 31588 invoked by uid 111); 18 Dec 2008 03:16:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 22:16:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 22:16:39 -0500
Content-Disposition: inline
In-Reply-To: <54F47863-AF55-4FB7-8A43-A4253E1F782C@michaelbutros.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103425>

On Wed, Dec 17, 2008 at 06:40:40PM -0500, Michael Boutros wrote:

> I'm trying to clone a repository for the first time on a hosting account 
> that just got setup with Git. However, the problem is that for some reason 
> there is no git-index-pack. I cannot find any reason that that one 
> particular command would not be installed, but for some reason that seems 
> to be the case.

How did you install git? From a binary package, from a tarball, from a
clone? If built, how did you build it? Any config.mak options, did you
use ./configure, etc? What version of git is it?

Is it possible for you to strace the clone process to see where it is
trying to find index-pack? Something like:

  strace -f -e execve git clone

should do it.

> Has anyone ever heard of anything like this? Is my only option to  
> completely scrap Git and try again?

That might work, but if this is a bug in the build or installation
system, it will be nice to track it down before you scrap the current
setup.

-Peff
