From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Problems with git cvsimport
Date: Tue, 27 Feb 2007 17:01:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271700300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <002001c75a70$f69586e0$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Raimund Bauer' <ray007@gmx.net>, git@vger.kernel.org
To: Raimund Bauer <ray@softwarelandschaft.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4m5-0005kX-7F
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067AbXB0QBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933069AbXB0QBk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:01:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:51726 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933067AbXB0QBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 11:01:39 -0500
Received: (qmail invoked by alias); 27 Feb 2007 16:01:38 -0000
X-Provags-ID: V01U2FsdGVkX1/gx/wyqdjgr5fZc/ngkr9czTTZxLBPHoiZIqPDfM
	oRLg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <002001c75a70$f69586e0$0b0aa8c0@abf.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40755>

Hi,

On Tue, 27 Feb 2007, Raimund Bauer wrote:

> > > When trying to cvsimport a project into git, I get an error from 
> > > cvsps:
> > > 
> > > bad usage: invalid argument -A
> > 
> > What was your command line?
> 
> The complete command line was
> 
> git-cvsimport -d :pserver:ray007@cvs.drupal.org:/cvs/drupal-contrib -C views
> -k contributions/modules/views

Sorry to have missed that earlier. AFAIR cvsimport _needs_ cvsps 2.1. You 
have version 2.0rc1, which is not sufficient...

Ciao,
Dscho
