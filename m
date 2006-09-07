From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] Convert run_status to a builtin
Date: Thu, 7 Sep 2006 02:29:18 -0400
Message-ID: <20060907062917.GA16969@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:29:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDOM-0004Oc-IO
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWIGG3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWIGG3U
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:29:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:65504 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751891AbWIGG3U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 02:29:20 -0400
Received: (qmail 24790 invoked from network); 7 Sep 2006 02:28:44 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 7 Sep 2006 02:28:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  7 Sep 2006 02:29:18 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26598>

This series of patches converts the run_status function from
git-commit.sh to a C builtin. Hopefully we can use this as a starting
point for further improvements (the only feature I added was
colorization).  I haven't had a chance to look closely at the
simultaneous traversal code in pu, but that would be the nice next place
to take this concept.

Patch 1/3 adds the necessary diff callback infrastructure, which may be
of value regardless of whether the final patch is accepted.

Patch 2/3 lib-ifies the diff color support so it can be reused by
run-status. Again, I think this is worth doing anyway from a code
cleanup standpoint.

Patch 3/3 does the actual conversion.

-Peff
