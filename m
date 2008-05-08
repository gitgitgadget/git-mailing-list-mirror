From: Jeff King <peff@peff.net>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 23:32:45 -0400
Message-ID: <20080508033245.GA10735@sigill.intra.peff.net>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com> <20080507222813.GF5994@sigill.intra.peff.net> <20080507222947.GA6427@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 05:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtwt1-0002Th-90
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 05:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYEHDct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 23:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYEHDct
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 23:32:49 -0400
Received: from peff.net ([208.65.91.99]:2179 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbYEHDcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 23:32:47 -0400
Received: (qmail 17092 invoked by uid 111); 8 May 2008 03:32:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 May 2008 23:32:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 May 2008 23:32:45 -0400
Content-Disposition: inline
In-Reply-To: <20080507222947.GA6427@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81503>

On Wed, May 07, 2008 at 06:29:47PM -0400, Jeff King wrote:

> Aside: configuring a remote as
> 
>   [remote "origin"]
>     push = refs/heads/*
>     push = refs/tags/*
> 
> seems to hang forever. I didn't expect it to _work_, but probably it
> should eventually terminate. ;)

Nevermind, this _does_ work. But there seems to be a bug in next that I
was triggering with my test case. I'll send a separate message about it.

-Peff
