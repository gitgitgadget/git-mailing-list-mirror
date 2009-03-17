From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Tue, 17 Mar 2009 23:31:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
References: <200903171953.23650.ogoffart@kde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Olivier Goffart <ogoffart@kde.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjhoH-0003cF-SR
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 23:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbZCQW33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 18:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZCQW32
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 18:29:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:47791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751814AbZCQW32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 18:29:28 -0400
Received: (qmail invoked by alias); 17 Mar 2009 22:29:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 17 Mar 2009 23:29:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xmKxDqHgxHF8omuebTf+kBVYO+2cTV3THMiV/wY
	46EYV++6LR3pei
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200903171953.23650.ogoffart@kde.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113532>

Hi,

On Tue, 17 Mar 2009, Olivier Goffart wrote:

> I use git in a workflow in wich we often need to edit the message logs 
> of some commits. The way we do it is using git rebase -i and choose 
> edit.  But then you need to do git commit --amend and git rebase 
> --continue, which is error prone and add more useless steps.
> 
> The attached patch add a new keyword to git rebase interactive to just 
> edit the message log.
> 
> I was told on IRC that this has been discussed already not so long ago, 
> and looking on the archive[1], all i seen was bikesheeding .  Here is a 
> patch :-)

Unfortunately, the implementation is not the problem, but picking the best 
name.  The first letter "m" will be taken in a short while by the "merge" 
command for "rebase -i -p", so "message" is out, sadly.

But the "rephrase" command will be part of the "rebase -i -p" series when 
I will finally be able to submit it.

Ciao,
Dscho
