From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Fri, 20 Jun 2008 14:00:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201359320.6439@racer>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se> <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer> <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gGi-0002ss-4K
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYFTNB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYFTNB6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:01:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:57314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753559AbYFTNB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:01:57 -0400
Received: (qmail invoked by alias); 20 Jun 2008 13:01:55 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp064) with SMTP; 20 Jun 2008 15:01:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TH6l7Pr2Tw/jyvTX0m5Tn1mYCpwkq4041f0PfBi
	XtR7roKtUu08lf
X-X-Sender: gene099@racer
In-Reply-To: <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85635>

Hi,

On Fri, 20 Jun 2008, Peter Karlsson wrote:

> One complicating factor is that I am working with DOS/Windows source 
> code, so all text files have CRLF line-endings, which means converting 
> before feeding to fast-import, or manually doing "git add" with 
> core.autocrlf == true. fast-import can't be set up to do CRLF 
> auto-conversion, can it?

Why not import everything with a CR/LF, and then use filter-branch with a 
really simple tree-filter?  It is slow, alright, but it is safe, too.

Ciao,
Dscho
