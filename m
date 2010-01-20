From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git status: do not require write permission
Date: Wed, 20 Jan 2010 01:35:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001200134380.3164@intel-tinevez-2-302>
References: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302> <20100120002836.GA16824@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXOY1-0005P3-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 01:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab0ATAfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240Ab0ATAfp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 19:35:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:39434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932108Ab0ATAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 19:35:45 -0500
Received: (qmail invoked by alias); 20 Jan 2010 00:35:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 20 Jan 2010 01:35:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XKZM81acXTXYHBFL5NgyhRt4cLTYEFBcB57xJ6W
	U/ErvGyPwqV+7w
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100120002836.GA16824@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137506>

Hi,

On Tue, 19 Jan 2010, Jeff King wrote:

> On Wed, Jan 20, 2010 at 01:06:17AM +0100, Johannes Schindelin wrote:
> 
> > Today, git status played violin on my nerves for the very last time.
> > There is no good reason, really none, for git status to require
> > write permissions.  If the index is not up-to-date, so be it, I
> > cannot commit anyway.
> 
> I agree it is annoying, but this patch does not apply (and is no longer
> needed) on master since the status-is-no-longer-commit-dry-run series
> has been merged.

I was working on top of 'next'.  And only after I fetched afresh from 
git://repo.or.cz/git.git/.

So for me and my nerves, the patch series came way too late.

Ciao,
Dscho
