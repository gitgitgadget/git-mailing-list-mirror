From: Pedro Melo <melo@simplicidade.org>
Subject: git-svn capabilities
Date: Sun, 9 Dec 2007 08:20:02 +0000
Message-ID: <DB0B4F17-9E06-4C28-933E-FDEF9BAD6539@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 09:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1HVD-0005K1-Ub
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 09:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXLII0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 03:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXLII0r
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 03:26:47 -0500
Received: from mail.sl.pt ([212.55.140.13]:45395 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751410AbXLII0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 03:26:46 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2007 03:26:46 EST
Received: (qmail 15359 invoked from network); 9 Dec 2007 08:20:03 -0000
X-Virus-Status: Clean (0.01067 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00007 seconds / 0.05786 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.68]) (melo@[85.240.106.211])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 9 Dec 2007 08:20:03 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.106.211 as permitted sender)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67605>

Hi,

I've been following along the gcc/git thread with interest and I've  
used Harvey Harrison recipe

http://article.gmane.org/gmane.comp.version-control.git/67253

with success on several svn repos.

One thing that I'm not sure yet if it is possible to do is this:

can I have a single central git repo that tracks the svn repo, allow  
several developers to use clone to copy that repo, and each one of  
them (after proper manual configuration) uses dcommit to push back to  
svn?

All the recipes so far assume that each developer has to go through  
the initial git-svn fetch and have a copy of the entire SVN repo, and  
that seems wasteful to me.

Thanks,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
