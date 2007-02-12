From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Tue, 13 Feb 2007 00:53:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702130053200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
 <20070211224158.GA31488@spearce.org> <7v64a782ht.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130037530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070212234212.GB30967@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkzK-0004JV-Lf
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbXBLXxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbXBLXxe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:53:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:57731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030484AbXBLXxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:53:33 -0500
Received: (qmail invoked by alias); 12 Feb 2007 23:53:32 -0000
X-Provags-ID: V01U2FsdGVkX19YVnNEC8tYgge8t/M1U7xvY45VFMcSEMXRMGtr7e
	LVWg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070212234212.GB30967@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39462>

Hi,

On Mon, 12 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 12 Feb 2007, Junio C Hamano wrote:
> > 
> > > Ok, so here is what I did last night.
> > > 
> > > $ git remote show git-gui
> > > * remote git-gui
> > >   URL: git://repo.or.cz/git-gui.git/
> > >   Tracked remote branches
> > >     master
> > > $ git fetch git-gui
> > > $ git read-tree --prefix=git-gui/ git-gui/master
> > > $ git checkout git-gui
> > 
> > Didn't you mean "git checkout master" here?
> 
> I don't think so.  At this point the subdirectory git-gui is known
> in the index, so Junio is trying to get checkout-index to process
> those paths and create it in the working directory.

Ah! Thanks,
Dscho
