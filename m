From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules
Date: Tue, 7 Aug 2007 23:49:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708072344450.14781@racer.site>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXsw-0004QK-Aa
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814AbXHGWuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbXHGWuJ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:50:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:59970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933801AbXHGWuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:50:08 -0400
Received: (qmail invoked by alias); 07 Aug 2007 22:50:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 08 Aug 2007 00:50:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vYTg7q27vJYviFx4UW56CjLM1WOa0WXeAjCbpJs
	ysKWQzd6/A4Epu
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55281>

Hi,

On Tue, 7 Aug 2007, Dmitry Kakurin wrote:

> Where can I find more information about submodules?
> I'm interested in both internal implementation details and how to use them.

Most information is found in git-submodule.sh, although 
Documentation/git-submodule.txt has beginnings of a good documentation.

The basic idea is this:

A subdirectory contains a self-contained project.

Once that project is at a stage you want to have in the superproject, you 
can commit that submodule state, much like a subdirectory.

However, the history can progress in much coarser steps for the 
superproject.  IOW an ideal case for msysgit.git, where we want to have a 
stable version which can be checked out with GitMe.

Also, find more about submodules here:

http://git.or.cz/gitwiki/SubprojectSupport?highlight=%28submodule%29

Ciao,
Dscho
