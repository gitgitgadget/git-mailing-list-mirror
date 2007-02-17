From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to speed up "git log"?
Date: Sun, 18 Feb 2007 00:20:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180019040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702111252.28393.bruno@clisp.org> <20070211152840.GA2781@steel.home>
 <200702172019.20536.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIYrO-0002t0-HK
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbXBQXUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933093AbXBQXUv
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:20:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:38363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933095AbXBQXUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:20:51 -0500
Received: (qmail invoked by alias); 17 Feb 2007 23:20:49 -0000
X-Provags-ID: V01U2FsdGVkX1+dWzMqpOidE5kvWjKPEx6BAYtQDLta+cNE4YNIeY
	FPNA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702172019.20536.bruno@clisp.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40022>

Hi,

On Sat, 17 Feb 2007, Bruno Haible wrote:

> Alex Riesen wrote:
> > MacOS X is famous for its bad perfomance when doing serious work.
> > The mmap(2) of it, in particular.
> 
> You can't blame MacOS X mmap(2) for git's slow execution of "git log".

No, but you can blame the person calling git log and waiting until it 
finishes. See the list archives for reasons why.

If this comes up one more time, I'm very tempted to write a scathing 
remark in the FAQ.

Ciao,
Dscho
