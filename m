From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Sat, 6 Dec 2014 00:30:24 -0500
Message-ID: <20141206053024.GE31301@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 06:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx7ww-0007Nv-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 06:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbaLFFa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 00:30:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:49304 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751145AbaLFFa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 00:30:26 -0500
Received: (qmail 6216 invoked by uid 102); 6 Dec 2014 05:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 23:30:26 -0600
Received: (qmail 9608 invoked by uid 107); 6 Dec 2014 05:30:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 00:30:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 00:30:24 -0500
Content-Disposition: inline
In-Reply-To: <20141206020458.GR16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260938>

On Fri, Dec 05, 2014 at 06:04:58PM -0800, Jonathan Nieder wrote:

> Stefan Beller wrote:
> 
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >
> >  Just stumbled accross this one and wasn't sure if it also frees up
> >  the memory involved.
> >
> >  string-list.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> Sounds reasonable.  Documentation/technical/api-string-list.txt
> documents these functions more fully.  The right balance between
> documenting things in two places vs. adding "see also" pointers vs.
> just putting the highlights in one of the two places isn't obvious to
> me.

Also, I forgot to mention: if we consistently put the API docs into the
header files and extracted it automatically into standalone documents,
we would not need to have two places.

This is something I've been meaning to look at for a long time, but it
never quite makes the priority list. And my past experiences with tools
like doxygen has been that they are complicated and have a lot of
dependencies. It's been a long time since I've tried, though.

-Peff
