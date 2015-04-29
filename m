From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: Fix inconsistent quotes
Date: Wed, 29 Apr 2015 16:32:47 -0400
Message-ID: <20150429203247.GA1685@peff.net>
References: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
 <20150429185141.GA32207@peff.net>
 <20150429190946.GQ5467@google.com>
 <20150429200453.GA750@peff.net>
 <xmqqpp6m4rr2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Tatschner <stefan@sevenbyte.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnYf9-000572-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 22:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbbD2Ucv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 16:32:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:51806 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbbD2Ucu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 16:32:50 -0400
Received: (qmail 20087 invoked by uid 102); 29 Apr 2015 20:32:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 15:32:50 -0500
Received: (qmail 30340 invoked by uid 107); 29 Apr 2015 20:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 16:33:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 16:32:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp6m4rr2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267999>

On Wed, Apr 29, 2015 at 01:13:53PM -0700, Junio C Hamano wrote:

> > It's actually optional. See 5121a6d (Documentation: option to render
> > literal text as bold for manpages, 2009-03-27). I don't see a good
> > reason that wasn't made the default early, except conservatism. I've had
> > it enabled for years (though I admit I don't read the manpages that much
> > these days :) ).
> 
> Interesting.  What I happen to use when populating the git-manpages
> repository would have wider impact to the users, as I hear that some
> (or many) distros just package whatever I have there.  I do not mind
> enabling it on my end if that gives us more readable rendition.

I think it's probably fine and a positive change, but one never knows. I
guess distros don't package what you ship until you actually tag a
release, so it would be OK to start doing so during a cycle to shake out
any problems (and in fact preferable, as anybody who follows "master"
using "make install-man-quick" would get it early and be able to make a
report).

If we are doing that, it would make sense to flip MAN_BOLD_LITERAL on by
default during that same cycle, so we could get reports from people who
build the manpages from source.

-Peff
