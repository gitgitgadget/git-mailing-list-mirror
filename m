From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Peculiar behavior of git 1.5.6
Date: Thu, 04 Sep 2008 00:43:55 -0500
Message-ID: <48BF759B.9090309@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 07:49:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb7iv-0005dj-5E
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 07:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYIDFsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 01:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbYIDFse
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 01:48:34 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:57377 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100AbYIDFse (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2008 01:48:34 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Sep 2008 01:48:34 EDT
Received: from [192.168.1.111] (cpe-69-76-241-187.kc.res.rr.com[69.76.241.187])
          by worldnet.att.net (mtiwmhc11) with ESMTP
          id <20080904054331111004uka8e>; Thu, 4 Sep 2008 05:43:31 +0000
User-Agent: Thunderbird 2.0.0.12 (X11/20071114)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94898>

On one of my systems, I found strange behavior for git-1.5.6.GIT. On 
the first pull of the linux-2.6 tree, I got a message that one file 
was not uptodate. When I investigated any possible differences with 
git-diff, there were none. A subsequent git-pull worked fine. I lost 
the console output for linux-2.6, but the same thing happened for 
Linville's wireless-testing, as shown below:

finger@sonylap:~/wireless-testing> git --version
git version 1.5.6.GIT
finger@sonylap:~/wireless-testing> git pull
error: Entry 'drivers/bluetooth/bt3c_cs.c' not uptodate. Cannot merge.
fatal: merging of trees 294e21019bac11cb782e8d1893d02ce98ed816a4 and 
810d24221c9c532475af90d1b7ba9ca381dc3696 failed
Merge with strategy recursive failed.
finger@sonylap:~/wireless-testing> git diff > tmp
finger@sonylap:~/wireless-testing> cat tmp
finger@sonylap:~/wireless-testing> git pull
Removed Documentation/usb/auerswald.txt
Auto-merged MAINTAINERS
...

Is this a bug in git, an incompatibility between my version and that 
of the server at kernel.org, or something else?

Thanks,

Larry
