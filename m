From: Jeff King <peff@peff.net>
Subject: limiting relationship of git dir and worktree (was Re: [PATCH]
	Support "core.excludesfile = ~/.gitignore")
Date: Sun, 24 Aug 2008 19:51:25 -0400
Message-ID: <20080824235124.GA28248@coredump.intra.peff.net>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu> <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 01:52:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXPNn-0007dI-Id
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 01:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbYHXXv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 19:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYHXXv2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 19:51:28 -0400
Received: from peff.net ([208.65.91.99]:4056 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbYHXXv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 19:51:27 -0400
Received: (qmail 15101 invoked by uid 111); 24 Aug 2008 23:51:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 19:51:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 19:51:25 -0400
Content-Disposition: inline
In-Reply-To: <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93576>

On Sun, Aug 24, 2008 at 04:40:21PM -0700, Junio C Hamano wrote:

> Judging from the occasional "I tried core.worktree but it does not work in
> this and that situations" I see here and on #git, my impression is that
> new people try it, saying "git is cool -- unlike cvs that sprinkles those
> ugly CVS directories all over the place, it only contaminates my work tree
> with a single directory '.git' and nothing else.  Ah, wait --- what's this
> core.worktree thing?  Can I get rid of that last one as well?  That sounds
> even cooler".
> 
> IOW, I do not think it is really _needed_ per-se as a feature, but it was
> done because it was thought to be doable, which unfortunately turned out
> to involve hair-pulling complexity that the two attempts that led to the
> current code still haven't resolved.
> 
> I really wish we do not have to worry about that anymore.

Well, as a non-user of this feature, I certainly have no argument
against taking it out. Maybe the subject line will pull some other
people into the discussion.

-Peff
