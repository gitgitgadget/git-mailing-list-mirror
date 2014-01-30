From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 17:48:17 -0500
Message-ID: <20140130224817.GB30478@sigill.intra.peff.net>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
 <20140130204538.GA1130@sigill.intra.peff.net>
 <20140130221205.GI27577@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 23:48:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W90PH-00041g-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 23:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbaA3WsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 17:48:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:41797 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752584AbaA3WsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 17:48:19 -0500
Received: (qmail 14754 invoked by uid 102); 30 Jan 2014 22:48:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Jan 2014 16:48:19 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jan 2014 17:48:17 -0500
Content-Disposition: inline
In-Reply-To: <20140130221205.GI27577@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241286>

On Thu, Jan 30, 2014 at 02:12:05PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I do find the failure mode interesting. The endian-swapping code kicked
> > in when it did not
> 
> Odd --- wouldn't the #if condition expand to '0 != 0'?

I had the same thought. The "kicked in when it did not" is Brian's claim
from the original, which is why I was confused. He replied to me
off-list, and I think he may simply have had it backwards. :)

-Peff
