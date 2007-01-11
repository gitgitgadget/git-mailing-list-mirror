From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 10:59:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111057110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701110941.22024.andyparkins@gmail.com> <20070111095046.GA28309@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wiR-0004so-Cy
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbXAKJ7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965356AbXAKJ7V
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:59:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:35537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965353AbXAKJ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:59:20 -0500
Received: (qmail invoked by alias); 11 Jan 2007 09:59:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 11 Jan 2007 10:59:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070111095046.GA28309@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36572>

Hi,

On Thu, 11 Jan 2007, Shawn O. Pearce wrote:

> That said I don't really care about this problem that much. The problem 
> that I care about is its far too easy to convert the lineendings in a 
> file (e.g. CRLF->LF, LF->CRLF).  This causes the entire file to differ, 
> making merges very difficult.  I really should just fix it (in the one 
> place where it matters to me) by modifying the pre-commit hook to look 
> for such a case and abort.

Why not just introduce a config variable, and do the conversion in-flight?

Or, alternatively, do the merge ignoring white space? (Of course, this is 
somewhat pointless when merging whitespace fixes...)

Ciao,
Dscho
