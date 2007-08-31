From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CVS-$Id:$ replacement in git?
Date: Fri, 31 Aug 2007 17:33:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311732580.28586@racer.site>
References: <46D82DC3.2030203@bioinf.uni-sb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9Rg-0005I7-7L
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759619AbXHaQeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759515AbXHaQeF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:34:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:42008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759201AbXHaQeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:34:02 -0400
Received: (qmail invoked by alias); 31 Aug 2007 16:34:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 31 Aug 2007 18:34:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vrilB7F2vwpYSG2rnj6Wzm6boKwsGXEwyJykVxZ
	rWsyXE1dUE6rEE
X-X-Sender: gene099@racer.site
In-Reply-To: <46D82DC3.2030203@bioinf.uni-sb.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57185>

Hi,

On Fri, 31 Aug 2007, Andreas Hildebrandt wrote:

> But unfortunately, we internally rely heavily on the $Id:$ - expansion 
> of CVS, that is the ability to have a line like
> 
> $Id:$
> 
> in the source file expanded to something like
> 
> $Id: HINFile.C,v 1.64 2005/02/09 13:02:41 oliver Exp $
> 
> The information we want to store in the file would be something like the 
> SHA1 of the last commit that touched that file, the date when it 
> happened and the person who commited it.

Please see Documentation/gitattributes.txt, look for 'ident'.

Hth,
Dscho
