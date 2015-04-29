From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: Fix inconsistent quotes
Date: Wed, 29 Apr 2015 16:04:54 -0400
Message-ID: <20150429200453.GA750@peff.net>
References: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
 <20150429185141.GA32207@peff.net>
 <20150429190946.GQ5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Tatschner <stefan@sevenbyte.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnYE9-0007QY-Pb
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 22:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbbD2UE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 16:04:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:51787 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbbD2UE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 16:04:56 -0400
Received: (qmail 18872 invoked by uid 102); 29 Apr 2015 20:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 15:04:56 -0500
Received: (qmail 30047 invoked by uid 107); 29 Apr 2015 20:05:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 16:05:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 16:04:54 -0400
Content-Disposition: inline
In-Reply-To: <20150429190946.GQ5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267997>

On Wed, Apr 29, 2015 at 12:09:46PM -0700, Jonathan Nieder wrote:

> Hi,
> 
> Jeff King wrote:
> 
> > But IMHO, using backticks looks much better. In the roff-formatted
> > manpages single quotes underline, but backticks use bold.
> 
> Are you sure?  My copy of git.1.gz has backticks converted into no
> formatting at all:
> 
> 	Other options are available to control how the manual page is displayed\&. See
> 	\fBgit-help\fR(1)
> 	for more information, because
> 	git \-\-help \&.\&.\&.
> 	is converted internally into
> 	git help \&.\&.\&.\&.

It's actually optional. See 5121a6d (Documentation: option to render
literal text as bold for manpages, 2009-03-27). I don't see a good
reason that wasn't made the default early, except conservatism. I've had
it enabled for years (though I admit I don't read the manpages that much
these days :) ).

-Peff
