From: Jeff King <peff@peff.net>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Thu, 8 May 2014 21:55:48 -0400
Message-ID: <20140509015547.GB9787@sigill.intra.peff.net>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
 <878uqcotxg.fsf@fencepost.gnu.org>
 <xmqqzjis0w9t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 03:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wia2U-0003sD-2g
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbaEIBzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:55:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47900 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbaEIBzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:55:50 -0400
Received: (qmail 15070 invoked by uid 102); 9 May 2014 01:55:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 20:55:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 21:55:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjis0w9t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248496>

On Thu, May 08, 2014 at 02:56:46PM -0700, Junio C Hamano wrote:

> In short:
> 
>  - I am not considering nor proposing to change the default at all.
> 
>  - I have two choices, either change the behaviour of "-b", or
>    introducing a new option (the latter includes "-b -b"); I am
>    slightly in favor of the latter, but not by a large margin.
> 
>  - I have two choices, regardless of how the new mode is triggered,
>    for outputs.  Either fill it with "Unknown" name and leave
>    everything else as is, or blank all information from the boundary
>    commit out.  I am moderately in favor of the latter.
> 
> Hope that clarifies.

Thanks, that makes it much more clear to me at least what you were
asking in the original.

Not that my opinion necessarily matters, but what I was trying to
express elsewhere in the thread was a preference for: output is blank,
and tie it to "-b" (mostly because I do not see any way in which the
author name sans commit is at all useful).

I _would_ consider changing the default to "-b", but that is really a
separate topic from this (and quite possibly falls under the "if I were
designing from scratch today, but I am not..." category of changes).

-Peff
