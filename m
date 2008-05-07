From: Jeff King <peff@peff.net>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 18:29:47 -0400
Message-ID: <20080507222947.GA6427@sigill.intra.peff.net>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com> <20080507222813.GF5994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:30:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jts9u-0001l5-PD
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933934AbYEGW3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933468AbYEGW3s
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:29:48 -0400
Received: from peff.net ([208.65.91.99]:3137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765930AbYEGW3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:29:46 -0400
Received: (qmail 29845 invoked by uid 111); 7 May 2008 22:29:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 May 2008 18:29:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 May 2008 18:29:47 -0400
Content-Disposition: inline
In-Reply-To: <20080507222813.GF5994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81487>

On Wed, May 07, 2008 at 06:28:13PM -0400, Jeff King wrote:

> >     [remote "origin"]
> >     	push = refs/heads/* refs/tags/*
> > 
> > That doesn't work, of course, but I imagine it is possible, and I just
> > can't figure out the syntax.
> 
> I imagine it is possible, too, but not with one line. How about:
> 
>   [remote "origin"]
>     push = refs/heads/*:refs/heads/*
>     push = refs/tags/*:refs/tags/*

Aside: configuring a remote as

  [remote "origin"]
    push = refs/heads/*
    push = refs/tags/*

seems to hang forever. I didn't expect it to _work_, but probably it
should eventually terminate. ;)

-Peff
