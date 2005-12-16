From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 02:31:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512160229140.6323@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 02:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En4RO-0008Mm-RY
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 02:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVLPBbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 20:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVLPBbQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 20:31:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8921 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751245AbVLPBbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 20:31:15 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 293D713FA76; Fri, 16 Dec 2005 02:31:12 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 126469DEA1; Fri, 16 Dec 2005 02:31:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E85859B2A4; Fri, 16 Dec 2005 02:31:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 994B113FA76; Fri, 16 Dec 2005 02:31:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13725>

Hi,

On Fri, 16 Dec 2005, Martin Langhoff wrote:

> I know, I know, use pickaxe :-)
> 
> Any suggestions as to how to implement a not-too-slow annotate that
> looks reasonable enough so as to fool real cvs clients?

For starters, you could use my attempt:

http://www.gelato.unsw.edu.au/archives/git/0508/7171.html

It does not fool any CVS user, because it does not fake version numbers. 
Instead, you can display SHA1s, short SHA1s, author names, or mixtures 
thereof.

However, I learnt to use git-whatchanged in the meantime, and I'll 
probably never go back.

Hth,
Dscho
