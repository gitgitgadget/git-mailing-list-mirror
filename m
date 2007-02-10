From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 21:40:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702102137110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	GIT list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 21:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFz1v-0003PK-Rp
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 21:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXBJUkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXBJUkn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 15:40:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:58557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751886AbXBJUkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 15:40:43 -0500
Received: (qmail invoked by alias); 10 Feb 2007 20:40:41 -0000
X-Provags-ID: V01U2FsdGVkX1+PpiBT/CKPRvi5anyCdibLFYrQY6FJKNNkHLra4f
	sbGA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39259>

Hi,

On Sat, 10 Feb 2007, Nicolas Pitre wrote:

> On Sat, 10 Feb 2007, Johannes Schindelin wrote:
> 
> > So, what is the big problem about accepting that patching git-status for 
> > one obscure use is wrong, wrong, wrong, when git-diff already does what is 
> > needed???
> 
> Because git-status itself is conceptually a read-only operation, and 
> having it barf on a read-only file system is justifiably a bug.

Just to fuel the fire even more: Does it make _sense_ running git-status 
when you cannot write? I mean, the only reasonable use cases to ask 
git-status (even interpreting it in the "state" sense you are proposing), 
is when you are _working_ on the files. Which you cannot do without write 
access.

BTW I was not aware that "git diff --name-only HEAD" would not check if 
the file is differing or not, but even then, it is arguably the right 
thing for qgit to show what the index' idea of the status is.

Ciao,
Dscho
