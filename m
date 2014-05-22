From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 9/9] remote-curl: reencode http error messages
Date: Thu, 22 May 2014 02:05:59 -0400
Message-ID: <20140522060559.GC16587@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521103353.GI30464@sigill.intra.peff.net>
 <EF689296-BB9E-4734-A044-25DEF1874884@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 08:06:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnM8j-0005RA-GB
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 08:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbaEVGGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 02:06:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:57113 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbaEVGGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 02:06:01 -0400
Received: (qmail 1119 invoked by uid 102); 22 May 2014 06:06:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 01:06:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 02:05:59 -0400
Content-Disposition: inline
In-Reply-To: <EF689296-BB9E-4734-A044-25DEF1874884@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249876>

On Wed, May 21, 2014 at 05:07:40PM -0700, Kyle J. McKay wrote:

> >+	/* default charset from rfc2616 */
> >+	if (!*charset)
> >+		*charset = xstrdup("iso8859-1");
> 
> Actually the name should be "ISO-8859-1".  See RFC 2616 section 3.7.1.
> Since it's case insensitive "iso-8859-1" would be fine too.

Thanks, will fix.

-Peff
