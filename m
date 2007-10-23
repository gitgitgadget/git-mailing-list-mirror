From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Total different
 idea to solve the problem)
Date: Tue, 23 Oct 2007 12:13:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710231213140.25221@racer.site>
References: <1192351494.7226.18.camel@athena> <20071022204719.GA23348@xp.machine.xx>
 <Pine.LNX.4.64.0710230054130.25221@racer.site> <20071023053401.GB9330@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Tobin <korpios@korpios.com>, Dan Zwell <dzwell@gmail.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 13:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkHiJ-00024V-IC
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 13:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXJWLOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 07:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXJWLOK
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 07:14:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751846AbXJWLOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 07:14:09 -0400
Received: (qmail invoked by alias); 23 Oct 2007 11:14:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 23 Oct 2007 13:14:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hZnwpqshhkgQOTg5WunyPTvKloy+GhBzPKRpQpi
	SfNgc8ejKmea8B
X-X-Sender: gene099@racer.site
In-Reply-To: <20071023053401.GB9330@xp.machine.xx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62127>

Hi,

On Tue, 23 Oct 2007, Peter Baumann wrote:

> On Tue, Oct 23, 2007 at 12:55:44AM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 22 Oct 2007, Peter Baumann wrote:
> > 
> > > Wouldn't it make more sense to implement the diff coloring inside 
> > > git apply so that you could use something like
> > > 
> > >         diff file1 file2|git apply --color
> > > 
> > > to make the generated diff with colors [1]? It already implements 
> > > the same semantic for generating a diffstat, using
> > > 
> > >         diff file1 file2|git apply --stat
> > 
> > No.  In both cases, "git diff" realises that the output is no terminal, 
> > and switches off color generation.  (Just try with diff.color=true instead 
> > of =auto.)
> > 
> 
> I didn't mean git-diff here, instead I meant diff, so no coloring involved
> on the diff side. The git-apply would be enhanced to do the coloring on
> every diff it gets on its STDIN.

Ah!  I completely misunderstood indeed.  Clever...

Ciao,
Dscho
