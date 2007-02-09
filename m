From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question on git fetch to bare repo
Date: Fri, 9 Feb 2007 01:22:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090119070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17867.41997.561756.679778@lisa.zopyra.com> <eqg8fa$ru3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJXO-0002yK-Q1
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbXBIAWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbXBIAWs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:22:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:44427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422783AbXBIAWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:22:47 -0500
Received: (qmail invoked by alias); 09 Feb 2007 00:22:46 -0000
X-Provags-ID: V01U2FsdGVkX1+1mpI2LT21zrjg9lcYOeS0ihZYSf1gShHOWwRdVZ
	uHkA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eqg8fa$ru3$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39137>

Hi,

[Jakub, you broke the thread. I Cc' Bill, but I cannot join the thread]

On Thu, 8 Feb 2007, Jakub Narebski wrote:

> Bill Lear wrote:
> 
> > I have a public bare repo I created yesterday:
> > 
> > % mkdir project && cd project
> > % git --bare init-db --shared
> > % git --bare fetch git://source/project
> > [All seems well]
> 
> _Seems_ well
> 
>   % git clone --bare --shared git://source/project project
> 
> is a proper invocation.

No.

init --shared means that the repository is set up such that different 
users can update branches.

clone --shared means that if the original repository is on the local 
machine (which it is not in your example), then that is used as an 
alternate, i.e. the objects are not copied at all, but reused from the 
other location.

I complained about that ambiguity, but I am probably the guilty person: 
AFAIR it was me who introduced "init --shared".

Ciao,
Dscho
