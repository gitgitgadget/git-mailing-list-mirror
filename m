From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: MinGW port - initial work uploaded
Date: Fri, 19 Jan 2007 21:48:20 +0100
Message-ID: <200701192148.20206.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 19 22:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8172-0003Mq-DJ
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 22:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXASVRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 16:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbXASVRY
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 16:17:24 -0500
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:36289 "EHLO
	smtp1.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbXASVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 16:17:24 -0500
X-Greylist: delayed 1739 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 16:17:23 EST
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP id 5CF2B339E3
	for <git@vger.kernel.org>; Fri, 19 Jan 2007 21:48:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id F2B1D121C6
	for <git@vger.kernel.org>; Fri, 19 Jan 2007 21:48:20 +0100 (CET)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37202>

I've been working on a MinGW port for some time now. I've pushed out what I 
have so far to a git.git fork at repo.or.cz. For details on how and what to 
clone, please look at the top of

http://repo.or.cz/w/git/mingw.git

Thanks go to Johannes Schindelin for his initial work, which gave me quite a 
quick-start.

Status
------
So far I've used the tools only to run the test suite. According to that, all 
tools that are needed to manipulate a repository locally work.

clone, fetch, push does not work yet.

Contributions
-------------
If you want to contribute, please consider using the mob branch in this 
repository. That branch is publically writable. Since I assume that 
contributions will not be too frequent, it should be ok that you push your 
patches there (without pulling it first), then notify me, and I download them 
before someone else overwrites them.

-- Hannes
