From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/13] Add support for "import" helper command
Date: Wed, 5 Aug 2009 23:23:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052321580.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055550.2147@iabervon.org> <alpine.DEB.1.00.0908052254570.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051708060.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnwj-0002i2-Gs
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZHEVWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZHEVWo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:22:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49667 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752040AbZHEVWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:22:43 -0400
Received: (qmail invoked by alias); 05 Aug 2009 21:22:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 05 Aug 2009 23:22:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RNr1ZnkyRitt6SJayOzgA0w0KF60F2Wlqo0kFyl
	PgwIRGndCv81u5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908051708060.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124991>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > 
> > > This command, supported if the "import" capability is advertized,
> > > allows a helper to support fetching by outputting a git-fast-import
> > > stream.
> > 
> >   If both the "import" and the "fetch" capability are advertised, the 
> >   "import" capability is ignored.
> 
> The transport code notices that both are supported; it just doesn't use 
> the less convenient one. It would be wrong for helpers to advertize both 
> and depend on only "fetch" being used. (For example, there's no reason 
> that hg couldn't use one of these helpers and use the "import" capability 
> despite the "fetch" capability also being advertized, because "import" 
> produces results which are portable across local vcses.)

My point was not to criticize the decision.  My point was to criticize the 
absence of the comment from both commit message and documentation.

Ciao,
Dscho
