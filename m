From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: run post-checkout hook when checking out
Date: Tue, 3 Mar 2009 02:03:08 -0500
Message-ID: <20090303070308.GA30609@coredump.intra.peff.net>
References: <20273.1236033817@relay.known.net> <20090303042848.GC18136@coredump.intra.peff.net> <23978.1236056549@relay.known.net> <20090303053750.GA30201@coredump.intra.peff.net> <7vsklvhzpm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: layer <layer@known.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:04:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOgL-0004k4-F2
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZCCHDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbZCCHDR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:03:17 -0500
Received: from peff.net ([208.65.91.99]:44032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZCCHDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:03:16 -0500
Received: (qmail 12979 invoked by uid 107); 3 Mar 2009 07:03:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 02:03:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 02:03:08 -0500
Content-Disposition: inline
In-Reply-To: <7vsklvhzpm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112006>

On Mon, Mar 02, 2009 at 10:45:09PM -0800, Junio C Hamano wrote:

> > Junio, I'm not sure what you want to do with this. It is definitely a
> > behavior change; we have never respected post-checkout hooks in shell
> > git-clone.sh or in the builtin version. However, it seems like an
> > omission rather than an intentional behavior, so I consider this a
> > bugfix.
> 
> I do not mind queueing this to 'pu' and let people fight it out.  I hate
> the local side hooks that have no reason to be there, and consider that
> the existence of the "checkout hook" to be a bug to begin with, but I
> really don't care that deeply anymore.

That sounds fine to me. I don't personally care either way (I didn't
even know we had a post-checkout hook until today).

-Peff
