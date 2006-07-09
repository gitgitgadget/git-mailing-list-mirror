From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFH: refactor read-tree
Date: Sun, 9 Jul 2006 16:30:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607091630110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org> <20060709124324.GE5919@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 16:30:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzaJ8-0001ZU-F9
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 16:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWGIOar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 10:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWGIOar
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 10:30:47 -0400
Received: from mail.gmx.de ([213.165.64.21]:41135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932459AbWGIOaq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 10:30:46 -0400
Received: (qmail invoked by alias); 09 Jul 2006 14:30:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 09 Jul 2006 16:30:45 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060709124324.GE5919@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23551>

Hi,

On Sun, 9 Jul 2006, Alex Riesen wrote:

> Linus Torvalds, Sun, Jul 09, 2006 05:15:41 +0200:
> > The basic idea is that "branch1" should be your current branch, and it 
> > obviously is also expected to match (more or less) the current index. So 
> > you can do a merge by
> > 
> >  - reading in "branch1" into the index:
> > 
> > 	GIT_INDEX_FILE=.git/tmp-index git-read-tree -m branch1
> 
> what is "-m" here for?

It means that git-read-tree tries to merge the current index with branch1.

Ciao,
Dscho
