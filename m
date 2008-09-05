From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add --dirstat-by-file diff option
Date: Fri, 5 Sep 2008 15:41:58 -0400
Message-ID: <20080905194158.GA31826@coredump.intra.peff.net>
References: <20080905192735.GA12853@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Fri Sep 05 21:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbhDP-0007AT-4A
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 21:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbYIETmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYIETmE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 15:42:04 -0400
Received: from peff.net ([208.65.91.99]:2708 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbYIETmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 15:42:04 -0400
Received: (qmail 19677 invoked by uid 111); 5 Sep 2008 19:41:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 05 Sep 2008 15:41:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Sep 2008 15:41:58 -0400
Content-Disposition: inline
In-Reply-To: <20080905192735.GA12853@zakalwe.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95036>

On Fri, Sep 05, 2008 at 10:27:35PM +0300, Heikki Orsila wrote:

> --dirstat-by-file is the same as --dirstat, but it counts
> "impacted files" instead of "impacted lines" (lines that
> are added or removed).
> 
> The patch also cleans --cumulative option handling.
> DIFF_OPT_CUMULATIVE_DIRSTAT is used instead of
> DIFF_FORMAT_CUMULATIVE.

I was going to suggest that this actually be split into two patches for
readability, but lo and behold, Junio has already committed a fix for
--cumulative to next. So you probably should rebase your other changes
(which look reasonable to me) on top of that.

-Peff
