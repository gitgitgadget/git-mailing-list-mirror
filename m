From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
 when appropriate to do so
Date: Tue, 13 Oct 2009 17:57:52 -0400
Message-ID: <20091013215751.GA12603@coredump.intra.peff.net>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
 <7vljjfuibr.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxpX4-0001jO-8J
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299AbZJMV6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbZJMV6a
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:58:30 -0400
Received: from peff.net ([208.65.91.99]:38993 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbZJMV6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:58:30 -0400
Received: (qmail 21550 invoked by uid 107); 13 Oct 2009 22:01:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Oct 2009 18:01:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Oct 2009 17:57:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130223>

On Tue, Oct 13, 2009 at 05:31:46PM -0400, Daniel Barkalow wrote:

> I personally think that the real issue is that our "detached HEAD" message 
> is still too scary, and what we really want is to issue the scary message 
> when using "git commit" to move a detached HEAD from what was checked out 
> to a new commit. So:

This has been discussed before (I happen to agree with you, but you
probably want to address other comments in the thread):

  http://thread.gmane.org/gmane.comp.version-control.git/38201/focus=38213

-Peff
