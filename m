From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: fix misrender of pretty-formats in
 Asciidoctor
Date: Wed, 8 Oct 2014 22:31:33 -0400
Message-ID: <20141009023132.GB18440@peff.net>
References: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
 <1412801170-60741-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derek Moore <derek.p.moore@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 04:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc3Vy-0001t6-MH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 04:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaJICbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 22:31:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:56588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750922AbaJICbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 22:31:34 -0400
Received: (qmail 22887 invoked by uid 102); 9 Oct 2014 02:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 21:31:34 -0500
Received: (qmail 20674 invoked by uid 107); 9 Oct 2014 02:31:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 22:31:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 22:31:33 -0400
Content-Disposition: inline
In-Reply-To: <1412801170-60741-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 08:46:10PM +0000, brian m. carlson wrote:

> Neither the AsciiDoc nor the Asciidoctor documentation specify whether
> the same number of delimiter characters must be used to end a block as
> to begin it, although both sets of documentation show exactly matching
> pairs.  AsciiDoc allows mismatches, but AsciiDoctor apparently does not.
> Adjust the pretty formats documentation to use matching pairs to prevent
> a misrendering where the remainder of the document was rendered as a
> listing block.

Argh, I somehow missed your message and just typed an almost-identical
response.  Consider that an approval of your patch. :)

I'm still going to report this to the AsciiDoctor folks; they should
probably be shooting for compatibility with vanilla AsciiDoc.

-Peff
