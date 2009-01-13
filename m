From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Tue, 13 Jan 2009 01:40:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901130140360.3586@pacific.mpi-cbg.de>
References: <87wsd48wam.fsf@iki.fi> <200901101436.48149.jnareb@gmail.com> <alpine.DEB.1.00.0901101507590.30769@pacific.mpi-cbg.de> <200901130059.19511.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXLR-00064T-LA
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbZAMAkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbZAMAkF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:40:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:58890 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751491AbZAMAkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:40:03 -0500
Received: (qmail invoked by alias); 13 Jan 2009 00:40:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 13 Jan 2009 01:40:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IWgU1PxBIkuWTlzQOjlELTtoP+YVtUvcxBpKFeU
	wRj36xs8ucKN0O
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901130059.19511.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105425>

Hi,

On Tue, 13 Jan 2009, Jakub Narebski wrote:

> On Sat, 10 Jan 2009, Johannes Schindelin wrote:
> > On Sat, 10 Jan 2009, Jakub Narebski wrote:
> >> On Sat, 10 Jan 2009, Johannes Schindelin wrote:
> >>> On Sat, 10 Jan 2009, Jakub Narebski wrote:
> >>>> Thomas Rast wrote:
> >>>> 
> >>>>> --color-words works (and always worked) by splitting words onto one
> >>>>> line each, and using the normal line-diff machinery to get a word
> >>>>> diff. 
> >>>> 
> >>>> Cannot we generalize diff machinery / use underlying LCS diff engine
> >>>> instead of going through line diff?
> >>> 
> >>> What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
> >>> That's why we're substituting non-word characters with newlines.
> >> 
> >> Isn't Meyers algorithm used by libxdiff based on LCS, largest common
> >> subsequence, and doesn't it generate from the mathematical point of
> >> view "diff" between two sequences (two arrays) which just happen to
> >> be lines? It is a bit strange that libxdiff doesn't export its low
> >> level algorithm...
> > 
> > Umm.
> > 
> > It _is_ Myers' algorithm.  It just so happens that libxdiff hardcodes 
> > newline to be the separator.
> 
> So amd I to understand that _exported_ functions hardcode separator
> to be newline (most probably for performance), and there is no function
> in libxdiff which calculates LCS, or returns diff for arrays
> (sequences)?

That is my understanding, yes.

Ciao,
Dscho
