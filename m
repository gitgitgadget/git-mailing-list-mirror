From: Jeff King <peff@peff.net>
Subject: git-* in test scripts (was On deprecating "git-foo" for builtins)
Date: Thu, 28 Aug 2008 19:41:51 -0400
Message-ID: <20080828234151.GG29609@coredump.intra.peff.net>
References: <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <20080828230401.GC29609@coredump.intra.peff.net> <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYr8j-0006aY-IZ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYH1Xlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYH1Xlx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:41:53 -0400
Received: from peff.net ([208.65.91.99]:3613 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbYH1Xlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:41:53 -0400
Received: (qmail 9353 invoked by uid 111); 28 Aug 2008 23:41:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:41:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:41:51 -0400
Content-Disposition: inline
In-Reply-To: <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94214>

On Thu, Aug 28, 2008 at 04:24:50PM -0700, Junio C Hamano wrote:

> Test scripts are executed in a special environment whose GIT_EXEC_PATH
> points at the top of the build tree, where all git-foo lives.

I am not sure how GIT_EXEC_PATH is relevant. We put the git top-level
directory in the PATH, which is why "git-foo" works at all in the test
scripts. But the install by default does _not_ put those commands in
the PATH. So the test scripts serve as a poor example of how to use
git. The commands contained within them would not run in an ordinary git
installation.

-Peff
