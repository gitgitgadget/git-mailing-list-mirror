From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/8] Tests: let --valgrind imply --verbose and --tee
Date: Fri, 6 Feb 2009 20:40:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902062038420.7377@intel-tinevez-2-302>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902040026250.9822@pacific.mpi-cbg.de> <20090206190815.GB19494@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVWax-0006Io-UZ
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878AbZBFTlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756757AbZBFTlE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:41:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:48171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756578AbZBFTlB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:41:01 -0500
Received: (qmail invoked by alias); 06 Feb 2009 19:41:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 06 Feb 2009 20:41:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zdVoDm2fzUaG0RilAM7SKKbuPU5Dx1RBfRKTxbi
	35a31yOJ3yHQs+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090206190815.GB19494@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108779>

Hi,

On Fri, 6 Feb 2009, Jeff King wrote:

> On Wed, Feb 04, 2009 at 12:26:26AM +0100, Johannes Schindelin wrote:
> 
> > It does not make much sense to run the (expensive) valgrind tests and
> > not look at the output.
> > 
> > To prevent output from scrolling out of reach, the parameter --tee is
> > implied, too.
> 
> Might it not make sense to want to send the output to a file, but _not_
> show it on the terminal (e.g., running from a cron job)?

That is sh ... > file 2>&1

> But if I understand correctly, that is not actually possible with any 
> combination of "--verbose" and "--tee".

No, it is not, indeed.

> So perhaps it would make more sense to have, rather than "--tee", simply 
> "--verbose" to output to the terminal and "--save-output" (or similar) 
> to save the output. If both are requested, it is equivalent to what 
> "--tee" does now.

I do not see the point in that.

> On the other hand, I think "--verbose --tee >/dev/null" would probably 
> accomplish the same thing, so it probably isn't worth too much effort.

No.  Why would I want 'make test' to hide the fact from me that something 
did not work, and how it happened to fail?

Ciao,
Dscho
