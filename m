From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 06:05:32 -0400
Message-ID: <20070805100532.GG12507@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHczS-0001tl-10
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbXHEKFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbXHEKFe
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:05:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4509 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355AbXHEKFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 06:05:34 -0400
Received: (qmail 16412 invoked from network); 5 Aug 2007 10:05:37 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 10:05:37 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 06:05:32 -0400
Content-Disposition: inline
In-Reply-To: <85ejijgzzg.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54982>

On Sat, Aug 04, 2007 at 04:01:55PM +0200, David Kastrup wrote:

> So --track does not set up a tracking branch, but makes a local
> _following_ branch _refer_ to a tracking branch.

A minor nit, but --track sets up a local following branch to refer to a
remote's branch, _not_ to the tracking branch. In other words, if you
look at the config:

  [branch "master"]
    remote = origin
    merge = refs/heads/master

It does _not_ reference the tracking branch
"refs/remotes/origin/master", but rather the remote's name for the
branch "refs/heads/master".

There was much discussion of this topic, but the general idea was not to
require remote tracking branches for this feature to be used (a position
I somewhat disagree with, but then I'm not the maintainer).

-Peff
