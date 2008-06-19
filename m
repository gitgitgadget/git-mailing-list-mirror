From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
	routine
Date: Wed, 18 Jun 2008 20:08:42 -0400
Message-ID: <20080619000842.GA25117@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org> <20080618231316.GB23053@sigill.intra.peff.net> <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97ig-0007ox-D0
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbYFSAIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYFSAIp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:08:45 -0400
Received: from peff.net ([208.65.91.99]:3523 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553AbYFSAIo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 20:08:44 -0400
Received: (qmail 14183 invoked by uid 111); 19 Jun 2008 00:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 18 Jun 2008 20:08:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2008 20:08:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85430>

On Wed, Jun 18, 2008 at 04:34:49PM -0700, Linus Torvalds wrote:

> Forget about "branch.mybranch.url". It has no meaning. It's not what you 
> are supposed to ever use as a human (it's purely for scripting). It's not 
> worth even thinking about.

Have you read "man git-config" lately?

-Peff
