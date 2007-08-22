From: Jing Xue <jingxue@digizenstudio.com>
Subject: git-svnimport: what to do after -i?
Date: Wed, 22 Aug 2007 11:33:25 -0400
Message-ID: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 17:40:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INsJY-0007U2-Mu
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 17:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761819AbXHVPkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 11:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761994AbXHVPkI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 11:40:08 -0400
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:52407
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761767AbXHVPkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 11:40:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2007 11:40:06 EDT
Received: (qmail 2026 invoked from network); 22 Aug 2007 15:33:26 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 22 Aug 2007 15:33:25 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id E23661000A2
	for <git@vger.kernel.org>; Wed, 22 Aug 2007 15:33:25 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvBq+cpiYHpE for <git@vger.kernel.org>;
	Wed, 22 Aug 2007 11:33:25 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 2F69E100A0E; Wed, 22 Aug 2007 11:33:25 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Wed, 22 Aug 2007 11:33:25 -0400
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56392>


I am new to git. Last night I used "git svnimport -i" to import a svn  
project. It finished successfully. The only problem now is I can't  
seem to be able to checkout a working copy. In other words, I have a  
'projectFoo' directory, with only .git in it, but not any actual  
working files. "git-branch" shows two branches, master and origin.  
"git-checkout master" returns successfully, but does nothing.

I guess that's because I used -i without fully understanding what it  
implies. Is there any way to checkout a working directory?

Thanks in advance for any ideas.
-- 
Jing Xue
