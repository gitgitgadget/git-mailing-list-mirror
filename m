From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Fri, 20 Jun 2008 13:25:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201323390.6439@racer>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se> <20080620115102.GW29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:28:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fjK-00065U-0a
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbYFTM1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbYFTM13
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:27:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:44805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbYFTM11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:27:27 -0400
Received: (qmail invoked by alias); 20 Jun 2008 12:27:25 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp022) with SMTP; 20 Jun 2008 14:27:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/f6r1jsN3fyhi46fi8TxGc7KJ9NWcZ6/718/xAxf
	MwcFVvpjOFtTDj
X-X-Sender: gene099@racer
In-Reply-To: <20080620115102.GW29404@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85628>

Hi,

On Fri, 20 Jun 2008, Miklos Vajna wrote:

> On Fri, Jun 20, 2008 at 10:42:22AM +0100, Peter Karlsson <peter@softwolves.pp.se> wrote:
> > I am looking at moving a project that has not been version-controlled 
> > in the regular sense into Git. I have found it to currently consist of 
> > 40 directories with copies of the set of files in various shapes.
> > 
> > I have reconstructed something that looks like a probable revision 
> > tree for these 40 directories, and I want to put this into Git so that 
> > I can examine what changes have been made where, and merge the various 
> > versions back together so that there can be one version with all the 
> > various fixes.
> 
> Maybe contrib/fast-import/import-tars.perl?

BTW this is a relatively simple script showing how to import commits into 
a Git repository using git-fast-import.

You should be able to use git-fast-import from a simple script yourself; 
if you would like to see an example how to feed fast-import, just export a 
few commits with "git fast-export HEAD~5..".

Hth,
Dscho
