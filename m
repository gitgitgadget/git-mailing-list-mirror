From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-svnimport: what to do after -i?
Date: Thu, 23 Aug 2007 21:06:19 -0400
Message-ID: <20070824010619.GA18265@falcon.digizenstudio.com>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com> <20070823012836.GA18796@falcon.digizenstudio.com> <Pine.LNX.4.64.0708230827440.26254@beast.quantumfyre.co.uk> <20070823130031.GA17092@falcon.digizenstudio.com> <Pine.LNX.4.64.0708240113360.32194@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 24 03:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IONd4-0002uT-Bw
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 03:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765503AbXHXBGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 21:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765446AbXHXBGW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 21:06:22 -0400
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:58420
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764958AbXHXBGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 21:06:22 -0400
Received: (qmail 25129 invoked from network); 24 Aug 2007 01:06:21 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-01.prod.mesa1.secureserver.net (64.202.189.90) with ESMTP; 24 Aug 2007 01:06:21 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 97B96100A0B;
	Fri, 24 Aug 2007 01:06:21 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5m328dHzEH21; Thu, 23 Aug 2007 21:06:21 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id E37361000A2;
	Thu, 23 Aug 2007 21:06:20 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id ADA587B51B; Thu, 23 Aug 2007 21:06:19 -0400 (EDT)
Mail-Followup-To: Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708240113360.32194@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56545>

On Fri, Aug 24, 2007 at 01:18:49AM +0100, Julian Phillips wrote:
> On Thu, 23 Aug 2007, Jing Xue wrote:
> 
> >So in my case I had to kind of cheat svnimport into thinking
> >'projectFoo' is the name of the "trunk" directory, and 'trunk' is the
> >actually project name. And I had to create 'dummytags' and
> >'dummybranches' at repoRoot level (following somebody else's tip found
> >on this list).
> 
> Ah, yes ... sorry.  I've actually ended up using a homebrew script for 
> parsing svn dump files and feeding git-fast-import for a number of 
> reasons, so I'm a bit rusty with svnimport, and never looked at multiple 
> projects in one repo anyway.  (One of which was that svnimport wasn't 
> creating a correct import actually - some files and directories were 
> simply missing).

That's... not good to hear about. I should probably look at svn dump as
well.

> I guess you've tried including projectFoo in the url?  Other than that, 
> perhaps git-svn may have better luck?

I tried that too but decided against it as it's relatively OK to lose
some ancient history, but messing up ongoing development due to any
possible issues in the git-svn layer would be quite different a story.
(and from what you just mentioned, that's not entirely a paranoia 8-)

Thanks.
-- 
Jing
