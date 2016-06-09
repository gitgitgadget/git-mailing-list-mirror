From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Adds *~ to the .gitignore
Date: Thu, 9 Jun 2016 17:38:09 -0400
Message-ID: <20160609213809.GA23059@sigill.intra.peff.net>
References: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com>
 <xmqqh9d2girw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Vogel <lars.vogel@gmail.com>, git@vger.kernel.org,
	Lars Vogel <Lars.Vogel@vogella.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:40:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7et-0003Ng-8n
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbcFIViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:38:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:52140 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751833AbcFIViN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:38:13 -0400
Received: (qmail 2865 invoked by uid 102); 9 Jun 2016 21:38:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 17:38:12 -0400
Received: (qmail 27412 invoked by uid 107); 9 Jun 2016 21:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 17:38:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 17:38:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9d2girw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296931>

On Thu, Jun 09, 2016 at 02:21:55PM -0700, Junio C Hamano wrote:

> Lars Vogel <lars.vogel@gmail.com> writes:
> 
> > This helps contributors (like me) using editors which automatically create ~ copies of the changed data
> >
> > Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
> > ---
> 
> We deliberately left this out and kept it out of .gitignore for the
> past 10 years.  The justification was that use of Emacs is merely a
> personal choice that is better served by .git/info/excludes; we do
> not add .swp for vim users, either, for the same reason.

I think a better choice than .git/info/excludes these days is
~/.config/git/ignore. Then it is associated with the user, not the
project (which seems a better fit, since it is the user who is picking
the editor; this should apply across all projects).

-Peff
