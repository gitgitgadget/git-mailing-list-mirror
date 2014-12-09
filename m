From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 15:46:44 -0500
Message-ID: <20141209204644.GE12001@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <CAGZ79kZa5sPxbzURtGScCrfbTaCX_cHiRj7uew6Xk+1Df7oTEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRgI-0007WD-PT
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaLIUqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:46:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:50733 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750952AbaLIUqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:46:46 -0500
Received: (qmail 21403 invoked by uid 102); 9 Dec 2014 20:46:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 14:46:46 -0600
Received: (qmail 4123 invoked by uid 107); 9 Dec 2014 20:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:46:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 15:46:44 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kZa5sPxbzURtGScCrfbTaCX_cHiRj7uew6Xk+1Df7oTEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261165>

On Tue, Dec 09, 2014 at 12:32:15PM -0800, Stefan Beller wrote:

> As said above the Documentation/technical would only serve a purpose to
> explain very high level concepts. So racy-git.txt or
> pack-heuristics.txt will fit
> in there very good.

Yeah, I think we would leave anything that isn't api-*, with the goal
that all of api-* would eventually migrate into headers (it does not all
have to happen on day one, of course). There are a few spots which do
refer to api-credential, which is where you can find information on the
credential protocol. But that could be split out into a separate
technical document (which is probably an improvement, anyway; people who
are writing a helper do not know or care about our internal C API; they
only care about the protocol).

-Peff
