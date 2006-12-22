From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 13:18:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221316550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061222084425.GA4644@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Dec 22 13:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjMy-0006Fs-AM
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWLVMS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWLVMS6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:18:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:44671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965176AbWLVMS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:18:57 -0500
Received: (qmail invoked by alias); 22 Dec 2006 12:18:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 22 Dec 2006 13:18:56 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20061222084425.GA4644@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35168>

Hi,

On Fri, 22 Dec 2006, Alex Riesen wrote:

> Johannes Schindelin, Fri, Dec 22, 2006 03:19:21 +0100:
> > 
> > If the cache tree is not up-to-date, it will be updated first. So, now
> > 
> > 	$ git show :Documentation/
> > 
> > will in effect show what files/directories are in the index' version
> > of the directory Documentation. The three commands
> > 
> > 	$ git show :./
> > 	$ git show :.
> > 	$ git show :
> > 
> > are all equivalent and show the index' idea of the root directory.
> 
> That is a bit unexpected if you're not in the root directory of
> repository, but in some subdir of the working directory.
> Why root? Why not the current directory relative to root?

Why root? Because you are not asking for the working directory. Use "ls" 
for that. You are asking for the index. If you git-show a commit, you 
don't expect the output to be restricted by the subdirectory you're in, 
either, right?

CIao,
Dscho
