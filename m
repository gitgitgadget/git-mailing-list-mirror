From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Re: Fixing author/email fields in commit messages
Date: Sun, 19 Feb 2006 16:35:47 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0602191634480.6352@gheavc.wnzcbav.cig>
References: <43F8BCB1.2010701@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 23:35:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAx9o-0004b9-If
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 23:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWBSWfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 17:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWBSWfx
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 17:35:53 -0500
Received: from mxsf40.cluster1.charter.net ([209.225.28.172]:57787 "EHLO
	mxsf40.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751101AbWBSWfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 17:35:52 -0500
Received: from mxip13a.cluster1.charter.net (mxip13a.cluster1.charter.net [209.225.28.143])
	by mxsf40.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id k1JMZmel008191
	for <git@vger.kernel.org>; Sun, 19 Feb 2006 17:35:49 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip13a.cluster1.charter.net with ESMTP; 19 Feb 2006 17:35:49 -0500
X-IronPort-AV: i="4.02,128,1139202000"; 
   d="scan'208"; a="2139375684:sNHT21757494"
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 1A07AC09E; Sun, 19 Feb 2006 16:35:47 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id EFE50C09D;
	Sun, 19 Feb 2006 16:35:47 -0600 (CST)
To: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <43F8BCB1.2010701@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16454>

On Sun, 19 Feb 2006, Jacob Kroon wrote:

> When I started my git repository for my project, I never setup GIT_AUTHOR_NAME
> etc. correctly,
> so my commit messages used the default information, "<jacob@skeletor.(none)>",
> "skeletor" being the
> hostname of the computer I'm working on. I'd like to change it so that the
> messages will contain correct
> information about my e-mail and username. I noticed that this question has
> been brought up here before
> and that the solution might be to use git-convert-objects, but that it might
> need some modifications.
> 
> Has anyone come up with a working tool for this task ?

I modified git-convert-objects to perform just that task.
I'll see if I can dig it up (I'm not able to do so right now).

--
Jon Nelson <jnelson-git@jamponi.net>
