From: Pedro Melo <melo@simplicidade.org>
Subject: Difference between git-clone --bare and git-push --all to empty repo
Date: Fri, 13 Jun 2008 12:23:35 +0100
Message-ID: <7D042A31-9CC8-4740-8185-7165AEF6E0DF@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K77Ux-0001Jb-Ih
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 13:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbYFMLaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 07:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbYFMLaV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 07:30:21 -0400
Received: from mail.sl.pt ([212.55.140.13]:47088 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752224AbYFMLaU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 07:30:20 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jun 2008 07:30:20 EDT
Received: (qmail 6875 invoked from network); 13 Jun 2008 11:23:36 -0000
Received: from unknown (HELO [10.0.0.5]) (melo@[213.205.86.9])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 13 Jun 2008 11:23:36 -0000
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84867>

Hi,

I have a private repository on my laptop and for backup purposes  
only, I created a remote repository to push to.

I created the remote repo in two ways:

1. git-clone --bare

I used git-clone --bare to create a bare repository with a copy of my  
work and rsync'ed that to the remote server

2. git init a bare repo and git push --all

I created a empty bare repository with

    mkdir project_backup
    GIT_DIR=project_backup git init

and then pushed my work to it:

   cd project
   git push --all ../project_backup

and rsync'ed the project_backup directory.

I see the same number of objects and the same branches on both bare  
repositories, but the first one created with git-clone uses a lot  
more space, even after git-repack -d -a on both.

I'm still learning the internals of git, but I could not find any  
explanation for this. Care to enlighten me?

Thanks in advance,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
