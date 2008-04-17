From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Confused about "ident" filter
Date: Thu, 17 Apr 2008 08:15:42 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0804170812230.7970@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 09:16:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmOMA-0001He-39
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 09:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbYDQHPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 03:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbYDQHPp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 03:15:45 -0400
Received: from ds9.cixit.se ([193.15.169.228]:42355 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbYDQHPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 03:15:44 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3H7FgBs009962
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Apr 2008 09:15:42 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3H7FgUI009957;
	Thu, 17 Apr 2008 09:15:42 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 17 Apr 2008 09:15:42 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79772>

Hi!

While convincing my employer to convert to Git, I've ran into the old
RCS keyword expansion problem again. They have files that they need to
export to a customer, without revision history, but they need to embed
an identifier that can tell them which version of the file it was.

So, I tried setting up a .gitattributes file:

   * ident

and a simple test perl script that would show me the ident:

   #!/usr/bin/perl
   print 'I am $Id$', "\n";

but I cannot figure out how to get it to actually expand the $Id$. I
tried doing "git checkout test.perl", I tried "git clone" to get a new
copy of the repository, but still it showed only "$Id$".

I found that "git archive" *does* work.

-- 
\\// Peter - http://www.softwolves.pp.se/
