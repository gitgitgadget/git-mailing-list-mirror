From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 21:57:29 +0100
Message-ID: <20051103205729.GC28273@bohr.gbar.dtu.dk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <Pine.LNX.4.63.0511031845410.3435@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 21:58:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXm9O-0000C2-Rc
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 21:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVKCU5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 15:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbVKCU5c
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 15:57:32 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:14997 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1030476AbVKCU5b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 15:57:31 -0500
Received: (qmail 8356 invoked by uid 5842); 3 Nov 2005 21:57:29 +0100
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511031845410.3435@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11096>

On Thu, Nov 03, 2005 at 06:47:56PM +0100, Johannes Schindelin wrote:
...
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

As I stated in another message be careful with links because
they are not of "-type f".  In addition do

find * -type l

or at least keep in mind what is really going on.

Peter 
