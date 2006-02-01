From: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: How to use git for Linux kernel development ?
Date: Wed, 1 Feb 2006 12:38:44 +0100
Organization: Technotrade
Message-ID: <200602011238.44188.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 01 12:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GK3-0003rk-Lh
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBALit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWBALit
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:38:49 -0500
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:35715 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932117AbWBALis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:38:48 -0500
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
        by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id k11BciAK013661
        for <git@vger.kernel.org>; Wed, 1 Feb 2006 12:38:45 +0100
        (envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be [194.78.198.49])
        by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id k11Bch9Y013648
        for <git@vger.kernel.org>; Wed, 1 Feb 2006 12:38:43 +0100
        (envelope-from <laurent.pinchart@tbox.biz>)
Received: from pclaurent.technotrade (192.168.1.42 [192.168.1.42]) by servernt.technotrade with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id D96GA34Z; Wed, 1 Feb 2006 12:38:42 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15402>

Hi everybody,

my company decided to port the Linux kernel to custom hardware. As we need a 
repository for the sources, I thought I would give git a try. The man pages 
and tutorials are quite helpful to understand the git commands, but none of 
the documentation I found has been able to answer my (not so simple) 
question : given my use cases, how do I use git ?

Here are the use cases.

I need to port the Linux kernel to custom hardware. This means fixing bugs in 
the kernel, adding new features and new device drivers. Some of the 
modifications I make (bug fixes) will be pushed upstream by myself, some 
others by other developers (for instance I will apply patches found on 
sourceforge to support our non-UHCI/OHCI USB host controller, and I don't 
want to push code for which I'm not the maintainer upstream), and some device 
drivers will not be pushed at all.

I will base my work on the Linux kernel 2.6.15, which is the most recent 
release that has the features I need (2.6.16-rc1 broke serial port support on 
Freescale PowerQuickII processors). I plan to stay up-to-date with the main 
kernel repository by either fixing the problems in future releases or waiting 
for someone to fix them, depending on how much time I can spend on the 
project.

I have no idea how to layout my git repository to work on day-to-day 
development. I need to :

- commit bug fixes, external patches and internal modifications to a branch 
(or possibly on separate branches depending on what I commit if needed). The 
work will be based on Linux kernel 2.6.15 but I'd like to stay up-to-date 
with the master repository as much as possible.
- push bug fixes upstream by creating a patchset and submitting it by email.
- pull changes from upstream and merge them in my various branches when the 
upstream versions become stable enough.
- keep branches for all the versions shipped to the customers for bug fixes.

I'm the only developer working on the Linux kernel in my company, but that 
might change in a few months, so other developers will need to use git as 
well.

Is git able to accomodate my needs ? I've been trying to setup a git 
repository with a few branches over the last two days, but I always had to 
throw everything away and start back from zero. I haven't been able to figure 
out which branches I should create and how I should use them.

Thanks in advance for your help, and I hope I'm not asking too much. If really 
unable to use git, I'll go for SVN (or SourceSafe as that's what my company 
used until today, but I'd like to avoid it) even if I feel it will make 
keeping up-to-date with upstream more difficult.

Laurent Pinchart
