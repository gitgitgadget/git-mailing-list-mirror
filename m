From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 08:44:13 -0400
Message-ID: <20080930124413.GA22078@coredump.intra.peff.net>
References: <20080930080355.GA19605@sigill.intra.peff.net> <e2b179460809300410q47592f63y7f7ec626007ad838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 14:45:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkebX-0000Jd-NX
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 14:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYI3MoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYI3MoR
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:44:17 -0400
Received: from peff.net ([208.65.91.99]:1858 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYI3MoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 08:44:16 -0400
Received: (qmail 9054 invoked by uid 111); 30 Sep 2008 12:44:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 08:44:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 08:44:13 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460809300410q47592f63y7f7ec626007ad838@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97104>

On Tue, Sep 30, 2008 at 12:10:19PM +0100, Mike Ralphson wrote:

> > There is one exception for "-e" here, which is in t7701 used
> > to produce an "or" of patterns. This can be rewritten as an
> > egrep pattern.
> >
> > This patch also removes use of "grep -F" in favor of the
> > more widely available "fgrep".
> 
> Works here too (AIX 5.3)
> 
> Tested-by: Mike Ralphson <mike@abacus.co.uk>

Thanks Mike and Johannes. The dropping of "-e" and "-q" we had done
before, but this was our first use of egrep and fgrep. From my
(admittedly limited) knowledge, I think they are fine, but it is nice to
have some confirmation.

-Peff
