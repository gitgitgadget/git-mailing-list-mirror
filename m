From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t7700: do not use "touch -r"
Date: Thu, 23 Jan 2014 16:14:25 -0500
Message-ID: <20140123211425.GA21377@sigill.intra.peff.net>
References: <20140123195404.GA31314@sigill.intra.peff.net>
 <20140123195518.GB31871@sigill.intra.peff.net>
 <xmqq61patnag.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:14:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Rbb-0006RZ-3k
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbaAWVO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:14:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:37781 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbaAWVO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:14:26 -0500
Received: (qmail 358 invoked by uid 102); 23 Jan 2014 21:14:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 15:14:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 16:14:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61patnag.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240955>

On Thu, Jan 23, 2014 at 01:12:55PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... The test does not care about the timestamp of the
> > .keep file it creates at all, only that it exists.
> 
> Please refrain from using "touch" for such use cases in the first
> place.  It appears that
> 
> 	>pack-$packsha1.keep &&
> 
> is what the test wants.

Agreed. I was making the minimal change, but I think there is no reason
not to fix both while we are there. Do you want to just mark up the
patch in transit?

-Peff
