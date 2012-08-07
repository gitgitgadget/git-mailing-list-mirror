From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 20:01:58 -0400
Message-ID: <20120807000158.GA17022@sigill.intra.peff.net>
References: <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
 <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
 <20120806213404.GA14320@sigill.intra.peff.net>
 <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
 <20120806223113.GA16298@sigill.intra.peff.net>
 <1344292395-sup-1921@pinkfloyd.chass.utoronto.ca>
 <20120806224222.GA16721@sigill.intra.peff.net>
 <1344295889-sup-7899@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Aug 07 02:02:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyXFQ-0001Sr-S6
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 02:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094Ab2HGACD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 20:02:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53890 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083Ab2HGACB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 20:02:01 -0400
Received: (qmail 21405 invoked by uid 107); 7 Aug 2012 00:02:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 20:02:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 20:01:58 -0400
Content-Disposition: inline
In-Reply-To: <1344295889-sup-7899@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203000>

On Mon, Aug 06, 2012 at 07:31:30PM -0400, Ben Walton wrote:

> Excerpts from Jeff King's message of Mon Aug 06 18:42:22 -0400 2012:
> 
> > +    if (strbuf_getwholeline(sb, fd, term))
> 
> Shouldn't this be strbuf_getwholeline_fd though?

Whoops, yes. When I got your email, I had just finished the patch but
had not yet written the follow-on patch that would actually exercise it.

-Peff
