From: Jeff King <peff@peff.net>
Subject: Re: reflog/show question
Date: Mon, 28 Apr 2008 05:24:10 -0400
Message-ID: <20080428092410.GD16153@sigill.intra.peff.net>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:25:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPba-0006dZ-JR
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759365AbYD1JYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbYD1JYO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:24:14 -0400
Received: from peff.net ([208.65.91.99]:2319 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbYD1JYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:24:13 -0400
Received: (qmail 4312 invoked by uid 111); 28 Apr 2008 09:24:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Apr 2008 05:24:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2008 05:24:10 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80515>

On Mon, Apr 28, 2008 at 11:29:17AM +0930, Geoff Russell wrote:

>      git show HEAD@{"3 minutes ago"}
> 
> works as I expect, but
> 
>      git show HEAD@{"3 minutes ago"}:data/node/node.data
> 
> gives me a message:
> 
>        warning: Log for 'HEAD' only goes back to Mon, 28 Apr 2008
> 10:18:37 +0930.
>
> [...]
> I'm using 1.5.4.rc4

I can't reproduce here, using the current master or v1.5.4-rc4. If I
have a matching reflog, both work. And if I choose a much older time
(say, "1.year.ago"), then both fail. What are the entries in your
reflog (.git/logs/HEAD)?

-Peff
