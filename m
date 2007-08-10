From: Steffen Prohaska <prohaska@zib.de>
Subject: How to work with submodule?
Date: Fri, 10 Aug 2007 09:02:00 +0200
Message-ID: <769ABF7E-14C9-43D1-B879-138B6FF96B2E@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJOYG-00024r-7G
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXHJHEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbXHJHEq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:04:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:42279 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbXHJHEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:04:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7A71BGg012246
	for <git@vger.kernel.org>; Fri, 10 Aug 2007 09:04:43 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1103e.pool.einsundeins.de [77.177.16.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7A71BUb023626
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 09:01:11 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55511>

I tried to do some work on msysgit, but instead I'm fighting
with submodule for a while now. Maybe I haven't understood
something, but for submodule makes git nearly unusable.
Here is what I did.

msysgit ist organized in the following way.

/.git (clone of repo.or.cz/msysgit.git)
/git/.git (clone of repo.or.cz/git/mingw/4msysgit.git)

That is the root of the project is msysgit and as a submodule
git is included. Working on the submodule is fine.

But it I start to work on msysgit itself I get lost.

I have some changes in the submodule and just want to commit
some changes in the root, rebase to origin/master and push
to mob. To make it a bit harder I have some local changes
in the working tree.

This sounds quite simple, but I'm fighting with submodule
for quite some while now.

I think the root of all trouble is that I changed something
in the submodule git and now would like to change few things
in the root. I have a modified submodule and this messes
up everything.

I can't stash, I can't rebase.

I tried to commit the head of the submodule (btw, how should
I call this? I mean, the sha1 of the head of the submodule),
to get a clean git-status.

Now, I can't even switch branches.

How is this ment to work?
I have no clue how I should work with this mess?

I mean, I should be allowed to work on the submodule and somehow
work on the superproject at the same time? But none of my
usual workflow works because I always get trapped by a
modified submodule.

	Steffen
