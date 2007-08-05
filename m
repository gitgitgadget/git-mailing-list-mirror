From: Dan Zwell <dzwell@gmail.com>
Subject: $GIT_DIR usage
Date: Sun, 05 Aug 2007 05:58:59 -0400
Message-ID: <46B59F63.8020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 12:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHdpa-0004W6-HC
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944AbXHEK7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757978AbXHEK7X
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:59:23 -0400
Received: from mailhub.lawrence.edu ([143.44.0.14]:35759 "EHLO lawrence.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756500AbXHEK7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 06:59:22 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2007 06:59:22 EDT
Received: from [69.140.46.21] (account zwelld HELO [192.168.2.3])
  by lawrence.edu (CommuniGate Pro SMTP 5.1.10)
  with ESMTPSA id 29971393 for git@vger.kernel.org; Sun, 05 Aug 2007 04:59:21 -0500
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54991>

Hi, I had a question about $GIT_DIR. That is to say, it doesn't seem to 
work. I am using Git 1.5.2.4. See the following: (all the commands I 
tried besides "git-init" failed).

$ export GIT_DIR="`pwd`/.git_public"
$ git init
warning: templates not found /usr/share//git-core/templates/
Initialized empty Git repository in /home/user/temp/.git_public/
$ echo > new_file
$ git add new_file
fatal: add must be run in a work tree
$ git commit -a
fatal: /usr/bin/git-commit cannot be used without a working tree.
$ git commit
fatal: /usr/bin/git-commit cannot be used without a working tree.
$

Is $GIT_DIR not meant to be used this way? Does it have a different 
purpose / use case, or is this just a bug?

Thanks,
Dan
