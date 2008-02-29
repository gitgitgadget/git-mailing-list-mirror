From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 19/40] Windows: Change the name of hook scripts to make
 them not executable.
Date: Fri, 29 Feb 2008 01:11:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290110320.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-20-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281519300.22527@racer.site> <200802282148.47485.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtna-0000hT-J0
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763356AbYB2BLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763222AbYB2BLj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:11:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:35015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763011AbYB2BLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:11:38 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:11:36 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp053) with SMTP; 29 Feb 2008 02:11:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Gn5koR+wGn2IGl6UJJgZyUQ3tY993UArmCUTFtF
	h52AAvoZHnpmIV
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282148.47485.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75481>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 16:20, Johannes Schindelin wrote:
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > > -		*) cp $$boilerplate blt/$$dst ;; \
> > > +		*) if test -n "$$(sed -ne '/^#!\//p' -e '1q' < "$$boilerplate")"; then
> > > \ +			cp "$$boilerplate" "blt/$${dst}$(NOEXECTEMPL)"; \
> > > +		   else \
> > > +			cp "$$boilerplate" "blt/$$dst"; \
> > > +		   fi ;; \
> >
> > Why not just append .noexec to all of the hooks?
> 
> Because some of the files are not hooks.

Then you have to make sure even more urgently that only the hooks are 
treated that way.

Ciao,
Dscho

