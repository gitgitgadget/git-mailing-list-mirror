From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] userdiff: update Ada patterns
Date: Wed, 5 Feb 2014 12:28:44 -0500
Message-ID: <20140205172844.GD7268@sigill.intra.peff.net>
References: <52EE234C.1060002@redneon.com>
 <20140202233531.GE16196@sigill.intra.peff.net>
 <52EF7E7C.3070504@redneon.com>
 <xmqqppn4dl0k.fsf@gitster.dls.corp.google.com>
 <52F2160D.1040006@redneon.com>
 <xmqqk3d95vic.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adrian Johnson <ajohnson@redneon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6HL-0000P5-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbaBER2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:28:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:45123 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753029AbaBER2q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:28:46 -0500
Received: (qmail 6326 invoked by uid 102); 5 Feb 2014 17:28:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:28:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:28:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk3d95vic.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241616>

On Wed, Feb 05, 2014 at 09:17:47AM -0800, Junio C Hamano wrote:

> Adrian Johnson <ajohnson@redneon.com> writes:
> 
> >>> -	 "|[0-9][-+0-9#_.eE]"
> >>> +	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
> >> 
> >> This would match a lot wider than what I read you said you wanted to
> >> match in your previous message.  Does "-04##4_3_2Ee-9" count as a
> >> number, for example, or can we just ignore such syntactically
> >> incorrect sequence?
> >
> > Maybe I am misunderstanding the purpose of the word diff regexes. I
> > thought the purpose of the word regex is to split lines into words, not
> > determine what is syntactically correct.
> 
> I agree that the purpose is former---So you could have just said
> "the latter" ;-).
> 
> Any other nitpick, anybody?  Otherwise I'll queue this version.

No nitpick here, I had the same thought as Adrian while reading the
thread (and if somebody comes up with a real case where the output looks
bad, we can iterate on it).

-Peff
