From: Jeff King <peff@peff.net>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 18:28:13 -0400
Message-ID: <20080507222813.GF5994@sigill.intra.peff.net>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jts8G-0001J2-I8
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473AbYEGW2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933433AbYEGW2P
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:28:15 -0400
Received: from peff.net ([208.65.91.99]:3131 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331AbYEGW2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:28:12 -0400
Received: (qmail 29674 invoked by uid 111); 7 May 2008 22:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 May 2008 18:28:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 May 2008 18:28:13 -0400
Content-Disposition: inline
In-Reply-To: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81486>

On Wed, May 07, 2008 at 04:15:47PM -0500, Steve Hoelzer wrote:

> How can I specify multiple refs on one line in the config file? For
> example, I want "git push" to push all heads and all tags by default
> so I tried this:
> 
>     [remote "origin"]
>     	push = refs/heads/* refs/tags/*
> 
> That doesn't work, of course, but I imagine it is possible, and I just
> can't figure out the syntax.

I imagine it is possible, too, but not with one line. How about:

  [remote "origin"]
    push = refs/heads/*:refs/heads/*
    push = refs/tags/*:refs/tags/*

-Peff
