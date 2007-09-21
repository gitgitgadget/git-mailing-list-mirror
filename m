From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Fri, 21 Sep 2007 19:15:34 +0200
Message-ID: <200709211915.35642.robin.rosenberg.lists@dewire.com>
References: <loom.20070920T010842-272@post.gmane.org> <8D5EA3F4-9642-4604-963E-838D03650FBC@zib.de> <alpine.LFD.0.999.0709210840190.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, Eric Blake <ebb9@byu.net>,
	m4-patches@gnu.org, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYm4o-0000VA-P1
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 19:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbXIURNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 13:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbXIURNh
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 13:13:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29600 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbXIURNg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 13:13:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1ABAE80288E;
	Fri, 21 Sep 2007 19:05:24 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27644-10; Fri, 21 Sep 2007 19:05:23 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 97255802664;
	Fri, 21 Sep 2007 19:05:23 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.999.0709210840190.16478@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58862>

fredag 21 september 2007 skrev Linus Torvalds:
> 
> On Fri, 21 Sep 2007, Steffen Prohaska wrote:
> > 
> > Hard to say. The best is to avoid git-cvsimport if you need
> > to import branches correctly.
> 
> Yes. git-cvsimport started out as a pretty quick hack, and depends on 
> cvsps which is another fairly hacky thing.
> 
> The big advantage of git-cvsimport is that it can do incremental imports, 
> which I don't think the other methods do. But if there is any choice at 
> all, and especially if you're not that interested in the incremental 
> feature (ie you can cut over to git, and perhaps use git-cvsserver to 
> "supprt" CVS users) the other CVS importers are likely to be much better.

fromcvs does incremental import and it's very fast and uses much less memory 
than cvsimport. It needs the rcs files however and will not convert 
non-branch tags.

-- robin
