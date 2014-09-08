From: Jeff King <peff@peff.net>
Subject: Re: Check out git-author
Date: Mon, 8 Sep 2014 01:19:56 -0400
Message-ID: <20140908051956.GA8987@peff.net>
References: <0a3b0f232ec56517d4db43c6bd6ebb63@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: xmeng <xmeng@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Mon Sep 08 07:20:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQrNF-00028W-81
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 07:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbaIHFUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 01:20:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:45401 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751202AbaIHFT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 01:19:59 -0400
Received: (qmail 6884 invoked by uid 102); 8 Sep 2014 05:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Sep 2014 00:19:59 -0500
Received: (qmail 29147 invoked by uid 107); 8 Sep 2014 05:20:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Sep 2014 01:20:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Sep 2014 01:19:56 -0400
Content-Disposition: inline
In-Reply-To: <0a3b0f232ec56517d4db43c6bd6ebb63@cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256632>

On Sun, Sep 07, 2014 at 06:05:13PM -0500, xmeng wrote:

> The problem with git-blame is that it only reports the last author/commit
> that changed the line, regardless of the magnitude of the change. Sometimes,
> the last author may only change a tiny part of the code and should not be
> blamed. I developed a built-in tool called "git-author" to address this
> problem. Git-author is designed to track the complete development history of
> a line. For the same line of code:
> 
> $ git author -c -L 2235,2235 fs/ext4/mballoc.c
> [...]

Have you tried "git log -L 2235,2235:fs/ext4/mballoc.c --
fs/ext4/mballoc.c"? Can you compare your approach to that of "log -L"?

-Peff
