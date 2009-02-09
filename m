From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase-interactive: you can also add new commits to
 the "work list"
Date: Mon, 9 Feb 2009 22:31:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902092228470.10279@pacific.mpi-cbg.de>
References: <1234214701-20245-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdkC-0007pH-LO
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbZBIVbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbZBIVbP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:31:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:47360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754186AbZBIVbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:31:14 -0500
Received: (qmail invoked by alias); 09 Feb 2009 21:31:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 09 Feb 2009 22:31:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/drf1XSnzdzSun6PCabkgU1y46up9163Pdy1mLGp
	MJCmeTV8C0MLxz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234214701-20245-1-git-send-email-barvik@broadpark.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109136>

Hi,

On Mon, 9 Feb 2009, Kjetil Barvik wrote:

> Add 2 small lines to document that you can also use 'git rebase
> --interactive' to add new commits to the rebased patch-series.  This
> is sort of running multiple 'git cherry-pick' commands in one go.

If we start along those lines, we also have to add documentation how to

- split commit,

- change authorship of commits,

- deal with commits where --cherry-pick did not detect that they were 
  applied already,

- deal with merge commits, and

- possibly a lot more.

I do not think that this is a good way to spend valuable screen estate; I 
think that is what the man page should cover.

I only made an exception for the deletion of lines, as people were 
actively burnt.  Yes, they should have read the man page.  But the 
consequences of not doing so were bad.

Ciao,
Dscho
