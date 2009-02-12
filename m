From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsimport and i18n.commitencoding
Date: Thu, 12 Feb 2009 12:12:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902121209270.10279@pacific.mpi-cbg.de>
References: <4993C92E.7080909@yahoo.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Prenom Nom <utilisateur_768@yahoo.fr>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZV7-0005sQ-7c
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 12:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbZBLLLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 06:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756557AbZBLLLd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 06:11:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754362AbZBLLLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 06:11:33 -0500
Received: (qmail invoked by alias); 12 Feb 2009 11:11:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 12 Feb 2009 12:11:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cOX4cXptcxRM1UBRIvvD/J0i8YE/i0KJoPIM4kw
	FTHuF5mBaSnfQ1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4993C92E.7080909@yahoo.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109603>

Hi,

On Thu, 12 Feb 2009, Prenom Nom wrote:

> The thing is i cannot change the .git/config file since the repo is 
> created by git-cvsimport.

Indeed.  A dirty little trick would be to edit $(git 
--exec-path)git-cvsimport and put in your desired changes.

A less ugly solution would be to patch git-cvsimport.perl to add an option 
--into-existing-repository that does not complain when the Git repository 
is already initialized, unless the 'origin' branch exists, too.

Hth,
Dscho
