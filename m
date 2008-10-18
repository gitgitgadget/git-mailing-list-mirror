From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] feature request: git-mergetool --force
Date: Sat, 18 Oct 2008 11:48:24 -0400
Message-ID: <20081018154824.GA20185@coredump.intra.peff.net>
References: <48F91E59.50202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 17:49:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrE3h-0003d5-AZ
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 17:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbYJRPs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 11:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbYJRPs3
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 11:48:29 -0400
Received: from peff.net ([208.65.91.99]:1055 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYJRPs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 11:48:28 -0400
Received: (qmail 2218 invoked by uid 111); 18 Oct 2008 15:48:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 18 Oct 2008 11:48:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2008 11:48:24 -0400
Content-Disposition: inline
In-Reply-To: <48F91E59.50202@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98554>

On Sat, Oct 18, 2008 at 12:23:05AM +0100, William Pursell wrote:

> I occasionally use commands like 'cp $REMOTE $MERGED' with
> mergetool, and would prefer to not be prompted to start
> the tool on each file.  A --force option would be handy.

I think it is reasonable to want to skip this prompt, but I am not sure
"--force" is the right name for such an option. Usually we reserve
--force for "the tool is trying to prevent something destructive or
unusual, and the user wants to override it".

Something like --no-prompt makes more sense to me, though probably
something a little easier to type would be nice (or maybe alias "-n").

-Peff
