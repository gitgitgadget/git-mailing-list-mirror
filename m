From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Documentation: don't link to example mail addresses
Date: Mon, 17 Dec 2012 07:02:54 -0500
Message-ID: <20121217120253.GA21858@sigill.intra.peff.net>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
 <20121215182408.GD2725@river.lan>
 <20121216120405.GA14320@sigill.intra.peff.net>
 <20121216140029.GE2725@river.lan>
 <7vehippg91.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkZPo-0006je-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 13:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab2LQMDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 07:03:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56638 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab2LQMDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 07:03:05 -0500
Received: (qmail 5689 invoked by uid 107); 17 Dec 2012 12:04:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 07:04:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 07:02:54 -0500
Content-Disposition: inline
In-Reply-To: <7vehippg91.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211680>

On Sun, Dec 16, 2012 at 06:24:58PM -0800, Junio C Hamano wrote:

> I seem to be getting
> 
> (<tt>`\cm@example.com'').  `LT</tt> and <tt>GT</tt> are the literal less-than (\x3c)
> 
> out of this part in the resulting HTML output, which is probably not
> what you wanted to see.
> 
> I have a feeling that it might be a better solution to stop using
> these pretty quotes.  It's not like we use them a lot and a quick
> scanning of "git grep '``'" output seems to tell me that many of
> them should be `monospace output`, and the rest (mostly references
> to section headers) can be "Section".

Typographically speaking, I would also be just as happy to use regular
double-quotes throughout.  But here's an example where they also caused
a problem (which was fixed by moving to smart-quotes in f34e9ed):

  http://thread.gmane.org/gmane.comp.version-control.git/163067

-Peff
