From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to (re-)create .git/logs/refs
Date: Tue, 13 May 2008 12:46:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805131244300.30431@racer>
References: <200805081256.11465.hs4233@mail.mn-solutions.de> <alpine.LFD.1.10.0805081313190.23581@xanadu.home> <200805130842.06112.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
X-From: git-owner@vger.kernel.org Tue May 13 13:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvsz1-0003Us-0N
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbYEMLrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 07:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYEMLrA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:47:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:57541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752851AbYEMLq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:46:59 -0400
Received: (qmail invoked by alias); 13 May 2008 11:46:57 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp044) with SMTP; 13 May 2008 13:46:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Oz54nBGyO/xsT2K/rgH242a/ea/yRVumXX96lB+
	JdS1HvTbRFx0nt
X-X-Sender: gene099@racer
In-Reply-To: <200805130842.06112.hs4233@mail.mn-solutions.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82020>

Hi,

On Tue, 13 May 2008, Holger Schurig wrote:

> > > a) is there a way to re-create .git/logs/refs ?
> >
> > No.
> >
> > The reflog records how _you_ modified your various branches
> > locally.
> 
> Okay, then I presume it's a shortcoming that the @{date} syntax 
> uses .git/logs/ref.

Are you sure you understand what @{date} does?  It shows you the state 
_this_ repository was in at that date.

There is _no way_ to get this information from somewhere else than the 
reflogs.

It is a common misconception that you can reference anything by date in a 
distributed setup.  (Before you ask, I will just mention "clock skew" and 
"parallel branches" to give you an idea why this is a misconception.)

Ciao,
Dscho
