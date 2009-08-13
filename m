From: Jeff King <peff@peff.net>
Subject: Re: fatal: bad revision 'HEAD'
Date: Thu, 13 Aug 2009 01:10:58 -0400
Message-ID: <20090813051058.GA25830@coredump.intra.peff.net>
References: <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
 <7v7hx98otz.fsf@alter.siamese.dyndns.org>
 <20090812075833.GF15152@coredump.intra.peff.net>
 <7vab24ve97.fsf@alter.siamese.dyndns.org>
 <20090813023137.GA17358@coredump.intra.peff.net>
 <7v1vngmitn.fsf@alter.siamese.dyndns.org>
 <20090813043855.GA21158@coredump.intra.peff.net>
 <89456E84-1A85-4D0C-9643-C191EE877E61@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Joel Mahoney <joelmahoney@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSak-0001xr-Mw
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbZHMFK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbZHMFK7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:10:59 -0400
Received: from peff.net ([208.65.91.99]:59925 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbZHMFK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:10:59 -0400
Received: (qmail 15480 invoked by uid 107); 13 Aug 2009 05:11:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 13 Aug 2009 01:11:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Aug 2009 01:10:58 -0400
Content-Disposition: inline
In-Reply-To: <89456E84-1A85-4D0C-9643-C191EE877E61@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125782>

On Wed, Aug 12, 2009 at 11:02:45PM -0600, Joel Mahoney wrote:

> I'm not sure I completely understand where you guys are at with this
> thread : - ) but I thought I would mention that the question arose
> from my inability to install a plugin into a Ruby on Rails project
> based on my having (unknowingly) set branch.master.rebase = true.
>
> I bring this up because a lot of people are getting their first
> exposure to git through Rails/github, and installing plugins in Rails
> is (I think) a good example of brining an existing history (the
> plugin) into a separate repository (your project).  and because this
> maneuver is built into the "./script/plugin install" action, it is
> not something that cannot be easily customized.

Yes, the discussion moved away bit from your original issue. To
summarize what is happening:

  - Setting branch.master.rebase in your ~/.gitconfig is probably not a
    good idea, as that tends to be a per-repository property, anyway.
    You can work around the problem for now by removing it.

  - Junio has committed a patch to fix the bug. It will definitely be in
    v1.6.5. If this is a common setup for Rails people, maybe we should
    consider putting it into 'maint' for v1.6.4.1.

-Peff
