From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Get format-patch to show first commit after root
 commit
Date: Sat, 10 Jan 2009 11:35:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101134100.30769@pacific.mpi-cbg.de>
References: <49679f61.1b068e0a.048f.70e4@mx.google.com> <alpine.DEB.1.00.0901101122570.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 10 11:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbCf-0003sa-KZ
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbZAJKei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbZAJKeh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:34:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:47116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753629AbZAJKeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:34:37 -0500
Received: (qmail invoked by alias); 10 Jan 2009 10:34:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 10 Jan 2009 11:34:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WG00DFo2WN8+c0bXDssGQsnNCcwPcj2jDp2VAxc
	ulRQRRXMcf9B8p
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901101122570.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105087>

Hi,

On Sat, 10 Jan 2009, Johannes Schindelin wrote:

> On Fri, 9 Jan 2009, nathan.panike@gmail.com wrote:
> 
> > >From 65c4fed27fe9752ffd0e3b7cb6807561a4dd4601 Mon Sep 17 00: 00:00 2001
> > From: Nathan W. Panike <nathan.panike@gmail.com>
> > Date: Fri, 9 Jan 2009 11:53:43 -0600
> > Subject: [PATCH] Get format-patch to show first commit after root commit
> > 
> > Currently, the command
> > 
> > git format-patch -1 e83c5163316f89bfbde
> 
> You do not need -1, and using 19 digits seems a bit arbitrary; the 
> convention seems to be 7 digits (that is what --abbrev-commit does).

Sorry, the -1 is needed.

Ciao,
Dscho
