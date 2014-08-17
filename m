From: Jeff King <peff@peff.net>
Subject: Re: Sharing merge conflict resolution between multiple developers
Date: Sun, 17 Aug 2014 03:52:50 -0400
Message-ID: <20140817075250.GH23808@peff.net>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:53:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIvGu-0004Mf-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbaHQHww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 03:52:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:53553 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750818AbaHQHww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:52:52 -0400
Received: (qmail 8570 invoked by uid 102); 17 Aug 2014 07:52:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:52:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:52:50 -0400
Content-Disposition: inline
In-Reply-To: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255357>

On Mon, Aug 11, 2014 at 04:59:15PM +1200, Chris Packham wrote:

> Is there any way where we could share the conflict resolution around
> but still end up with a single merge commit. I'm thinking of something
> like the following workflow

This came up once a while back. Here's the discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/169187

I proposed a solution there where developers push their partial
resolutions, and the integrator (or just "next person" if it is a chain
of developers) uses "git checkout" to pull the fixes. But note that I
never actually _used_ that in practice. It was a thought experiment, so
there may be gotchas.

-Peff
