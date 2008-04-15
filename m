From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make core.sharedRepository more generic (version 4)
Date: Tue, 15 Apr 2008 12:03:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804151202560.9665@racer>
References: <20080415012156.GA13594@zakalwe.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:04:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlixe-0003uA-SP
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbYDOLDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512AbYDOLDj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:03:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:38355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755225AbYDOLDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:03:38 -0400
Received: (qmail invoked by alias); 15 Apr 2008 11:03:37 -0000
Received: from unknown (EHLO racer.local) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 15 Apr 2008 13:03:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YbpEWvGuYiimb7suFc92QeZUBc46lqSRaZuAvZ9
	bUUaRnbDwvBZSP
X-X-Sender: gene099@racer
In-Reply-To: <20080415012156.GA13594@zakalwe.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79583>

Hi,

On Tue, 15 Apr 2008, Heikki Orsila wrote:

> git init --shared=0xxx, where '0xxx' is an octal number, will create
> a repository with file modes set to '0xxx'. Users with a safe umask
> value (0077) can use this option to force file modes. For example,
> '0640' is a group-readable but not group-writable regardless of
> user's umask value.
> 
> "git config core.sharedRepository 0xxx" is also handled.
> 
> Version 2 handles the directory x flags better than version 1.
> 
> Version 3 removes a warning for the o+w case, fixes a compatibility
> problem with older Git's, and corrects some style issues.
> 
> Version 4 really fixes the o+w case.
> 
> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---

I still see "Version N" before the ---.  You should describe what this 
patch does in a manner that makes sense when reading just the commit 
history.

Ciao,
Dscho
