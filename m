From: Jeff King <peff@peff.net>
Subject: Re: fatal: bad revision 'HEAD'
Date: Thu, 13 Aug 2009 00:38:55 -0400
Message-ID: <20090813043855.GA21158@coredump.intra.peff.net>
References: <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
 <7v7hx98otz.fsf@alter.siamese.dyndns.org>
 <20090812075833.GF15152@coredump.intra.peff.net>
 <7vab24ve97.fsf@alter.siamese.dyndns.org>
 <20090813023137.GA17358@coredump.intra.peff.net>
 <7v1vngmitn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joel Mahoney <joelmahoney@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 06:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbS5i-0001Q8-SC
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 06:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZHMEi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 00:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZHMEi4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 00:38:56 -0400
Received: from peff.net ([208.65.91.99]:52758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbZHMEi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 00:38:56 -0400
Received: (qmail 15240 invoked by uid 107); 13 Aug 2009 04:38:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 13 Aug 2009 00:38:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Aug 2009 00:38:55 -0400
Content-Disposition: inline
In-Reply-To: <7v1vngmitn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125775>

On Wed, Aug 12, 2009 at 09:36:04PM -0700, Junio C Hamano wrote:

> I honestly do not know of a sane reason (other than "because I can")
> anybody would want to _start_ a new root in a repository with an existing
> history.  And doing a "pull" with or without --rebase immediately after
> starting a new root is doubly insane, as you say.

IIRC, the reason I did it was to throw away history, starting a new root
at the current state. Which is at least a little bit sane, though I
think I might just do it with a graft and filter-branch these days.

> But that is the kind of "ending up to have" I am talking about; it is not
> something you _aim to_ create on purpose.  If you want to _start_ a
> separate history, and if you are sane, you would start the separate
> history in a separate repository.

Agreed. Let's not worry about it, then.

-Peff
