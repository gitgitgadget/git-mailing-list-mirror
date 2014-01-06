From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 16:57:13 -0500
Message-ID: <20140106215713.GA7133@sigill.intra.peff.net>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
 <20140106145723.GA15489@sigill.intra.peff.net>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D4466883DF@PRN-MBX02-1.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ben Maurer <bmaurer@fb.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IAk-0007Bw-0R
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbaAFV5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 16:57:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:56134 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756298AbaAFV5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 16:57:15 -0500
Received: (qmail 21224 invoked by uid 102); 6 Jan 2014 21:57:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 15:57:15 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 16:57:13 -0500
Content-Disposition: inline
In-Reply-To: <5CDDBDF2D36D9F43B9F5E99003F6A0D4466883DF@PRN-MBX02-1.TheFacebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240070>

On Mon, Jan 06, 2014 at 09:15:04PM +0000, Ben Maurer wrote:

> > Let me know how this patch does for you. My testing has been fairly
> > limited so far.
> 
> This patch looks like a much cleaner version :-). Works well for me,
> but my test setup may not be great since I didn't get any errors from
> completely ignoring the haves bitmap :-).

Great. Out of curiosity, can you show the before/after? The timings
should be similar to what your patch produced, but I'm really curious to
see how the pack size changes.

-Peff
