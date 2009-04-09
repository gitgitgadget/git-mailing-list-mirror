From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow setting default diff options via
 diff.defaultOptions
Date: Thu, 9 Apr 2009 10:45:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpsN-0001y9-6C
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758292AbZDIInK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758021AbZDIInJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:43:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:49212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757821AbZDIInG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:43:06 -0400
Received: (qmail invoked by alias); 09 Apr 2009 08:43:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 09 Apr 2009 10:43:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196rj8S19F6HnjzdlUj+QGNKf7baB3A2jolKQVTRw
	YArrE+aUAxOemP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116152>

Hi,

On Thu, 2 Apr 2009, Keith Cascio wrote:

> On Sat, 21 Mar 2009, Johannes Schindelin wrote:
> 
> > The idea is from Keith Cascio.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 	I do not particularly like what this patch does, but I like
> > 	the non-intrusiveness and conciseness of it.
> 
> Your patch does not provide a command line opt_out flag.  Let me describe a 
> workflow situation and ask you how to handle it if the user were running your 
> patch.  Let diff.defaultOptions = "-b".  The user is getting closer to 
> submitting his patch and he wants to see patch output identical to what `git format-patch`
> will produce.  What command should he use?
> 
>       `git format-patch --stdout master` ?

The proper way would be to have options to _undo_ every diff option, I 
guess, as this would also help aliases in addition to defaultOptions.

In the case of format-patch, though, I am pretty certain that I do not 
want any diff.defaultOptions: the output is almost always intended for 
machine consumption, so it is a different kind of cattle.

Now, it is easy to put a patch on top of my patch to support something 
like --no-defaults.

Of course, to keep things simple, this has to be a separate patch.

Ciao,
Dscho
