From: Jeff King <peff@peff.net>
Subject: Re: post-checkout hook not run on clone
Date: Tue, 3 Mar 2009 00:10:26 -0500
Message-ID: <20090303051026.GA21101@coredump.intra.peff.net>
References: <20273.1236033817@relay.known.net> <20090303042848.GC18136@coredump.intra.peff.net> <23978.1236056549@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeMvC-00083e-Ni
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbZCCFKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 00:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbZCCFKf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:10:35 -0500
Received: from peff.net ([208.65.91.99]:35421 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZCCFKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 00:10:34 -0500
Received: (qmail 12434 invoked by uid 107); 3 Mar 2009 05:10:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 00:10:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 00:10:26 -0500
Content-Disposition: inline
In-Reply-To: <23978.1236056549@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111998>

On Mon, Mar 02, 2009 at 09:02:29PM -0800, layer wrote:

> The hook in question was in /usr/share/git-core/templates/hooks/, so
> it would get setup on clone.  That works fine.  If I immediately
> switch branches, the hook gets called.  It's just the `post-clone'
> (when I assume something like `checkout' is done), the hook doesn't
> get called.

Ah, OK. I misunderstood. Then that is a bug, IMHO. Patch in a minute.

-Peff
