From: Yakup Akbay <yakbay@ubicom.com>
Subject: How can I remove a remote branch from local repo that is removed
 at the server side
Date: Tue, 12 May 2009 09:56:51 +0300
Message-ID: <4A091DB3.4070509@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 09:16:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3mE8-00077J-A8
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 09:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbZELHQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 03:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757143AbZELHQY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 03:16:24 -0400
Received: from 66.237.77.99.ptr.us.xo.net ([66.237.77.99]:38020 "EHLO
	cuda.ubicom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbZELHQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 03:16:23 -0400
X-Greylist: delayed 1022 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 03:16:23 EDT
X-ASG-Debug-ID: 1242111562-792f00000000-QuoKaX
X-Barracuda-URL: http://172.18.1.15:80/cgi-bin/mark.cgi
Received: from stork.scenix.com (localhost [127.0.0.1])
	by cuda.ubicom.com (Spam Firewall) with ESMTP id B7FC37C288
	for <git@vger.kernel.org>; Mon, 11 May 2009 23:59:22 -0700 (PDT)
Received: from stork.scenix.com ([10.10.10.30]) by cuda.ubicom.com with ESMTP id WhQKB11nkUL6pq1z for <git@vger.kernel.org>; Mon, 11 May 2009 23:59:22 -0700 (PDT)
X-Barracuda-Envelope-From: yakbay@ubicom.com
Received: from [172.18.200.101] ([172.18.200.101]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 May 2009 23:55:26 -0700
X-Barracuda-BBL-IP: 172.18.200.101
X-Barracuda-RBL-IP: 172.18.200.101
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
X-ASG-Orig-Subj: How can I remove a remote branch from local repo that is removed
 at the server side
X-OriginalArrivalTime: 12 May 2009 06:55:26.0812 (UTC) FILETIME=[A14E29C0:01C9D2CE]
X-Barracuda-Connect: UNKNOWN[10.10.10.30]
X-Barracuda-Start-Time: 1242111562
X-Barracuda-Virus-Scanned: by Barracuda Spam Firewall at ubicom.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118875>

Hi,

consider the following situation:

    adg@adghp:~/myrepo$ git branch -a
    * master
      origin/HEAD
      origin/master
      origin/work

I want to remove origin/work from my local repository which is no more 
existing at the origin. git fetch (or pull) does not help either. 
However, it disappears when I remove the following line in 
.git/packed-refs file:

    021a032317425b136b5430c7dead94328996b9d0 refs/remotes/origin/work

Is there command line version to do it?


Regards,
Yakup


Ubicom's HQ in Sunnyvale has Moved!
Our New Address is:
195 Baypointe Parkway
San Jose, CA 95134
(408)433-3330 - Main#
(408)433-3339 - Fax#
www.ubicom.com
