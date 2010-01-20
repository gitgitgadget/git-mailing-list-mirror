From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git status: do not require write permission
Date: Wed, 20 Jan 2010 02:23:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001200220570.4985@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302> <20100120002836.GA16824@coredump.intra.peff.net> <7vhbqh7gpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXPCs-0001fB-J4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 02:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630Ab0ATBR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 20:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613Ab0ATBR6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 20:17:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:56611 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755469Ab0ATBR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 20:17:57 -0500
Received: (qmail invoked by alias); 20 Jan 2010 01:17:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 20 Jan 2010 02:17:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xOWlLc4+xKTherQBsyiFMNm/+2qdIz6k+rld5sZ
	UzkdLQEIeUtKIq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhbqh7gpa.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137513>

Hi,

On Tue, 19 Jan 2010, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jan 20, 2010 at 01:06:17AM +0100, Johannes Schindelin wrote:
> >
> >> Today, git status played violin on my nerves for the very last time.
> >> There is no good reason, really none, for git status to require
> >> write permissions.  If the index is not up-to-date, so be it, I
> >> cannot commit anyway.
> >
> > I agree it is annoying, but this patch does not apply (and is no longer
> > needed) on master since the status-is-no-longer-commit-dry-run series
> > has been merged.
> >
> > I don't know if it is worth putting your fix onto maint.
> 
> I think the patch itself makes sense, even though the log message seems to
> be with more noise and frustrationthan with useful information.

If you think so.

> And "for the very last time" is probably a good characterization, as
> status will no longer be "commit --dry-run" in the coming release ;-)

This comment was because I was fully prepared to do the same as with so 
many patches: keep them in my personal repository until time finally tells 
that that patch should go into 'next'.

And as you realized, I managed to forget a commit --amend, which would 
have replaced 1 with !is_status.

BTW you can tell me directly that you do not want any patches from me 
anymore, rather than dancing around the issue.  I kind of figured that 
already anyway.

Ciao,
Dscho
