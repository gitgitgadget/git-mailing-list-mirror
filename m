From: Pedro Melo <melo@simplicidade.org>
Subject: git-svn: network error while git-svn dcommit
Date: Mon, 14 Jan 2008 13:20:51 +0000
Message-ID: <75A83473-664E-4CC8-97ED-119D18F17F76@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 14:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEPFV-0005Im-Ew
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 14:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbYANNUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 08:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbYANNUh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 08:20:37 -0500
Received: from mail.sl.pt ([212.55.140.13]:33248 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750842AbYANNUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 08:20:36 -0500
Received: (qmail 9760 invoked from network); 14 Jan 2008 13:20:32 -0000
X-Virus-Status: Clean (0.01005 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00007 seconds / 0.05883 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [10.0.0.5]) (melo@[213.205.66.71])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 14 Jan 2008 13:20:32 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 213.205.66.71 as permitted sender)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70458>

Hi,

I was doing a git-svn dcommit (git-1.5.4-rc2)  and the network to the  
svn server died on me.

Network connection closed unexpectedly: Connection closed  
unexpectedly at /usr/local/git/bin/git-svn line 450

If I try again, I get a warning about a dirty index.

Cannot dcommit with a dirty index.  Commit your changes first, or  
stash them with `git stash'.
  at /usr/local/git/bin/git-svn line 406

What's the best way to recover from this?

Thanks,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
