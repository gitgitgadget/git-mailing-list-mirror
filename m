From: Jeff King <peff@peff.net>
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Mon, 15 Dec 2008 23:07:22 -0500
Message-ID: <20081216040722.GA4551@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0812160153340.14632@racer> <87oczcx6ky.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Dec 16 05:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCREh-0000Ce-Aq
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 05:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYLPEHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 23:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYLPEHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 23:07:25 -0500
Received: from peff.net ([208.65.91.99]:3451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYLPEHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 23:07:25 -0500
Received: (qmail 10220 invoked by uid 111); 16 Dec 2008 04:07:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Dec 2008 23:07:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2008 23:07:22 -0500
Content-Disposition: inline
In-Reply-To: <87oczcx6ky.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103244>

On Tue, Dec 16, 2008 at 09:16:29AM +0800, jidanni@jidanni.org wrote:

> JK> The usual workaround is to ask the pager to exit immediately if the
> JK> output is small. I.e., putting "F" in your LESS variable (which git does
> JK> automatically if you don't already have LESS set).
> 
> Ah, but who doesn't have LESS set these days? OK, the man page should
> mention that so people will put the F on their LESS variable, like I
> recall another man page already does.

Not unreasonable. Care to make a patch to the documentation?

-Peff
