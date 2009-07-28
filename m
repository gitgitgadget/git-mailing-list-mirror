From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 15:27:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281524220.8306@pacific.mpi-cbg.de>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch> <200907281353.07590.trast@student.ethz.ch> <alpine.DEB.1.00.0907281428220.8306@pacific.mpi-cbg.de> <200907281511.10010.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:27:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVmid-0001y1-Vl
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZG1N1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbZG1N1r
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:27:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:47028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754127AbZG1N1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:27:46 -0400
Received: (qmail invoked by alias); 28 Jul 2009 13:27:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 28 Jul 2009 15:27:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18z5/ZOpGMzu9FJsLcRfxnEBApO/+MdayVzgdfSL+
	2elbC8Fbasy+3W
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200907281511.10010.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124249>

Hi,

On Tue, 28 Jul 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > Inspecting reflogs is an interactive task, and I do not think that 
> > this justifies the complications you suggested.  I can _easily_ say 
> > "git log -g" and then "git show --date=relative <commit>".  Not that I 
> > _ever_ needed such a thing.
> 
> That's something entirely different.

No, it's not.  The '--date=<format>' option was always about the commit 
dates.  It was just DWIMed in the context of '--reflog' to mean "show me 
the dates in the reflogs, too".

As such, I think having '--no-date' switch that DWIM off (and reverting to 
default date format for the commit dates) is perfectly acceptable and 
consistent.

Having DATE_NORMAL and DATE_DEFAULT do exactly the same thing -- except in 
the presence of '--reflog' -- is nothing I want to see in Git.  It is 
inconsistent, unintuitive and confusing.

I could live with switching off the DWIMery and introducing 
'--reflog-date=<format', though but the whole point of our IRC discussion 
was to make it less painful to switch on the date-based reflogs, no?

Now, it often happened that Junio just ignored such comments of mine, and 
I had to live with the consequences.  I just hope it does not happen here.

Ciao,
Dscho
