From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 12:19:12 -0400
Message-ID: <20080912161911.GA12096@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu> <20080912155427.GB2915@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBNg-0008HC-3Y
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbYILQTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYILQTP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:19:15 -0400
Received: from peff.net ([208.65.91.99]:2129 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYILQTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:19:14 -0400
Received: (qmail 13089 invoked by uid 111); 12 Sep 2008 16:19:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 12 Sep 2008 12:19:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Sep 2008 12:19:12 -0400
Content-Disposition: inline
In-Reply-To: <20080912155427.GB2915@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95748>

On Fri, Sep 12, 2008 at 05:54:27PM +0200, Stephen R. van den Berg wrote:

> True.  But repopulating this cache after cloning means that you have to
> calculate the patch-id of *every* commit in the repository.  It sounds
> like something to avoid, but maybe I'm overly concerned, I have only a
> vague idea on how computationally intensive this is.

For a rough estimate, try:

  time git log -p | git patch-id >/dev/null

-Peff
