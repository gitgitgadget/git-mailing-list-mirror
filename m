From: Raimund Bauer <ray007@gmx.net>
Subject: RE: Problems with git cvsimport
Date: Sat, 03 Mar 2007 13:31:37 +0100
Message-ID: <1172925097.11109.25.camel@localhost>
References: <000c01c75b3c$31f91000$0b0aa8c0@abf.local>
	 <Pine.LNX.4.63.0703030129220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 13:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNTOo-00070x-24
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 13:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965512AbXCCMbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 07:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965540AbXCCMbj
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 07:31:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:60882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965512AbXCCMbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 07:31:38 -0500
Received: (qmail invoked by alias); 03 Mar 2007 12:31:36 -0000
X-Provags-ID: V01U2FsdGVkX19nRxQNp/Bnk1Pk0KNVB0c4krGOSYjBLWxay/jlvN
	nD4s4NwyLECwif
In-Reply-To: <Pine.LNX.4.63.0703030129220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41290>

On Sat, 2007-03-03 at 01:30 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Feb 2007, Raimund Bauer wrote:
> 
> > $ git cvsimport -d :pserver:ray007@cvs.drupal.org:/cvs/drupal-contrib -C
> > localizer -a contributions/modules/localizer
> > Initialized empty Git repository in /home/ray/drupal/modules/localizer/.git/
> > file 'CHANGELOG.txt; pre_rev:INITIAL; post_rev:1.1; dead:0; branch_point:0
> > ' not found in hash
> > fatal: refs/heads/origin: not a valid SHA1
> > fatal: master: not a valid SHA1
> 
> This looks to me as if you did not cleanup after failed attempts. I would 
> try this in a fresh directory. Actually, I did, and I think it worked, 

I always tried with a new directory, that's not the reason.

I've just tried it out on my home-box, which is a ubuntu edgy x86
installation, and git-cvsimport seems to work quite fine here.

On our server, which is a suse 9.3 amd64 installation (with the latest
suse updates for that version), I just can't get it to run. Currently I
wonder how I got _any_ git-cvsimport to work there. Still the same error
256 ...

How do I find out the minimum-version of tools I need to use
git-cvsimport? I already know about cvsps and did install a current
version there, but there seem to be some more dependencies ...
Or could it be a 64-bit issue somewhere?

'make test' says everything is fine.

If you can point me in the some direction on how to debug this, I'll
give it a try, currently I have no clue where to start.

> too... Latest commit is
> 
> commit 8fc1b3decbe961925e3d043f5e03b10e2093d72b
> Author: robertogerola <robertogerola>
> Date:   Tue Feb 13 13:22:53 2007 +0000

Yes, that looks good. Which means something on our server is the reason
for git-cvsimport not working.

Continuing  investigation ...

-- 
best regards

  Ray
