From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 22:02:18 +0000
Message-ID: <200511032202.18900.alan@chandlerfamily.org.uk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <Pine.LNX.4.63.0511031845410.3435@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 23:03:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnA6-00011S-HI
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVKCWCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVKCWCT
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:02:19 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:13259
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751152AbVKCWCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:02:19 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EXnA2-0006dE-8J
	for git@vger.kernel.org; Thu, 03 Nov 2005 22:02:18 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.63.0511031845410.3435@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11100>

On Thursday 03 Nov 2005 17:47, Johannes Schindelin wrote:
> Hi,
>
> On Thu, 3 Nov 2005, Alan Chandler wrote:
> > I would like to make myself a git repository that contains at the start,
> > an initial commit of the original downloaded source code, and a second
> > commit on the top of that that contains the the current state of play
> > after the changes I have made.
>
> How about this:
>
> 	cd orig/
> 	git-init-db
> 	git-add $(find * -type f)
> 	git-commit -m "initial"
> 	cd ../modified
> 	mv ../orig/.git ./
> 	git-add $(find * -type f)
> 	git-commit -a -m "my modifications"
>
> Of course -- in the great tradition of this list -- totally untested.

Also untested, but what about removing the files from the index that aren't in 
the working directory?

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
