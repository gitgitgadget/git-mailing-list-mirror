From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] CodingGuidelines: on comparison
Date: Fri, 2 May 2014 16:31:16 -0400
Message-ID: <20140502203116.GA32500@sigill.intra.peff.net>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
 <1398894312-30763-8-git-send-email-gitster@pobox.com>
 <20140501213657.GC14441@sigill.intra.peff.net>
 <xmqqk3a4avt1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgK78-0001ab-Vt
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbaEBUbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:31:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:43808 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752991AbaEBUbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:31:18 -0400
Received: (qmail 21722 invoked by uid 102); 2 May 2014 20:31:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 May 2014 15:31:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2014 16:31:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3a4avt1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247968>

On Fri, May 02, 2014 at 11:18:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Apr 30, 2014 at 02:45:11PM -0700, Junio C Hamano wrote:
> >
> >> See http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=4126
> >> 
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> > Don't you often complain about submitters referencing a discussion
> > in a commit message without providing some context or summary?
> 
> Yes, but the summary of the discussion would be identical to the new
> text added by the patch to the documentation tree in this case, so I
> didn't find a good introductory text before "See $URL".  Perhaps
> 
>     This comes up from time to time.  See $URL for the original
>     discussion.
> 
> but I do not know if that is much better.

I meant something even less in-depth. Your message says only "on
comparison", and I did not even know what "this" in your sentence above
would mean until I followed the link.

  There are arguments for writing a conditional as "a < b" rather than
  "b > a", or vice versa. Let's give guidance on which we prefer.

Not a big deal, but I think it is easy when you have just written the
patch to forget that a reviewer or a reader of "git log" six months have
no has no context at all.

-Peff
