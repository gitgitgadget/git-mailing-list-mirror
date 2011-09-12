From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 19:33:48 -0400
Message-ID: <20110912233348.GE28994@sigill.intra.peff.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
 <4E6E928A.6080003@sunshineco.com>
 <7vwrdd1gyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:33:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3G0h-0005pw-QC
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab1ILXdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:33:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40876
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559Ab1ILXdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:33:50 -0400
Received: (qmail 20509 invoked by uid 107); 12 Sep 2011 23:34:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 19:34:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 19:33:48 -0400
Content-Disposition: inline
In-Reply-To: <7vwrdd1gyc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181259>

On Mon, Sep 12, 2011 at 04:25:31PM -0700, Junio C Hamano wrote:

> > Peff also asked if uppercase extensions are common on Windows. They
> > are, so one often sees .HTM, .HTML, etc. Should this issue be handled
> > by jk/default-attr?
> 
> I do not think we would mind adding .HTM but would people limit themselves
> to uppercase while not limiting themselves to three letters and use .HTML?

I wonder if they should all be in the style of:

  [Hh][Tt][Mm][Ll]
  [Jj][Aa][Vv][Aa]

for case-challenged systems. That feels like the wrong solution, though.
If you're on a case-insensitive system, shouldn't we perhaps be
comparing some kind of canonical version of the filename that is
lowercased? That would help these built-in attributes, as well as ones
that people write.

Or maybe that is too large a can of worms to open. I sort of assume we
have those canonicalization routines somewhere already, though.

> > Shouldn't the last entry be?
> >
> > 	"*.m diff=objc",
> 
> Thanks for spotting. I'll locally amend only this part and hope somebody
> would volunteer to submit an agreed version as the final one ;-)

I think we're missing Brandon's note that ".F" is used (as distinct from
".f", even on case-sensitive filesystems, as it has some magic meaning).
And the pascal ones somebody mentioned.

-Peff
