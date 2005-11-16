From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add option USE_INPLACE to Makefile
Date: Wed, 16 Nov 2005 09:10:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160903360.16063@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511160333460.15130@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzk5cmnd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 09:11:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcIN1-0001th-85
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 09:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVKPIKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 03:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKPIKN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 03:10:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19922 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030216AbVKPIKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 03:10:11 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7227913F975; Wed, 16 Nov 2005 09:10:10 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 574829F30F; Wed, 16 Nov 2005 09:10:10 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 432899F1EA; Wed, 16 Nov 2005 09:10:10 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 25C2213F975; Wed, 16 Nov 2005 09:10:10 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzk5cmnd.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12011>

Hi,

On Tue, 15 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > and you no longer need to worry about setting variables like
> > GIT_EXEC_PATH and GIT_PYTHON_PATH.
> 
> I think you can already do this in the config.mak mechanism
> added by, ... (goes and asks git-whatchanged about it),...
> *you*, no?

Yes.

But I imagined a programmer new to git. And then I looked at the situation 
I had yesterday after pulling to 97fc6c5f.. in which I was able to build 
just fine, but calls like "git diff" no longer worked.

Now, *I* know what I have to put into config.mak, but I would hate the 
project if I was new to it, tried to play around with it, and nothing 
would work in spite of being compiled with just one warning, thank you.

> You know you are not installing things anyway if you do that, so
> I do not see much point hiding the install target and friends
> either.

Just a safety measure for the price of two lines. When I check out a new 
project, I do "make", play around with it, and then do "make install". If 
I had to set "export USE_INPLACE=1", "make install" should barf, because 
the compiled programs are not meant to be used anywhere else.

Having said that, I probably should have called it an RFC, not a PATCH. 
Sorry.

Ciao,
Dscho
