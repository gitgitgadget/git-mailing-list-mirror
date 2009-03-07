From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-forest on msysgit
Date: Sat, 7 Mar 2009 03:54:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903070352580.10279@pacific.mpi-cbg.de>
References: <450196A1AAAE4B42A00A8B27A59278E70A115F15@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfmgn-00023W-Fz
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZCGCxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZCGCxR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:53:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:50656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753203AbZCGCxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 21:53:16 -0500
Received: (qmail invoked by alias); 07 Mar 2009 02:53:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 07 Mar 2009 03:53:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qZ/EMDAUqC+J2OWzNJTxsC3EllAJuPsif4Oph8z
	Z6NSz/QqaIZndW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A115F15@EXCHANGE.trad.tradestation.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112508>

Hi,

Note: this is pretty much obviously the wrong mailing list for 
msysGit-related issues.

On Fri, 6 Mar 2009, John Dlugosz wrote:

> I downloaded git-forest, and when I run it I get:
> 
> Can't locate loadable object for module Encode in @INC (@INC contains:
> /usr/lib/perl5/5.8.8/msys /usr/lib/perl5/5.8.8 /usr/lib/perl5
> /site_perl/5.8.8/msys /usr/lib/perl5/site_perl/5.8.8
> /usr/lib/perl5/site_perl .) at /usr/lib/perl5/5.8.8/msys/encoding.pm
> line 5
> 
> The line 5 in encoding.pm reads "use Encode;" and there is an Encode.pm
> on the path, and in Encode.pm it uses XSLoader.  However, in the XS
> subdirectory in the same directory as Encode.pm, I see only 2 files and
> neither of them has to do with encoding.  So I'm guessing I'm missing a
> file.

You can try recompiling git-svn.  Maybe I forgot to commit a file.

> I wonder if I can just copy it from somewhere, like someone's Linux 
> build?

How do you expect a Linux-specific binary object to be usable on Windows?

Hth,
Dscho
