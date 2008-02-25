From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Mon, 25 Feb 2008 18:32:06 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251826380.19024@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <7v4pcgcimw.fsf@gitster.siamese.dyndns.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <87ablod7ed.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:32:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmoQ-00084i-R8
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbYBYXcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbYBYXcJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:32:09 -0500
Received: from iabervon.org ([66.92.72.58]:48232 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbYBYXcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:32:08 -0500
Received: (qmail 22174 invoked by uid 1000); 25 Feb 2008 23:32:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 23:32:06 -0000
In-Reply-To: <87ablod7ed.fsf@mid.deneb.enyo.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75091>

On Mon, 25 Feb 2008, Florian Weimer wrote:

> * Len Brown:
> 
> > [lenb@d975xbx2 linus (master)]$ git pull
> > remote: Counting objects: 649, done.
> > remote: Compressing objects: 100% (106/106), done.
> > remote: Total 513 (delta 417), reused 503 (delta 407)
> > Receiving objects: 100% (513/513), 116.67 KiB, done.
> > Resolving deltas: 100% (417/417), completed with 103 local objects.
> > warning: no common commits
> > remote: Counting objects: 710725, done.
> > remote: Compressing objects: 100% (125738/125738), done.
> > remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
> > Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
> > Resolving deltas: 100% (589584/589584), done.
> >>From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> 
> Same here, but on a slow DSL line, so I had to hit ^C:
> 
> fw@deneb:~/src/linux/linux-2.6$ git pull
> remote: Counting objects: 94176, done.
> remote: Compressing objects: 100% (17486/17486), done.
> remote: Total 83287 (delta 70429), reused 78218 (delta 65712)
> Receiving objects: 100% (83287/83287), 18.66 MiB | 478 KiB/s, done.
> Resolving deltas: 100% (70429/70429), completed with 7457 local objects.
> warning: no common commits
> remote: Counting objects: 53267
> ^C

Can you try making backups before pulling and see if you can get a 
reproducable case? I haven't been able to arrange to have it happen to me, 
and once it happens, it's changed the state of the repository such that it 
won't happen again immediately. I found something suspicious at some 
point, and suggested a possible fix, but it's impossible to tell if it's 
actually resolved without a test case.

	-Daniel
*This .sig left intentionally blank*
