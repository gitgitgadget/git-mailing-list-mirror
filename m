From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 14:42:29 +0100
Message-ID: <200504221442.29488.rhys@rhyshardwick.co.uk>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 22 15:40:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyM8-0007Oj-4R
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVDVNmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVDVNmf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:42:35 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:35459 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261733AbVDVNmb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:42:31 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp004.mail.ukl.yahoo.com with SMTP; 22 Apr 2005 13:42:30 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DOyQQ-0003dc-6X
	for git@vger.kernel.org; Fri, 22 Apr 2005 14:42:30 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hey there,

I am trying to pull the latest repository of the linux-2.6 git from Linus' 
rsync mirror.

Here is the shell:

===========

rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh 
rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
defaulting to local storage area
gitpull.sh: unknown remote
gitinit.sh: pull failed
rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh 
www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
defaulting to local storage area
gitpull.sh: unknown remote
gitinit.sh: pull failed
rhys@metatron:~/repo/linux-2.6.repo$   

=============

Any idea why this is not working?

Thanks for any help,

Rhys


