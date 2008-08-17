From: Jens Neuhalfen <JensNeuhalfen@gmx.de>
Subject: SeLinux integration
Date: Sun, 17 Aug 2008 12:44:22 +0200
Message-ID: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 12:48:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUfnr-00020H-Fr
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 12:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYHQKn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 06:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYHQKn7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 06:43:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:56282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbYHQKn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 06:43:59 -0400
Received: (qmail invoked by alias); 17 Aug 2008 10:43:56 -0000
Received: from static-87-79-238-78.netcologne.de (EHLO [172.20.0.119]) [87.79.238.78]
  by mail.gmx.net (mp061) with SMTP; 17 Aug 2008 12:43:56 +0200
X-Authenticated: #1271396
X-Provags-ID: V01U2FsdGVkX1+2qYolux622U7+1ElsB0ohnorcpOwPsMRqLrqCCN
	IqtQONmDB9Q+3m
X-Mailer: Apple Mail (2.928.1)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92597>

Hi,

I  wrote an SeLinux policy and an init.d script  for the git-daemon  
and now seek for comments and improvements.

The scripts were tested on my Centos 5.2 box  and an older version had  
been tested on FC 9.

  Features:
    * multiple configuration files for the init.d script
    * selinux support for git daemon
    * seboolean (git_daemon_update_repository) that forces git-daemon  
into strict read-only mode when set to false

TODO
  * The policy and the accompanying init.d script still lack  
documentation
  * see selinux/BUGS and initd/BUGS

Feel free to pull from my repository and comment. If the everything is  
'good' I will send patches to the list, so that SeLinux support can be  
integrated into the main repository.


  git://www.neuhalfen.name/git-selinux.git


Jens
