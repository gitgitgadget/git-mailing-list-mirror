From: Sven Herzberg <sven@imendio.com>
Subject: git submodules and diffing
Date: Fri, 9 Nov 2007 22:19:25 +0100
Message-ID: <4D079E0B-D6FB-4FBA-B449-2EFBFD5A5DE4@imendio.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 22:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqboG-0007Im-C7
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 22:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbXKIVyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 16:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbXKIVyZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 16:54:25 -0500
Received: from holken.mikan.net ([88.131.94.251]:34810 "EHLO holken.mikan.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbXKIVyY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 16:54:24 -0500
X-Greylist: delayed 2110 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2007 16:54:24 EST
Received: from localhost (localhost [127.0.0.1])
	by holken.mikan.net (Postfix) with ESMTP id EEF371459D
	for <git@vger.kernel.org>; Fri,  9 Nov 2007 22:19:08 +0100 (CET)
Received: from holken.mikan.net ([127.0.0.1])
	by localhost (holken.mikan.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15024-08 for <git@vger.kernel.org>;
	Fri, 9 Nov 2007 22:19:05 +0100 (CET)
Received: from [192.168.2.108] (p548FC53A.dip.t-dialin.net [84.143.197.58])
	by holken.mikan.net (Postfix) with ESMTP id 9B7F711E89
	for <git@vger.kernel.org>; Fri,  9 Nov 2007 22:19:05 +0100 (CET)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: Debian amavisd-new at holken.mikan.net
X-Spam-Status: No, score=-97.611 tagged_above=-999 required=4
	tests=[AWL=0.301, RCVD_IN_SORBS_DUL=2.088, USER_IN_WHITELIST=-100]
X-Spam-Score: -97.611
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64263>

Hi,

when I started working with git submodules, I realized that git-diff  
only lists the revision ids of a submodule if it has changed. I have  
created a repository which includes a diff command for git-submodule,  
so you can use it like "gut submodule diff <modules...>"

I pushed my git tree at git://git.imendio.com/sven/git.git

Feel free to look into the changes and request improvements or merge  
it into your tree.

Regards,
   Sven

PS: Please CC me, I'm not on this list
