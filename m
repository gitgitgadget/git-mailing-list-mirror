From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] contrib/subtree/Makefile: clean rule cleanup
Date: Mon, 5 May 2014 17:49:30 -0400
Message-ID: <20140505214930.GB16971@sigill.intra.peff.net>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-4-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-5-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-6-git-send-email-nod.helm@gmail.com>
 <20140505050938.GB6569@sigill.intra.peff.net>
 <40d16f4b-440c-4268-bd6a-e7f413d01801@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, greend@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:32:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAl-0007Xo-G3
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbaEEVtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:49:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:45556 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756797AbaEEVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:49:32 -0400
Received: (qmail 8102 invoked by uid 102); 5 May 2014 21:49:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 16:49:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 17:49:30 -0400
Content-Disposition: inline
In-Reply-To: <40d16f4b-440c-4268-bd6a-e7f413d01801@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248141>

On Tue, May 06, 2014 at 07:41:29AM +1000, James Denholm wrote:

> >I do not think BSD-ism matters for "rm", as it works pretty much the
> >same everywhere. "install", on the other hand, is a bit weirder between
> >systems. So you might want to leave that comment as-is.
> 
> True. I might just buff that out when sending the patch to Junio, unless
> protocol dictates otherwise - a reroll for a single comment line seems
> a bit excessive to me at the moment.

I don't think it is that big a deal either way.

It's fine to tweak when you send re-roll the final for Junio. Sometimes
for trivial fixups like this, Junio can just tweak it as he applies, but
I do not know if he is even paying attention to this thread, so you may
want to re-post anyway to get his attention.

Either way, feel free to add my:

  Reviewed-by: Jeff King <peff@peff.net>

-Peff
