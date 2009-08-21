From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH 0/6 RFC] Series to correct xutils incomplete line
 handling.
Date: Fri, 21 Aug 2009 12:39:37 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908211228000.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <alpine.DEB.2.00.0908191713070.2012@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeY6X-0007df-98
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 19:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZHURkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 13:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbZHURkF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 13:40:05 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:40881 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbZHURkC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 13:40:02 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MeY5r-0006Ej-Jz; Fri, 21 Aug 2009 12:40:03 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <alpine.DEB.2.00.0908191713070.2012@GWPortableVCS>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126738>

Thell Fowler (git@tbfowler.name) wrote on Aug 19, 2009:

>  t/t4015-diff-trailing-whitespace.sh |   95 +++++++++++++++++++++++++++++++++++
>  t/t4015-diff-whitespace.sh          |   33 ++++++++++++
>  xdiff/xutils.c                      |   20 ++++----
>  3 files changed, 138 insertions(+), 10 deletions(-)
>  create mode 100755 t/t4015-diff-trailing-whitespace.sh

Don't bother trying this series.  I tried it out on live data today and it 
does not work.  It actually caused regression in the diffs for the 
conversion project I'm working on.

What is _REALLY_ odd is that it didn't make any tests fail in the test 
dir using master, next, and pu.


Perhaps someone can explain what I did wrong when testing?

git checkout master
make -s clean && make -s all && make -s install && cd t && make

I really did do over 9 hours of testing using the test dir.  First with 
just the branches with no modification, then with the modified 
t4015-diff-whitespace.sh, then with the xutils.c patch.  And this was on 
each branch at about 40 minutes per run through.

-- 
Thell
