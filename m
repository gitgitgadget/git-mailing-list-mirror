From: Jeff King <peff@peff.net>
Subject: Re: Incorrect default for git stash?
Date: Tue, 17 Jun 2008 18:32:05 -0400
Message-ID: <20080617223205.GA10830@sigill.intra.peff.net>
References: <loom.20080617T220852-922@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:33:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jjy-0005am-H3
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937AbYFQWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760568AbYFQWcL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:32:11 -0400
Received: from peff.net ([208.65.91.99]:4358 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760558AbYFQWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:32:10 -0400
Received: (qmail 11679 invoked by uid 111); 17 Jun 2008 22:32:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 17 Jun 2008 18:32:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2008 18:32:05 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080617T220852-922@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85337>

On Tue, Jun 17, 2008 at 10:21:23PM +0000, Eric Raible wrote:

> Does it bother anyone else that the default for
> git stash is inconsistent with branch & tag?
> 
> git branch -> list branches
> git tag    -> list tags
> git stash  -> create a stash
> 
> I understand that branches & tags must explicitly named
> and that stashes are by default automatically named.
> 
> But wouldn't it be less surprising to me if the default
> was 'list' instead of 'save'?

I don't know if it still bothers people, but this was discussed when
stash was first merged:

  http://kerneltrap.org/mailarchive/git/2007/7/1/250414

-Peff
