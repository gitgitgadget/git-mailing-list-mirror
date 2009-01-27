From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase failure if commit message looks like a patch
Date: Tue, 27 Jan 2009 19:15:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271914130.3586@pacific.mpi-cbg.de>
References: <loom.20090127T173025-125@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anton <Anton.Sharonov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsUt-00045J-2i
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbZA0SPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbZA0SPu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:15:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:52337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752474AbZA0SPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:15:49 -0500
Received: (qmail invoked by alias); 27 Jan 2009 18:15:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 27 Jan 2009 19:15:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19akSgbBYJa1cYPqJpKy4XnQNMjJAsNg6i24F7mtn
	r6E12g+CJSTNsO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20090127T173025-125@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107377>

Hi,

On Tue, 27 Jan 2009, Anton wrote:

> I have found a strange behaviour of "git rebase", present in following 
> versions:

That is a known issue.  Please work around it with redoing the rebase with 
-m.

I could imagine that we should scan the commit messages before actually 
running rebase, and either activate -m, or escape the "diff" with a 
backslash (as is frequently done with "From" in mails).

Ciao,
Dscho
