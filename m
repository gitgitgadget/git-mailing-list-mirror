From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Tue, 16 Jan 2007 21:30:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070116150259.GA2439@cepheus>
 <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070116162645.GA18894@informatik.uni-freiburg.de> <20070116200847.GB29100@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 21:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uwr-0000x3-5C
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 21:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXAPUaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 15:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXAPUaW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 15:30:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:52066 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751446AbXAPUaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 15:30:22 -0500
Received: (qmail invoked by alias); 16 Jan 2007 20:30:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 16 Jan 2007 21:30:15 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070116200847.GB29100@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36961>

Hi,

On Tue, 16 Jan 2007, Shawn O. Pearce wrote:

> Uwe Kleine-K?nig <zeisberg@informatik.uni-freiburg.de> wrote:
> > Exactly.  Quoting git-send-pack(1):
> > 
> > 	Path to the git-receive-pack program on the remote end.
> > 	Sometimes useful when pushing to a remote repository over ssh,
> > 	and you do not have the program in a directory on the default
> > 	$PATH.
> > 
> > For me it would be:
> > 
> > 	pushexec = /home/zeisberg/usr/bin/git-receive-pack
> > 
> > While having /home/zeisberg/usr/bin only in my PATH for interactive
> > shells.  (Yes I know I could expand my PATH which .<someshrc>, but I'd
> > prefer it that way.)
> 
> Some of us have UNIX accounts where our shell is the (retarded)
> /usr/bin/ksh on Solaris.  And where the SSH daemon won't seem to
> let us set PATH, and where Git isn't in the PATH.  This leaves
> us with some difficulty in pointing Git at itself on the remote
> system.

Okay, I see your point now.

Ciao,
Dscho
