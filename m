From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 18:47:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511031845410.3435@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511031741.20496.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 21:00:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXlDf-0003Vx-7Z
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 20:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbVKCT5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 14:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVKCT5v
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 14:57:51 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7606 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932565AbVKCT5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 14:57:50 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1840113F289; Thu,  3 Nov 2005 20:57:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2588D9F4AF; Thu,  3 Nov 2005 20:11:47 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E81B99F370; Thu,  3 Nov 2005 18:47:56 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9920613E20E; Thu,  3 Nov 2005 18:47:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200511031741.20496.alan@chandlerfamily.org.uk>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11089>

Hi,

On Thu, 3 Nov 2005, Alan Chandler wrote:

> I would like to make myself a git repository that contains at the start, 
> an initial commit of the original downloaded source code, and a second 
> commit on the top of that that contains the the current state of play 
> after the changes I have made.

How about this:

	cd orig/
	git-init-db
	git-add $(find * -type f)
	git-commit -m "initial"
	cd ../modified
	mv ../orig/.git ./
	git-add $(find * -type f)
	git-commit -a -m "my modifications"

Of course -- in the great tradition of this list -- totally untested.

Hth,
Dscho
