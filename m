From: Jeff King <peff@peff.net>
Subject: Re: remote branches, and branch names in general
Date: Wed, 4 Mar 2009 05:29:03 -0500
Message-ID: <20090304102903.GA16123@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com> <m3vdqrtp84.fsf@localhost.localdomain> <20090303041631.GB18136@coredump.intra.peff.net> <450196A1AAAE4B42A00A8B27A59278E709F075DF@EXCHANGE.trad.tradestation.com> <20090303161117.GB32079@coredump.intra.peff.net> <76718490903031132v592b8368p6355ea2bd0cda4ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@tradestation.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeoN5-0004Ln-T0
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZCDK3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZCDK3L
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:29:11 -0500
Received: from peff.net ([208.65.91.99]:44513 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZCDK3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:29:11 -0500
Received: (qmail 23304 invoked by uid 107); 4 Mar 2009 10:29:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 05:29:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 05:29:03 -0500
Content-Disposition: inline
In-Reply-To: <76718490903031132v592b8368p6355ea2bd0cda4ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112199>

On Tue, Mar 03, 2009 at 02:32:00PM -0500, Jay Soffian wrote:

> On Tue, Mar 3, 2009 at 11:11 AM, Jeff King <peff@peff.net> wrote:
> > Yes, the "branch" command deals only with creating things in refs/heads,
> 
> Unless given -r, in which case it looks in refs/remotes, or -a, in
> which case it looks in refs/heads and refs/remotes. :-)

OK, fair enough. ;P

But I think the lesson to be learned is that there is a difference
between arbitrary ref lookup (which you might use with log, show, diff,
or even as the branching-off point for branch) and specialized commands
which assume you are working in some part of the ref hierarchy (heads,
tags, or even remotes).

-Peff
