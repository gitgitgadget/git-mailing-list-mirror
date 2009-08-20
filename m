From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Thu, 20 Aug 2009 18:34:24 -0400
Message-ID: <20090820223424.GA5843@coredump.intra.peff.net>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch>
 <7vab1up1gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGDH-0003Xx-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 00:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbZHTWeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 18:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbZHTWeX
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 18:34:23 -0400
Received: from peff.net ([208.65.91.99]:56430 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbZHTWeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 18:34:22 -0400
Received: (qmail 29687 invoked by uid 107); 20 Aug 2009 22:34:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 20 Aug 2009 18:34:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Aug 2009 18:34:24 -0400
Content-Disposition: inline
In-Reply-To: <7vab1up1gz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126653>

On Thu, Aug 20, 2009 at 03:25:16PM -0700, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Ideally, we'd like 'git diff C^!' to show the same diff that 'git show C'
> > does (with log.showroot enabled).  This gives easy access to a readable
> > diff for the commit, irrespective of how many parents it has and without
> > any trickery to remove the commit message from the git-show output.
> 
> Not interested yet, as the "git show" discussion is not convincing at all.
> 
> Is the message annoying enough to warrant this change?

I thought the same thing when I saw his message, but reading further,
the current output is nonsensical. So if not this patch, we should
probably at least complain about bogus input and die (though if it is
easy to make it work, why not...).

-Peff
