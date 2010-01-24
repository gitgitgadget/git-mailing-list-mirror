From: Jeff King <peff@peff.net>
Subject: Re: basic question about push
Date: Sun, 24 Jan 2010 03:15:14 -0500
Message-ID: <20100124081513.GA10700@coredump.intra.peff.net>
References: <loom.20100124T074722-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Russ Paielli <Russ.Paielli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 09:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYxd2-0001F1-12
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 09:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab0AXIPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 03:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118Ab0AXIPW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 03:15:22 -0500
Received: from peff.net ([208.65.91.99]:44298 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab0AXIPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 03:15:21 -0500
Received: (qmail 15424 invoked by uid 107); 24 Jan 2010 08:20:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 24 Jan 2010 03:20:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2010 03:15:14 -0500
Content-Disposition: inline
In-Reply-To: <loom.20100124T074722-510@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137886>

On Sun, Jan 24, 2010 at 07:04:59AM +0000, Russ Paielli wrote:

> warning: updating the current branch         
> [...]
> What does this mean in English? And what is the correct way to transfer my
> revisions from my home computer to my work computer? Thanks.

It means your workflow will cause problems as the pusher magically
changes your repository's concept of "the latest commit" behind the
pushee's back. The workflow you want is described here:

  http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-fetch

-Peff
