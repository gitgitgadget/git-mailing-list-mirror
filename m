From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH 0/6 RFC] Series to correct xutils incomplete line 
 handling.
Date: Fri, 21 Aug 2009 23:23:18 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908212307530.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS>  <alpine.DEB.2.00.0908191713070.2012@GWPortableVCS>  <alpine.DEB.2.00.0908211228000.2012@GWPortableVCS> <81b0412b0908211516l4db79249h180e50ffb8e2c1ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mei9A-0008MM-12
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZHVEXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 00:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbZHVEXp
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:23:45 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:41002 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZHVEXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 00:23:45 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mei8n-0007RQ-Ac; Fri, 21 Aug 2009 23:23:45 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <81b0412b0908211516l4db79249h180e50ffb8e2c1ab@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126783>

Alex Riesen (raa.lkml@gmail.com) wrote on Aug 21, 2009:

> On Fri, Aug 21, 2009 at 19:39, Thell Fowler<git@tbfowler.name> wrote:
> > What is _REALLY_ odd is that it didn't make any tests fail in the test
> > dir using master, next, and pu.
> 
> The test suite has a very good coverage, but it surely is not complete.
> 

Well, two lessons learned...
1) Don't do isolated tests and count on the bundled tests to catch the 
corner cases.
2) Write more tests.

> > Perhaps someone can explain what I did wrong when testing?
> >
> > git checkout master
> > make -s clean && make -s all && make -s install && cd t && make
> 
> This should have worked. Although I prefer just:
> 
>   $ make -j4 && make test -j16
> 

Good to know I was on the right track.  Thanks.
-- 
Thell
