From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Grammar fixes for gitattributes documentation
Date: Thu, 15 Nov 2007 02:15:59 -0500
Message-ID: <20071115071558.GE10185@sigill.intra.peff.net>
References: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com> <7vfxz9kxz3.fsf@gitster.siamese.dyndns.org> <3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYy5-00028h-Mj
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbXKOHQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXKOHQf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:16:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2522 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824AbXKOHQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:16:34 -0500
Received: (qmail 6804 invoked by uid 111); 15 Nov 2007 07:16:02 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 Nov 2007 02:16:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2007 02:15:59 -0500
Content-Disposition: inline
In-Reply-To: <3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65075>

On Wed, Nov 14, 2007 at 10:04:25AM +0100, Wincent Colaiuta wrote:

>>> +A `filter` attribute can be set to a string value which names a
>>> filter driver specified in the configuration.
>>
>> Will we get the canned "which vs that" discussion on this change?
>
> Perhaps. Neither would be incorrect, although technically "that" is a 
> tighter match.

Really? I would think "which" works better, in that it is not
restrictive. I.e., "The filter attribute is set to a string. This
string, btw, names a filter driver" (which) rather than "The filter
attribute is set to a string, and from the set of strings, it is set to
the particular string that names a filter driver" (that).

But in the non-restrictive case, it should be in a parenthetical phrase:

  A `filter` attribute can be set to a string value, which names a
  filter driver specified in the configuration.

I think either is readable, though. :)

-Peff
