From: Jeff King <peff@peff.net>
Subject: Re: git svn problem, probably a regression
Date: Thu, 8 Nov 2012 13:06:57 -0500
Message-ID: <20121108180657.GM15560@sigill.intra.peff.net>
References: <36370AA5-4BB9-4D36-95A7-BB3DA315C9E6@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joern Huxhorn <jhuxhorn@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWWVY-00029j-DM
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 19:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab2KHSHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 13:07:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643Ab2KHSHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 13:07:01 -0500
Received: (qmail 31462 invoked by uid 107); 8 Nov 2012 18:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 13:07:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 13:06:57 -0500
Content-Disposition: inline
In-Reply-To: <36370AA5-4BB9-4D36-95A7-BB3DA315C9E6@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209181>

On Sun, Nov 04, 2012 at 09:31:17PM +0100, Joern Huxhorn wrote:

> git svn failed on me with the following error while cloning an SVN repository:
> r1216 = fcf69d5102378ee41217d60384b96549bf2173cb (refs/remotes/svn/trunk)
> Found possible branch point: svn+ssh://<repositoryName>@<IP address>/trunk => svn+ssh://<repositoryName>@<IP address>/tags/xxxx_2008-10-22, 1216
> Use of uninitialized value $u in substitution (s///) at /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm line 106.
> Use of uninitialized value $u in concatenation (.) or string at /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm line 106.
> refs/remotes/svn/asset-manager-redesign: 'svn+ssh://<IP address>' not found in ''
> 
> I'm running git 1.8.0 via Homebrew on OS X. It was called via svn2git but I doubt that this is the culprit.
> A colleague of mine was able to perform the same operation with git 1.7.x (not sure which) on Debian so I assume that this is a regression.
> 
> I just wanted to let you know.

If you have time and can reproduce the bug at will, it would be very
helpful to use "git-bisect" to pinpoint the exact commit that causes the
breakage.

-Peff
