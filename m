From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
 returns st_size 0
Date: Tue, 22 Jul 2008 01:26:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807220126020.3407@eeepc-johanness>
References: <20080721173511.GB5387@steel.home> <alpine.DEB.1.00.0807211917440.8986@racer> <20080721194322.GA4013@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 01:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL4md-0006Wy-F6
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 01:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbYGUX0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 19:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbYGUX0H
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 19:26:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:52226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbYGUX0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 19:26:06 -0400
Received: (qmail invoked by alias); 21 Jul 2008 23:26:02 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp015) with SMTP; 22 Jul 2008 01:26:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dMFQq8Z3d4B+XNBPGXoC9znWExh3qZna9Y2q+yC
	+IhRxVVxVaftq4
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080721194322.GA4013@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89416>

Hi,

On Mon, 21 Jul 2008, Alex Riesen wrote:

> Johannes Schindelin, Mon, Jul 21, 2008 20:20:43 +0200:
>
> > Alex wrote:
> > 
> > > Can MSys folks please try it? I noticed it when the test 
> > > t2103-update-index-ignore-missing.sh (the 5th case) started failing.
> > 
> > Since M$' documentation says "This member does not have a meaning for 
> > directories." about the member nFileSizeLow of 
> > WIN32_FILE_ATTRIBUTE_DATA which we use to implement a sane "lstat()", 
> > I think this bug hits MinGW (not MSys) as well.
> 
> Could you, just for completeness, try?

No, I cannot.  I have no Windows machine.

Ciao,
Dscho
