From: Jeff King <peff@peff.net>
Subject: Re: git-svn questions
Date: Mon, 1 Aug 2011 12:12:42 -0600
Message-ID: <20110801181242.GC10636@sigill.intra.peff.net>
References: <29920-1312210883-194720@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwyz-0004U5-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab1HASMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:12:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35055
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab1HASMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:12:45 -0400
Received: (qmail 21810 invoked by uid 107); 1 Aug 2011 18:13:18 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 14:13:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 12:12:42 -0600
Content-Disposition: inline
In-Reply-To: <29920-1312210883-194720@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178388>

On Mon, Aug 01, 2011 at 10:01:17AM -0500, John M. Dlugosz wrote:

> I want to introduce git to a project that's currently using svn.
> I used svn git with no problems.  But someone else trying the same
> steps runs into authentication issues.
> How did mine "just know" what my username for SVN is?  I'm using
> Tortoise-svn and it remembers (I only ever signed in once, when I set
> it up), but so is he.
> 
> We are on windows, using msysgit.

I believe SVN will cache your username (and optionally password, in
cleartext!) forever in ~/.subversion/auth. I have no idea if Tortoise
writes to the same area or not.  Are you sure you never ran "svn" from
the command-line, in addition to running Tortoise?

Just a guess. I know very little about how svn works in this respect. :)

-Peff
