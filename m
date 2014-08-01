From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Fri, 1 Aug 2014 19:12:17 -0400
Message-ID: <20140801231217.GB17960@peff.net>
References: <20140728171743.GA1927@peff.net>
 <53D806AC.3070806@gmail.com>
 <20140801223739.GA15649@peff.net>
 <20140801231044.GA17960@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLzw-0006YY-77
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 01:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbaHAXMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 19:12:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:44531 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755911AbaHAXMY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 19:12:24 -0400
Received: (qmail 16054 invoked by uid 102); 1 Aug 2014 23:12:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 18:12:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 19:12:17 -0400
Content-Disposition: inline
In-Reply-To: <20140801231044.GA17960@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254682>

On Fri, Aug 01, 2014 at 07:10:44PM -0400, Jeff King wrote:

> I confirmed that this does break horribly without the packed attribute
> (as you'd expect; it's asking for 48-bit alignment!). p5310 notices it,
> _if_ you have jgit installed to check against.

Er, that should be t5310, of course. p5310 is the perf test, which does
not notice the problem. :)

-Peff
