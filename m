From: Jeff King <peff@peff.net>
Subject: Re: git diff bug?
Date: Fri, 3 Apr 2009 21:52:42 -0400
Message-ID: <20090404015242.GA13932@coredump.intra.peff.net>
References: <m2ocvdkyul.fsf@boostpro.com> <20090404014527.GA13350@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 03:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpv5d-0004ZF-Mz
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 03:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764593AbZDDBxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 21:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762258AbZDDBxA
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 21:53:00 -0400
Received: from peff.net ([208.65.91.99]:54902 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbZDDBw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 21:52:59 -0400
Received: (qmail 2651 invoked by uid 107); 4 Apr 2009 01:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 21:53:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 21:52:42 -0400
Content-Disposition: inline
In-Reply-To: <20090404014527.GA13350@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115570>

On Fri, Apr 03, 2009 at 09:45:27PM -0400, Jeff King wrote:

> This is as designed. The original file ("git show e7dd7db") contains (my
> numbering seems different than what git produces; it is produced by "nl"
> which is maybe treating some line endings differently earlier in the
> file):

Sorry, this was just me failing to use "nl" correctly. I needed to use
"-ba" to number empty lines. So the line numbers do match git, and the
rest of my explanation holds.

-Peff
