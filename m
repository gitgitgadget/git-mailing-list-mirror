From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-branch -m cannot rename remote branches
Date: Sun, 8 Jun 2008 23:58:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806082357470.1783@racer>
References: <200806082257.20833.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Tsm-0003dE-PL
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYFHXAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbYFHXAA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:00:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:44425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753003AbYFHXAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:00:00 -0400
Received: (qmail invoked by alias); 08 Jun 2008 22:59:57 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 09 Jun 2008 00:59:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AUOoG8DQAaM1DLqm8NPuVpTW1Fsb26uArpik24x
	Ly9hPFYfjyiYWN
X-X-Sender: gene099@racer
In-Reply-To: <200806082257.20833.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84338>

Hi,

On Sun, 8 Jun 2008, Jakub Narebski wrote:

> I cannot rename remote branch (possibly packed, and possibly with
> reflog) using "git branch"

That is very much by design; a next fetch would get them with their 
current name anyway.  A "remote prune" should get rid of any stale 
branches.

So yes, "branch -m" with remote branches does not make sense.

Ciao,
Dscho
