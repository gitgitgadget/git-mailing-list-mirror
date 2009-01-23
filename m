From: Jeff King <peff@peff.net>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 17:29:06 -0500
Message-ID: <20090123222906.GC11328@coredump.intra.peff.net>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com> <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQUXp-0004sg-JD
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 23:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbZAWW3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 17:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757106AbZAWW3K
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 17:29:10 -0500
Received: from peff.net ([208.65.91.99]:33740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500AbZAWW3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 17:29:09 -0500
Received: (qmail 11996 invoked by uid 107); 23 Jan 2009 22:29:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 23 Jan 2009 17:29:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2009 17:29:06 -0500
Content-Disposition: inline
In-Reply-To: <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106923>

On Fri, Jan 23, 2009 at 01:39:27AM -0800, Junio C Hamano wrote:

> > --->8---
> > Subject: [PATCH] git-am: Add --ignore-date option
> 
> Good.
> 
> Leaving "Subject: " in saves me typing, because I do not have to insert it
> manually when editing the submitted patch in my MUA to chop off everything
> before the scissors.

Interesting to know. I have intentionally _not_ been including them,
because I assumed you marked up _after_ git-am (i.e., via "git commit
--amend) in which case you would have to delete it manually. I suppose
it makes more sense to do so before git-am, though, since then it will
respect From: fields and the like (which it would otherwise ignore,
since they are blocked by all of the cover letter cruft that you will
end up deleting).

So good to know, and I will start generating my patches differently.

-Peff
