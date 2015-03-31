From: Jeff King <peff@peff.net>
Subject: Re: RFC: git status --amend
Date: Tue, 31 Mar 2015 14:04:14 -0400
Message-ID: <20150331180414.GB19206@peff.net>
References: <551AB64F.4030400@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:04:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd0WT-0001sC-TL
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 20:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbbCaSER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 14:04:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:40459 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752861AbbCaSEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 14:04:16 -0400
Received: (qmail 18048 invoked by uid 102); 31 Mar 2015 18:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:04:16 -0500
Received: (qmail 26010 invoked by uid 107); 31 Mar 2015 18:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 14:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 14:04:14 -0400
Content-Disposition: inline
In-Reply-To: <551AB64F.4030400@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266542>

On Tue, Mar 31, 2015 at 04:59:27PM +0200, Sven Strickroth wrote:

> for frontends or scripts it would be helpful to be able to use "git
> status" for getting the repository status compared to HEAD~1 instead of
> only HEAD (as provided by "git commit --amend" in the pre-filled commit
> message).
> 
> Thus, I'm suggesting to add a "--amend" parameter (or a parameter with a
> better naming) to "git status".
> 
> What do you think of this idea?

Once upon a time "git status" really was just "git commit --dry-run".
These days it has diverged a bit. But I think you could get what you
want with:

  git commit --dry-run --amend

It even supports alternate styles like --short.

-Peff
