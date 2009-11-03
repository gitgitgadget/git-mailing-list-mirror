From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull --rebase and losing commits
Date: Tue, 3 Nov 2009 10:52:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se> <20091102151022.GA3995@atjola.homenet> <alpine.DEB.2.00.0911030757400.15633@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 03 10:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5G1G-0007Qh-LW
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 10:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbZKCJta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 04:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbZKCJta
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 04:49:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:60718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754178AbZKCJt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 04:49:29 -0500
Received: (qmail invoked by alias); 03 Nov 2009 09:49:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 03 Nov 2009 10:49:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188iDwDex08QI8kaA14k7lFlaYb+vUsbhi4XUZmSZ
	tu0rcfkaTrG5ch
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0911030757400.15633@ds9.cixit.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131958>

Hi,

On Tue, 3 Nov 2009, Peter Krefting wrote:

> Thomas Rast:
> 
> > Not very surprising if you use the 'ours' strategy, which doesn't merge at
> > all but instead takes the 'ours' side (IIRC that's the upstream for a
> > rebase, but I always have these mixed up).
> 
> Sounds like it should be called "theirs", then.

Why should it be called "theirs" when it takes "ours"?

Note: the thing I think Thomas wanted to clarify is that this strategy 
does not _resolve conflicts_ to "our" version, but it just outright 
ignores "theirs".  IOW, after a merge with the "ours" strategy, 
"HEAD^{tree}" and "HEAD^^{tree}" will point to _exactly the same object_.

If you want to use any merge strategy, you must understand what it does 
first.  There is no way around that.  No change in UI, or in the core code 
of Git, can relieve you of this obligation.

Ciao,
Dscho
