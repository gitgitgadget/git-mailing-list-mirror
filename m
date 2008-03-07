From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Fri, 7 Mar 2008 01:12:23 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803070112050.3941@racer.site>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site> <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 01:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXQCs-0006yl-6p
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 01:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbYCGAMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 19:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYCGAMY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 19:12:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:36415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752641AbYCGAMX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 19:12:23 -0500
Received: (qmail invoked by alias); 07 Mar 2008 00:12:21 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp038) with SMTP; 07 Mar 2008 01:12:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vanEHSMPvqpM7tea0/2oqXjMrG+FtwE76IH+4Kb
	NvsWhysGMd4UTz
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76436>

Hi,

On Thu, 6 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > At least on one of my machines, Term::ReadLine tries to be clever and
> > sends \x1b\x5b1034h at the end of the script when TERM is set to 'xterm'.
> >
> > To prevent that, force TERM=dumb just for the test.
> 
> We try to set up a pretty vanilla environment for test repeatability in
> t/test-lib.sh, and I suspect we would simply want to do this over there.
> 
> Wouldn't this make more sense?

Sure!

Ciao,
Dscho
