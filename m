From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 16:12:16 -0500
Message-ID: <20141223211216.GC13304@peff.net>
References: <20141223084536.GA25190@peff.net>
 <20141223201416.GA29365@google.com>
 <xmqqr3vq13mo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 22:12:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Wkf-0006yj-LT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 22:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbaLWVMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 16:12:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:56815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753685AbaLWVMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 16:12:16 -0500
Received: (qmail 20711 invoked by uid 102); 23 Dec 2014 21:12:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 15:12:16 -0600
Received: (qmail 24196 invoked by uid 107); 23 Dec 2014 21:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 16:12:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 16:12:16 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3vq13mo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261776>

On Tue, Dec 23, 2014 at 01:02:23PM -0800, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> +++ b/t/t1450-fsck.sh
> > [...]
> >> +		git fsck 2>err &&
> >> +		cat err &&
> >> +		! test -s err
> >
> > Nit: if this said
> >
> > 		test_line_count = 0 err
> >
> > then the error message would be more obvious when it fails with
> > --verbose.
> 
> That's a good suggestion, I think.  This is meant to apply on top of
> d08c13b, and we already had test_line_count back then.
> 
> So far I collected these follow-ups to squash into Peff's patch.

They all look good to me. Thanks.

-Peff
