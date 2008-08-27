From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Wed, 27 Aug 2008 13:18:46 -0400
Message-ID: <20080827171846.GA14300@coredump.intra.peff.net>
References: <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org> <48B52037.7030405@fastmail.fm> <20080827123656.GB11986@coredump.intra.peff.net> <7vmyiyqt08.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYOgU-0000TT-04
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYH0RSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbYH0RSt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:18:49 -0400
Received: from peff.net ([208.65.91.99]:3674 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbYH0RSs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:18:48 -0400
Received: (qmail 13717 invoked by uid 111); 27 Aug 2008 17:18:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 27 Aug 2008 13:18:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 13:18:46 -0400
Content-Disposition: inline
In-Reply-To: <7vmyiyqt08.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93901>

On Wed, Aug 27, 2008 at 10:15:19AM -0700, Junio C Hamano wrote:

> > I wonder if there is a good way to warn that we have multiple matches.
> > Of course we expect many _exact_ matches if the author has multiple
> > commits, but we could look for distinct matches. However, even that will
> > turn up false positives, since some authors have multiple email
> > addresses.
> 
> In order to prove unique match you would need an exhaustive check, don't
> you?

Yes, though you also do exhaustive check in the worst case already (when
the name doesn't match anything). It takes about .7s on a warm cache on
my git.git.

Anyway, I think it is already not a good idea because of the semantics,
let alone the performance.

-Peff

PS Your message also didn't go to git@vger, so I think you are having
the same problem with Michael's message that I am.
