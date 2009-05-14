From: Jeff King <peff@peff.net>
Subject: Re: git push don't setup tracking?
Date: Thu, 14 May 2009 02:34:52 -0400
Message-ID: <20090514063451.GB10411@coredump.intra.peff.net>
References: <1de9d39c0905110446h5a0b54e3ic7cf58dda24d4bc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UWz-0000cg-F5
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761345AbZENGew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760417AbZENGew
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:34:52 -0400
Received: from peff.net ([208.65.91.99]:32897 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234AbZENGew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:34:52 -0400
Received: (qmail 20279 invoked by uid 107); 14 May 2009 06:34:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 May 2009 02:34:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2009 02:34:52 -0400
Content-Disposition: inline
In-Reply-To: <1de9d39c0905110446h5a0b54e3ic7cf58dda24d4bc4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119150>

On Mon, May 11, 2009 at 01:46:10PM +0200, jean-luc malet wrote:

> I want to use git in a "star" configuration.
> I have  "repository" and 2 client "home" and "work"
> I cloned repository on home and work, then I created a branch at work,
> and pushed it to repository, at home I "git branch --track
> origin/newbranch" and done some work... all ok there... then I pushed
> again to repository
> come back at work I wanted just to do a git pull.... and there it says
> me that it don't have any tracking information... so I add to add by
> hand the following lines into .git/config :
> [branch "newbranch"]
> 	remote = origin
> 	merge = refs/heads/newbranch
> 
> and now it's working.... I think there shall be a way like "git push
> --track newbranch origin" so it store tracking information

Yeah, this is on my todo list, but it is pretty low. There is a little
bit of cleanup that probably needs to happen first to unify http:// and
git:// push (Daniel did some of that recently, but I haven't had time to
look carefully at his work).

If you wanted to work on it, I would be happy to help guide you.
Otherwise, I may get to it eventually.

-Peff
