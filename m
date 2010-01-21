From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git notes: notes
Date: Thu, 21 Jan 2010 04:59:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001210457380.4985@pacific.mpi-cbg.de>
References: <20100120050343.GA12860@gnu.kitenet.net> <201001201148.11701.johan@herland.net> <20100120182438.GB31507@gnu.kitenet.net> <201001210305.05309.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 04:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXo9J-0006N0-E7
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 04:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab0AUDxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 22:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134Ab0AUDxy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 22:53:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:42811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751961Ab0AUDxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 22:53:53 -0500
Received: (qmail invoked by alias); 21 Jan 2010 03:53:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 21 Jan 2010 04:53:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JgONsOhnJYIIG+07MeEmvpq+MX45FY7D4MwHUsP
	Ur8OMrQqTPGbXw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <201001210305.05309.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137624>

Hi,

On Thu, 21 Jan 2010, Johan Herland wrote:

> On Wednesday 20 January 2010, Joey Hess wrote:
>
> > Did you consider having -m append a line to an existing note?
> 
> Hmm. Not really. The "git notes" porcelain was originally written by 
> Dscho, and my builtin-ification of it (currently in 'pu') preserves the 
> original semantics of "git notes edit -m". It might make sense to change 
> the defaults; what do you think, Dscho?

I do not really care as long as there is a nice way to edit the complete 
note interactively.

Of course, I _do_ expect people to get confused just like they do with the 
current inconsistencies: "git commit -m" does not really append, but set 
the commit message, even if you amend a commit.

So maybe you want to use a different command line option for that.

Ciao,
Dscho
