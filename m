From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-clone fails with out of memory,malloc failed7
Date: Tue, 12 Feb 2008 12:23:59 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802121218280.2732@xanadu.home>
References: <6bc632150802120757r5dbeee6bmed9ccde4ca6f40d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: pradeep singh rautela <rautelap@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOys8-0003gA-Lg
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761685AbYBLRYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761622AbYBLRYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:24:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63294 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761607AbYBLRYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 12:24:08 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW4005YMYZZ0860@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 12:24:00 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <6bc632150802120757r5dbeee6bmed9ccde4ca6f40d2@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73677>

On Tue, 12 Feb 2008, pradeep singh rautela wrote:

> Hi All,
> 
> I compiled a fresh git 1.5.4 and tried to clone Ingo's kgdb-lite tree.
> I got rather strange out of memory. malloc failed7 error.
> 
> I am using a 32 bit kernel on a pentium D processor with 1 GB of ram.
> 
> Is this a git issue or something else?
> Can someone help me in telling me which is the correct place to report this?

This is the right place.

> Better if this is a known issue ?

It is not.

> isn't 1 GB of RAM enough for git???

It is plenty sufficient with the repository you tried it on.

> luser@helvella:/opt/repo/archive$ sudo git-clone
> git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-kgdb.git
> [sudo] password for luser:

Why do you use sudo to run git?

> Initialized empty Git repository in /opt/repo/archive/linux-2.6-kgdb/.git/
> remote: Counting objects: 712950, done.
> remote: Compressing objects: 100% (124251/124251), done.
> remote: Total 712950 (delta 591747), reused 708812 (delta 587713)
> Receiving objects: 100% (712950/712950), 173.74 MiB | 40 KiB/s, done.
> fatal: Out of memory, malloc failed7)
> fatal: index-pack failed

I just cloned the above repository with Git v1.5.4 with no problem at 
all, and index-pack never used more than 52 megs of actual memory.

Puzzled.


Nicolas
