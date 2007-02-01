From: "Raimund Bauer" <ray007@gmx.net>
Subject: RE: [PATCH] detached HEAD -- finishing touches
Date: Thu, 1 Feb 2007 10:46:22 +0100
Message-ID: <001a01c745e5$d59fde80$0b0aa8c0@abf.local>
References: <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Nicolas Pitre'" <nico@cam.org>, <cworth@cworth.org>,
	<git@vger.kernel.org>
To: "'Junio C Hamano'" <junkio@cox.net>, "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 10:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCYWs-0006oK-69
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 10:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbXBAJqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 04:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbXBAJqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 04:46:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:51806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422719AbXBAJqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 04:46:23 -0500
Received: (qmail invoked by alias); 01 Feb 2007 09:46:22 -0000
Received: from host-62-245-155-90.customer.m-online.net (EHLO swl011) [62.245.155.90]
  by mail.gmx.net (mp044) with SMTP; 01 Feb 2007 10:46:22 +0100
X-Authenticated: #20693823
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38336>

>     [git.git (master)]$ git checkout master^
>     M       git-checkout.sh
>     Note: you are not on any branch and are at commit "master^"
>     If you want to create a new branch from this checkout, 
> you may do so
>     (now or later) by using -b with the checkout command 
> again. Example:
>       git checkout -b <new_branch_name>
> 
> * Coming back to an attached state can lose the detached HEAD, so
>   I get warned and stopped.
> 
>     [git.git]$ git checkout master
>     You are not on any branch and switching to branch 'master'
>     may lose your changes.  At this point, you can do one of 
> two things:
>      (1) Decide it is Ok and say 'git checkout -f master';
>      (2) Start a new branch from the current commit, by saying
>          'git checkout -b <branch-name>'.
>     Leaving your HEAD detached; not switching to branch 'master'.

Here you have a detached HEAD, but you haven't build any commits
on top of it. Why shouldn't you be allowed to move away?

-- 
best regards

  Ray
