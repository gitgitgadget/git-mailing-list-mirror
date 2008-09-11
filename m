From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 19:01:17 -0400
Message-ID: <20080911230117.GA4194@coredump.intra.peff.net>
References: <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu> <20080911214650.GB3187@coredump.intra.peff.net> <20080911225648.GC29559@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:02:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvBE-0001gG-Mf
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbYIKXBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbYIKXBU
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:01:20 -0400
Received: from peff.net ([208.65.91.99]:3034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYIKXBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:01:20 -0400
Received: (qmail 6512 invoked by uid 111); 11 Sep 2008 23:01:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Sep 2008 19:01:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2008 19:01:17 -0400
Content-Disposition: inline
In-Reply-To: <20080911225648.GC29559@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95662>

On Fri, Sep 12, 2008 at 12:56:48AM +0200, Stephen R. van den Berg wrote:

> Well, the usual way to fix this is to actually startup fetch and tell it
> to try and fetch all the weak links (or just fetch a single hash (the
> offending origin link)) from upstream; this is by no means the default
> operatingmode of fetch, but I don't see any harm in allowing to fetch
> those if one really wants to.

Maybe I am misremembering the details of fetching, but I believe you
cannot fetch an arbitrary SHA-1, and that is by design. So:

  1. You would have to argue the merits of changing that design. I
     believe the rationale relates to exposing some subset of the
     content via refs, but I have personally never felt that is very
     compelling.

  2. Even if we did make a change, that means that _both_ sides need the
     upgraded version.

-Peff
