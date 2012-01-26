From: Alan Edwards <kae@xnet.com>
Subject: How to reorganize git tree
Date: Thu, 26 Jan 2012 13:35:05 -0500
Message-ID: <20120126133505.it34vehs0044o848@webmail.xnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 19:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqUMr-0005mH-7z
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 19:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab2AZSsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 13:48:11 -0500
Received: from quake1.xnet.com ([198.147.221.67]:62430 "EHLO quake1.xnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab2AZSsK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 13:48:10 -0500
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jan 2012 13:48:10 EST
Received: from microburst3.xnet.com (microburst3.xnet.com [198.147.221.119])
	by quake1.xnet.com (Postfix) with ESMTP id 848A4318
	for <git@vger.kernel.org>; Thu, 26 Jan 2012 12:35:05 -0600 (CST)
Received: by microburst3.xnet.com (Postfix, from userid 48)
	id 75C3AFEA4A; Thu, 26 Jan 2012 12:35:05 -0600 (CST)
Received: from proxy32.messagelabs.net (proxy32.messagelabs.net
	[216.82.251.229]) by webmail.xnet.com (Horde MIME library) with HTTP; Thu,
	26 Jan 2012 13:35:05 -0500
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189158>

I was new to git about a year ago and created a git directory  
structure containing several different projects like:

/source/web_server1/project1
/source/web_server1/project2
/source/web_server1/project3
/source/web_server1/project4
/source/web_server2/project5
/source/web_server2/project6

where my massive .git repository is:

/source/.git (containing all the projects on all the web servers....  
Oops!) There seems to be lots of "loose objects".

Somewhere along the way I figured out that this probably wasn't a good  
idea and I ended up making a git repository under one of the projects:

/source/web_server1/project4/.git

Not sure if that was the best decision either. I've already checked in  
changes to the /source/web_server1/project4/.git repository for  
project4 and I've checked in changes to project2 into the /source/.git  
repository.

Of course I now realize the errors of my way and would like to restructure.

the only changes that have been checked into the big upper level  
repository are changes for project2.  Is it possible to carve out  
those changes from the /source/.git repository and create a new  
/source/web_server1/project2/.git repository?

Maybe the way to deal with this is to remove the other directories  
from the /source/.git repository and leave project2 there.

Any one have any suggestions?

I'm not sure if I'm posting this in the right place (I'm at work and  
they don't allow access to many places and I don't have access to the  
news group).

Thanks!

-Alan Edwards
  kae at xnet dot com (my home email address)
