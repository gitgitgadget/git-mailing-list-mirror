From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: pushing fails - WHY?
Date: Sun, 1 Oct 2006 11:38:06 +0100
Message-ID: <200610011138.06823.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 01 12:38:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTyhw-000493-3T
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 12:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWJAKiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWJAKiA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 06:38:00 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:55751
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1750788AbWJAKiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 06:38:00 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GTyhr-0006w4-4F
	for git@vger.kernel.org; Sun, 01 Oct 2006 11:37:59 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28176>

I am just coming back to repeat the setting up of my public git repositories 
after loosing them in a disk crash a little while ago.

The first repository I am setting up is called akclib on server roo.home

so in /var/lib/git on that machine I did

mkdir akclib.git
GIT_DIR akclib.git git init-db --shared

Back on my workstation where my master repository resides

~/dev/akcmoney

I have a .git/remotes/public file which contains

URL:roo.home:/var/lib/git/akclib.git
Push:master

BUT WHEN I attempt to push -  thus

alan@kanger:~/dev/akclib[master]$ git push public
fatal: remote 'public' has no URL

It fails.  But I don't understand why. Can someone point me at what I am doing 
wrong.

(git is version 1.4.2.1 on the workstation, 1.4.1 on the server)

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
