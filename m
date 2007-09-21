From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Fri, 21 Sep 2007 22:42:51 +0200
Message-ID: <200709212242.53131.robin.rosenberg.lists@dewire.com>
References: <loom.20070920T010842-272@post.gmane.org> <200709211915.35642.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709212121330.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>, Eric Blake <ebb9@byu.net>,
	m4-patches@gnu.org, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYpJS-0005AB-TG
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 22:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbXIUUk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 16:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757485AbXIUUkz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 16:40:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3041 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757253AbXIUUkz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 16:40:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1B2E680288E;
	Fri, 21 Sep 2007 22:32:42 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30214-02; Fri, 21 Sep 2007 22:32:41 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B0A60802868;
	Fri, 21 Sep 2007 22:32:41 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0709212121330.28395@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58877>

fredag 21 september 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Fri, 21 Sep 2007, Robin Rosenberg wrote:
> 
> > fredag 21 september 2007 skrev Linus Torvalds:
> > > 
> > > The big advantage of git-cvsimport is that it can do incremental 
> > > imports, which I don't think the other methods do. But if there is any 
> > > choice at all, and especially if you're not that interested in the 
> > > incremental feature (ie you can cut over to git, and perhaps use 
> > > git-cvsserver to "supprt" CVS users) the other CVS importers are 
> > > likely to be much better.
> > 
> > fromcvs does incremental import and it's very fast and uses much less 
> > memory than cvsimport. It needs the rcs files however and will not 
> > convert non-branch tags.
> 
> Plus you have to install Ruby.  Just wanted people to know.

You don't like Ruby, do you? It worth it, really.

-- robin
