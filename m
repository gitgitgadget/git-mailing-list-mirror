From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 14:23:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171422340.28586@racer.site>
References: <11900314321506-git-send-email-hjemli@gmail.com>  <46EE7584.8010202@op5.se>
 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGaU-0000PV-Tr
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbXIQNY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbXIQNY0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:24:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:60970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752762AbXIQNYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:24:25 -0400
Received: (qmail invoked by alias); 17 Sep 2007 13:24:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 17 Sep 2007 15:24:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SD/dLh42Sd5Hd19vgDGcDBc5npz3uniXrWfVY/c
	ExkUNLFnSHGi0+
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58439>

Hi,

On Mon, 17 Sep 2007, Lars Hjemli wrote:

> When 'git-svn dcommit' decides which commits it should push back
> subversion, it scans the output from 'git-log --first-parent HEAD'
> looking for embedded 'git-svn-id' lines. These lines contain the url
> of the upstream subversion repository + the subversion revision
> number.

> So the problem with fast-forward merges of subversion branches is that 
> the output from 'git-log --first-parent HEAD' will show commits from the 
> wrong subversion branch (the fast-forwarded commits).

Ah, I think I know what you're trying to get at.  But "git svn fetch && 
git rebase git-svn" might be a better approach than "git svn fetch && git 
merge --no-ff git-svn", no?

Ciao,
Dscho
