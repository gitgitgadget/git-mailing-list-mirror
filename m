From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules and rewind
Date: Wed, 20 Feb 2008 00:35:33 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080219140604.04afc91f@extreme> <20080219223201.GE4703MdfPADPa@greensroom.kotnet.org> <20080219152357.5ab397cf@extreme>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, skimo@kotnet.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRc0S-0000Gb-Vb
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYBSXfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYBSXfh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:35:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:42400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751808AbYBSXfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 18:35:37 -0500
Received: (qmail invoked by alias); 19 Feb 2008 23:35:35 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 20 Feb 2008 00:35:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lVkh1kqvlKudnwAnZOcrlHK2ClhsMQ/V7UjdZqy
	UYEQBgYDQwy7bh
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080219152357.5ab397cf@extreme>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74476>

Hi,

On Tue, 19 Feb 2008, Stephen Hemminger wrote:

> On Tue, 19 Feb 2008 23:32:01 +0100
> Sven Verdoolaege <skimo@kotnet.org> wrote:
> 
> > On Tue, Feb 19, 2008 at 02:06:04PM -0800, Stephen Hemminger wrote:
> > > Because of a bone headed merge, I had to rewind one project back
> > > to a known good state, but the sub module stuff is now wedged and
> > > brain stuck on the old commit id.
> > > 
> > > Isn't there some simple way to do 'git sub-module remove' followed
> > > by 'git sub-module add' to reset the internal index?
> > 
> > Why doesn't "git submodule update" work for you?
> > 
> 
> It didn't fix it, but recloning did.

That does not make sense.  But with your reluctance with regards to 
revealing details, it is really impossible to tell what is going on.

For example, you did not even once give us the output of "git submodule", 
let alone "git diff <submodule>".

Helpless,
Dscho
