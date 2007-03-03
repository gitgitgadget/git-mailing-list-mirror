From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug in git-archive?
Date: Sat, 3 Mar 2007 17:09:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031707540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esc64d$d2u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nick Williams <njw@jarb.freeserve.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 03 17:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNWnU-0005CL-UQ
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 17:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030673AbXCCQJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 11:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030675AbXCCQJW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 11:09:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:35711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030673AbXCCQJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 11:09:21 -0500
Received: (qmail invoked by alias); 03 Mar 2007 16:09:19 -0000
X-Provags-ID: V01U2FsdGVkX19wH9FtmihwI+wTOQa7NQ/grjqymZjX40YMEsRnYk
	mbhdtaRqk+Nw9U
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <esc64d$d2u$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41301>

Hi,

On Sat, 3 Mar 2007, Nick Williams wrote:

> git-archive only archives the current working dir (and sub dirs) even 
> when no paths are specified. For example, if I do
> 
> git archive --format=tar --prefix=git-1.5.0.2/ HEAD > ~/test/test.tar
> 
> > from with in the Documentation dir, then I only get part of the tree.
> 
> Is this the intended behavior?

It is. So, the documentation is wrong.

Ciao,
Dscho
