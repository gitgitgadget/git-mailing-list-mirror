From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 5 May 2007 03:29:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705050324580.4015@racer.site>
References: <463BD40C.6080909@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 03:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk96B-0005cF-Ez
	for gcvg-git@gmane.org; Sat, 05 May 2007 03:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767938AbXEEBaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 21:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767937AbXEEBaE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 21:30:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:52975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767938AbXEEBaB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 21:30:01 -0400
Received: (qmail invoked by alias); 05 May 2007 01:29:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 05 May 2007 03:29:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sSyofIhKsN5mFZR226ZHoSifwIB4ryGyro16o/n
	AYZvq/qtpi8KEn
X-X-Sender: gene099@racer.site
In-Reply-To: <463BD40C.6080909@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46237>

Hi,

On Fri, 4 May 2007, Dana How wrote:

> Most commands accept relative paths,  but this is
> not true of arguments in ent:path format.  This
> patch makes all of the following git-show commands
> work in the git source tree (not just the first):
>  % cd xdiff
>  % git-show v1.5.2-rc0:xdiff/xemit.h
>  % git-show v1.5.2-rc0:./xemit.h
>  % git-show v1.5.2-rc0:../sha1_name.c

ACK.

> It also adds ent:?string as a synonym for ent:/string .
> This makes the following changes possible later:
> ent:/path is an absolute path and ent:path is relative.

NACK. The "?" thing is highly unintuitive, and I still do not think that 
it is worth the confusion to make Git behave funny on 
<tree>:<file-name>.

Think of the "todo" branch, for example. And this is not even far fetched. 
In many repositories I have to have separate related, but non-branch 
HEADs. For example, I track some projects with custom scripts. These 
scripts do _not_ belong into that branch. However, they are related, so I 
store them in the same repository.

Plus, my example of the bare-repository still has not been answered by 
_anyone_ in favour of changing the current behaviour.

Ciao,
Dscho
