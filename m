From: Jeff King <peff@peff.net>
Subject: Re: [GSoC Proposal/RFC] Rolling commit message writing
Date: Tue, 30 Mar 2010 13:27:25 -0400
Message-ID: <20100330172725.GF17763@coredump.intra.peff.net>
References: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org>
 <32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Thomas <drt24@srcf.ucam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 19:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwfE7-0005Fg-Pp
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 19:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab0C3R1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 13:27:38 -0400
Received: from peff.net ([208.65.91.99]:49710 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833Ab0C3R1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 13:27:37 -0400
Received: (qmail 22791 invoked by uid 107); 30 Mar 2010 17:28:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 13:28:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 13:27:25 -0400
Content-Disposition: inline
In-Reply-To: <32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143581>

On Mon, Mar 29, 2010 at 04:31:00PM -0400, Avery Pennarun wrote:

> Secondly, I'm concerned that if you can't remember the description of
> your entire commit by the time you commit it, then your commit is too
> big.  The usual solution is to create multiple, smaller commits that
> are easy to describe.  If at the end you find yourself with too many
> commits, you can always join them together with git rebase.

That was my first thought, too. I like your suggestion elsewhere in the
thread of making many small commits, and then squashing them later if
you like.

Still, I can see how people might prefer to use this as part of their
workflow, so I am not against the feature itself.

However, I am really concerned with it as a GSoC project. It just
doesn't seem like a big enough feature to take the whole summer. In the
schedule, there is a week of implementing "git add -p
--add-with-message". It seems like that should be hours, not days.

I wonder if it could be rolled into a more comprehensive proposal
concerning commit workflows (though I admit, I don't personally have any
other ideas in the area).

-Peff

PS Daniel (and other potential GSoC'ers who are reading), please don't
take this as discouragement of presenting proposals that aren't on the
ideas wiki. I really really like the concept of somebody working on
their own itch, as I think they tend to have a clearer idea of what the
solution should look like. I'm just concerned this particular proposal
isn't big enough.
