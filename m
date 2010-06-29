From: Jeff King <peff@peff.net>
Subject: Re: origin/branchname and tracking branch pointing to different
 commits?
Date: Tue, 29 Jun 2010 18:39:19 -0400
Message-ID: <20100629223919.GB5668@sigill.intra.peff.net>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
 <201001071813.01187.trast@student.ethz.ch>
 <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
 <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
 <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
 <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
 <20100608183007.GA31293@coredump.intra.peff.net>
 <AANLkTik7bleuzqnMWMJoWljQ5zD0YbwBsFjZT5IzkV0q@mail.gmail.com>
 <7vocet8ws2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eugene Sajine <euguess@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 00:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTjSh-0004hv-Th
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 00:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab0F2WjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 18:39:22 -0400
Received: from peff.net ([208.65.91.99]:50677 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755699Ab0F2WjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 18:39:22 -0400
Received: (qmail 13244 invoked by uid 107); 29 Jun 2010 22:40:14 -0000
Received: from adsl-70-239-95-45.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (70.239.95.45)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 29 Jun 2010 18:40:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jun 2010 18:39:19 -0400
Content-Disposition: inline
In-Reply-To: <7vocet8ws2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149930>

On Tue, Jun 29, 2010 at 12:27:09PM -0700, Junio C Hamano wrote:

> I have a slight suspicion that such an "unexpected ref update" is not a
> big issue anymore.  So in principle, I think it is fine to change the
> behaviour of "git fetch $there $these_explicit_refs" to additionally
> follow the configured remote tracking ref globbing patterns.
> 
> Because
> 
>  (1) the old patch was never tested in a production context (I don't think
>      it even hit 'pu');
> 
>  (2) I offhand do not know how much the codebase changed in the area that
>      would affect the assumptions the patch made back then; and
> 
>  (3) we will be in feature freeze for 1.7.2 anyway;
> 
> I would rather not be the one who is forward-porting the patch myself
> if I can avoid it, however.

I am probably the best person to take another look at it (though I would
be fine if somebody else wants to volunteer).

Right now I am in the process of switching day jobs and doing an
inter-state move, so it will probably be a month before I have a lot of
git time.

-Peff
