From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Help with a tcl/tk gui thing..
Date: Wed, 1 Oct 2008 12:54:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 21:56:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7oO-0007JN-RR
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbYJATzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbYJATzS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:55:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36325 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753770AbYJATzR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2008 15:55:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m91JsjcT019834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 1 Oct 2008 12:54:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m91JsiTj001114
	for <git@vger.kernel.org>; Wed, 1 Oct 2008 12:54:44 -0700
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97260>


Ok, this is ridiculous, and has nothing to do with git apart from being 
hosted in it, but I thought I'd send out an email about it since the git 
community is the only one I know that does any GUI work at all...

I've got three girls, all wasting their time on their computer, and we set 
up this rule that they get to have a maximum of an hour of internet time 
each day. Of course, being the geek I am, I wrote a stupid time tracker 
for that purpose, and then totally forgot about it.

Until the harddisk in their computer broke down, and I had to re-install, 
and realized that I didn't have a copy of my stupid tracker sources 
anywhere. So I had to re-write it, and to make sure that I didn't lose it 
_again_, I put it in a git repo this time, and now have it on my desktop 
machine.

I _also_ have it on kernel.org, because I tend to change machines often 
enough that files get lost because I decide that switching machines is 
also a great way of doing "generational GC" on my home directory.

[ iow, I copy my old home directory as "old-home" when I switch machines, 
  and anything I didn't end up copying by the time I switch machines 
  again, just gets deleted. Very neat, and a great way to lose things that 
  you only care about every other year or so. ]

Whatever.

To make a long story short, I have a very small program that does all the 
tracking, and I have no problems with that. It doesn't have much of a 
admin interface, but I can do "echo 3600 > /var/log/tracker/celeste" to 
reset the time etc. _I_ have no need for pretty GUI's.

But I also have a UI that the kids can run to _see_ how much time they 
have left, so that getting thrown off the machine doesn't come as a total 
surprise. And yesterday Patricia asked why it has to be that ugly. And I 
had to admit that her dad is just not very good at UI's - and my 
re-implementation may in fact have been EVEN UGLIER than my original 
version. If that is even possible.

But hey, I'm not above impressing my kids with pretty bling if I can get 
somebody else who actually knows what they are doing to enhance my wish 
scripts to something reasonable.

Anybody?

The repository is at

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/tracker.git

if somebody knows how to make the text turn red when the end is near 
and/or make it have some nice graphical bar that fills up as time is about 
to expire.

And if nobody does, no worries. At least I tried. My kids can continue to 
watch ugly/small/monochrome fonts with just a count-down clock.

			Linus
