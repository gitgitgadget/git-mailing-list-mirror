From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Mon, 26 Mar 2012 13:21:45 -0400
Message-ID: <20120326172145.GC7942@sigill.intra.peff.net>
References: <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3446.9080001@gmx.net>
 <20120325011948.GC27651@sigill.intra.peff.net>
 <4F6F7941.8060008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDc9-00053V-Ch
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084Ab2CZRVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:21:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59985
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932742Ab2CZRVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:21:47 -0400
Received: (qmail 14124 invoked by uid 107); 26 Mar 2012 17:22:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 13:22:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 13:21:45 -0400
Content-Disposition: inline
In-Reply-To: <4F6F7941.8060008@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193934>

On Sun, Mar 25, 2012 at 10:00:01PM +0200, Ivan Todoroski wrote:

> On 25.03.2012 03:19, Jeff King wrote:
> >On Sat, Mar 24, 2012 at 09:53:26PM +0100, Ivan Todoroski wrote:
> >I think there is a minor formatting bug in the above. Asciidoc will make
> >your two paragraphs into a single one, won't it? I think you need to do
> >the (horribly ugly):
> >
> >  --stdin::
> >      First paragraph.
> >  +
> >  Second paragraph.
> 
> Apparently this works too (i.e. indent the "+" too):
> 
>   --stdin::
>       First paragraph.
>       +
>       Second paragraph.

Sadly, it's not quite the same (because I consider the source of your
version much more readable). The diff of the resulting HTML between my
version and yours is:

--- no-indent.html	2012-03-26 13:19:26.206728013 -0400
+++ indent.html	2012-03-26 13:19:04.270727319 -0400
@@ -5,7 +5,8 @@
 <dd>
 <p>
     First paragraph.
+   <br />
+    Second paragraph.
 </p>
-<div class="paragraph"><p>Second paragraph.</p></div>
 </dd>
 </dl></div>

So in your case it is putting in a line break, but not actually starting
a new paragraph.

-Peff
