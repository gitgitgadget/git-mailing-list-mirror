From: Jeff King <peff@peff.net>
Subject: Re: Has the git shell revert been done so master should work?
Date: Sun, 24 Aug 2008 13:38:04 -0400
Message-ID: <20080824173804.GA26626@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 19:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJYX-0005tI-Ei
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYHXRiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYHXRiI
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:38:08 -0400
Received: from peff.net ([208.65.91.99]:3742 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbYHXRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:38:07 -0400
Received: (qmail 12760 invoked by uid 111); 24 Aug 2008 17:38:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 13:38:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 13:38:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93539>

On Sun, Aug 24, 2008 at 07:02:38AM -0600, Boyd Lynn Gerber wrote:

> I just did a clean clone of git git and, I am still seeing failures on all 
> platforms I made work.  Has the git shell bug been reverted?  What should 
> I do to get this working again on the 12 platforms?  Do I need to submit a 
> patch that reverts the patch that caused all this?

It's in 'next' but has not yet graduated to 'master'. You can try
cherry-picking 4cfc24af into master.

-Peff
