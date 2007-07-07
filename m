From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: git-svn set-tree
Date: Sat, 7 Jul 2007 02:03:47 +0200
Message-ID: <001501c7c02a$4bc130a0$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 02:04:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6xmR-0002pN-Dx
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 02:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbXGGADy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 20:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbXGGADy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 20:03:54 -0400
Received: from csmtp.b-one.net ([195.47.247.21]:36109 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbXGGADx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 20:03:53 -0400
Received: from Jocke (84-217-3-187.tn.glocalnet.net [84.217.3.187])
	by csmtp1.b-one.net (Postfix) with ESMTP id 22486191168C0
	for <git@vger.kernel.org>; Sat,  7 Jul 2007 02:03:52 +0200 (CEST)
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcfAKkqUZzfjKN2AQoGq6mcSnyJUnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51793>

I have noticed that if I do a git-svn set-tree, remotes/git-svn retains the parent
from the branch where set-tree was performed.

If a coworker wants recreate my tree by using git-svn init && git-svn fetch
he looses the parent I have in my tree.

I wonder if not git-svn set-tree can record the parent information in the
svn repos log, so that git-svn init/fetch can recreate the parent relationship?

 Jocke
