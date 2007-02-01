From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: git docs on kernel.org too new?
Date: Thu, 1 Feb 2007 11:26:49 -0600 (CST)
Message-ID: <Pine.LNX.4.62.0702011051300.31498@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 18:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCg67-0007rf-I3
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbXBARvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbXBARvd
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:51:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47727 "EHLO
	mail1.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422781AbXBARvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:51:32 -0500
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Feb 2007 12:51:32 EST
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail1.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l11HQNnV001367
	for <git@vger.kernel.org>; Thu, 1 Feb 2007 11:26:26 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Feb 2007 11:26:49 -0600
X-OriginalArrivalTime: 01 Feb 2007 17:26:49.0941 (UTC) FILETIME=[2822A850:01C74626]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-14970000
X-TM-AS-Result: : No
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ3MDE4LTcwNDQxMC0xMDU3?=
	=?us-ascii?B?MDAtMTM5NzA0LTEwNjU4MC03MDAwNDAtNzA0NzEyLTcwMDkwOS03?=
	=?us-ascii?B?MDIwNDQtNzAxNDU1LTcwMjcyNi03MDE2MTgtMTEzOTQzLTcwMjM1?=
	=?us-ascii?B?OC03MDM4MjItNzA1NDYxLTEyMTExMy03MDA3NTYtNzA0Mjc3LTcw?=
	=?us-ascii?B?NDQyNS03MDQzNDEtNzAzMzM0LTcwNTA5MC03MDMyODMtNzAzMzk5?=
	=?us-ascii?B?LTE4ODAxOS03MDA0NzYtMTExNjA0LTE0ODA1MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38383>



The git documentation here:

   http://www.kernel.org/pub/software/scm/git/docs/

does not seem to describe the current stable release of
git: git-1.4.4.4 (there is a release candidate of 1.5.0 on kernel.org)

I just want to let you know that it has been making it difficult to
learn how to use git.

I think in some cases the documentation is out of date, but I suspect
that in other cases the documentation refers to the future 1.5.0 release?

For example:

-Step one of tutorial.html:

    $ git config --global user.name "Your Name Comes Here"

    But git-config does not exist.

-Step two of tutorial "Importing a new project"

    $ git init

    But git-init does not exist.

-git-remote does not exist.

-Later "$ git merge experimental" is suggested, but see below, this
  appears to be the wrong usage.

-The everyday.html and git-merge.html pages describe
   a different usage for git-merge than the git-1.4.4.4 docs and
   executables.

   everyday.html(kernel.org):
     $ git checkout master (9)
     $ git merge alsa-audio (10)

   git-merge(kernel.org):
     git-merge [-n] [--no-commit] [--squash] [-s <strategy>] -m=<msg> <remote> <remote>

   git-merge(1.4.4.4):
     Usage: git-merge [-n] [--no-commit] [--squash] [-s <strategy>]... <merge-message> <head> <remote>+


-brandon
