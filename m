From: Christoph Buchner <bilderbuchi@phononoia.at>
Subject: Git and Large Binaries: A Proposed Solution - current situation?
Date: Tue, 08 Jan 2013 23:51:36 +0100
Message-ID: <50ECA2F8.3030703@phononoia.at>
Reply-To: bilderbuchi@phononoia.at
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 23:58:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsi7M-0003a0-6n
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 23:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab3AHW5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 17:57:34 -0500
Received: from dd24126.kasserver.com ([85.13.143.154]:60882 "EHLO
	dd24126.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141Ab3AHW5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 17:57:32 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2013 17:57:32 EST
Received: from [192.168.1.4] (80-114-59-253.static.vdsl.surfer.at [84.114.59.253])
	by dd24126.kasserver.com (Postfix) with ESMTPSA id 79EE5FC0269
	for <git@vger.kernel.org>; Tue,  8 Jan 2013 23:51:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213012>

Hello git devs!

We are currently trying to deal with the large-binaries-in-git problem, 
and I found this conversation from 2011 on this mailing list: 
http://git.661346.n2.nabble.com/Fwd-Git-and-Large-Binaries-A-Proposed-Solution-td5948908.html 

I was also motivated by finding this git GSoC 2012 proposal:
> Git copies and stores every object from a remote repository when 
> cloning. For large objects, this can consume a lot of bandwidth and 
> disk space, especially for older versions of large objects which are 
> unlikely to be accessed. Git could learn a new alternate repository 
> format where these seldom-used objects are stored on a remote server 
> and only accessed on demand.

What both this proposal and the email discussion proposed (among 
others), i.e. storing large binaries outside of git, and especially 
fetching them from somewhere else only on demand, sounds like it would 
solve our problem pretty well.

My question (I asked first in the git-devel IRC channel) is if there was 
any more activity on this, and/or if this is on a roadmap or similar?
sparse clone sounds like something similar, but this has been pushed far 
back, right?

I am aware of external mechanisms (e.g. git-annex, git-media), but we 
would prefer something git-internal: Our userbase is heavily 
cross-platform (including windows), but there's no windows support for 
git-annex (which otherwise sounds like we could use it).


thank you for any input,
all the best,
Christoph
