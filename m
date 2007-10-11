From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git branch performance problem?
Date: Thu, 11 Oct 2007 11:46:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710111145090.4174@racer.site>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> 
 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> 
 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> 
 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> 
 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com> 
 <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org>
 <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Oct 11 12:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfvZE-00076v-KN
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 12:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbXJKKqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 06:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbXJKKqt
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 06:46:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:39007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752543AbXJKKqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 06:46:48 -0400
Received: (qmail invoked by alias); 11 Oct 2007 10:46:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 11 Oct 2007 12:46:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195bYp3Imd5OZcMJZ4fL0tijqBV7ZRS9Rk35EqHdD
	/S5dDUFbW/1RLa
X-X-Sender: gene099@racer.site
In-Reply-To: <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60590>

Hi,

On Wed, 10 Oct 2007, Han-Wen Nienhuys wrote:

> For cherrypicking convenience, I would still appreciate it if there was 
> a mechanism similar to alternates that would allow me to view objects 
> from an alternate repo; objects found through this mechanism should 
> never be assumed to be present in the database, of course.

Silly question: why don't you just

	git remote add -f other <url>

and then review the changes with "git log", "git diff" and "git show"?

Ciao,
Dscho
