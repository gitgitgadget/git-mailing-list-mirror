From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CVS-$Id:$ replacement in git?
Date: Fri, 31 Aug 2007 18:12:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311812000.28586@racer.site>
References: <46D82DC3.2030203@bioinf.uni-sb.de> <Pine.LNX.4.64.0708311732580.28586@racer.site>
 <7v8x7r1wyy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRA38-0000Ot-Rb
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 19:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965380AbXHaRMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 13:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965379AbXHaRMm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 13:12:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:60113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965361AbXHaRMl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 13:12:41 -0400
Received: (qmail invoked by alias); 31 Aug 2007 17:12:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 31 Aug 2007 19:12:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18y9cpa0gwyNedYLItpDAfxM05r+9TywrbzpLkvks
	QX0zMsLaW5Lsvi
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x7r1wyy.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57191>

Hi,

On Fri, 31 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 31 Aug 2007, Andreas Hildebrandt wrote:
> >
> >> But unfortunately, we internally rely heavily on the $Id:$ - expansion 
> >> of CVS, that is the ability to have a line like
> >> 
> >> $Id:$
> >> 
> >> in the source file expanded to something like
> >> 
> >> $Id: HINFile.C,v 1.64 2005/02/09 13:02:41 oliver Exp $
> >> 
> >> The information we want to store in the file would be something like the 
> >> SHA1 of the last commit that touched that file, the date when it 
> >> happened and the person who commited it.
> >
> > Please see Documentation/gitattributes.txt, look for 'ident'.
> 
> Please do _not_ see that.  ident is about blob object name and
> does not have anything to do with the commit, pathname,
> committer, nor date, and this is deliberately so.

But this is what I was suggesting...  To change the ways for the better.  
I admit that I was really sneaky about it.

Ciao,
Dscho
