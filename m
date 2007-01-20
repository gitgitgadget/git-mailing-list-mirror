From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Sat, 20 Jan 2007 10:24:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701201023460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <20070120033149.GB11200@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 10:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8CTH-00078b-N2
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 10:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbXATJYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 04:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbXATJYw
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 04:24:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:34981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965234AbXATJYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 04:24:51 -0500
Received: (qmail invoked by alias); 20 Jan 2007 09:24:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 20 Jan 2007 10:24:49 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070120033149.GB11200@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37259>

Hi,

On Fri, 19 Jan 2007, Shawn O. Pearce wrote:

> Johannes Sixt <johannes.sixt@telecom.at> wrote:
> > I've been working on a MinGW port for some time now. I've pushed out what I 
> > have so far to a git.git fork at repo.or.cz. For details on how and what to 
> > clone, please look at the top of
> 
> Can I make a few suggestions?
> 
> Base your branch on Junio's 'master', not 'next'.

Blame me, not Johannes ;-)

As for the #ifdef stuff, I'd rather have a look if it can't be done 
cleanly by conditional compiling, like we do for NO_MMAP, for example.

Ciao,
Dscho
