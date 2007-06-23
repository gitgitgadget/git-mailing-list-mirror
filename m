From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] cvsimport: test case for severe branch import problem
Date: Sat, 23 Jun 2007 15:26:08 +0200
Message-ID: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de>
References: <11826031071213-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 15:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I25cn-0007iY-4I
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 15:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760182AbXFWNZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 09:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760176AbXFWNZF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 09:25:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:56751 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759928AbXFWNZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 09:25:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5NDP29x029018
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 15:25:02 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1b413.pool.einsundeins.de [77.177.180.19])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5NDP1Kg016516
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 23 Jun 2007 15:25:01 +0200 (MEST)
In-Reply-To: <11826031071213-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50738>


On Jun 23, 2007, at 2:51 PM, Steffen Prohaska wrote:

> The conclusion is you must not rely on the existing cvsimport for
> tracking cvs branches. The history of such branches may be plain  
> wrong.
> Git may display different patches than cvs would do. Merging cvs
> topic branches may yield completely wrong results. One obvious thing
> that may happen is that a merge reverts changes commited to the cvs
> trunk before the first commit to the cvs branch. And this would happen
> without any indication by git. Everything would seem to run smoothely.

This is not only a theoretical problem but I am experiencing it on a
real-world repository right now. I have a topic branch that branches
off from the wrong commit in git.

Is there an easy way to fix this? I know the right commit the branch
should have as its parent. How can I move it there? git-rebase is not  
the
right command because the patches derived from my branch are already  
wrong.
I would only need to attach the first commit to a different parent.

	Steffen
