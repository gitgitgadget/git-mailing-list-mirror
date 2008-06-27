From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit-tree: lift completely arbitrary limit of 16
 parents
Date: Fri, 27 Jun 2008 14:02:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271402110.9925@racer>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain> <alpine.DEB.1.00.0806271259440.9925@racer> <alpine.DEB.1.00.0806271324010.9925@racer> <4864E472.3070301@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 27 15:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDeI-0005x9-97
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbYF0NEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbYF0NEs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:04:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:60069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755270AbYF0NEr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:04:47 -0400
Received: (qmail invoked by alias); 27 Jun 2008 13:04:45 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp038) with SMTP; 27 Jun 2008 15:04:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18P7bAC8GkPdVnlHOW4LtEDRCi08k685g/fBpJzUg
	FiwXJFM9Sy+S0K
X-X-Sender: gene099@racer
In-Reply-To: <4864E472.3070301@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86555>

Hi,

On Fri, 27 Jun 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > @@ -69,18 +63,16 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
> >  
> >  	check_valid(tree_sha1, OBJ_TREE);
> >  	for (i = 2; i < argc; i += 2) {
> > +		unsigned char sha1[40];
> 
> 		unsigned char sha1[20];
> 
> is sufficient here, /me thinks.

Ooops.  Completely correct.

Junio, want me to fix it up?  Or do you want me not to bother with this 
patch at all?

Ciao,
Dscho
