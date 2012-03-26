From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Mon, 26 Mar 2012 13:51:25 -0400
Message-ID: <20120326175125.GA9503@sigill.intra.peff.net>
References: <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3446.9080001@gmx.net>
 <20120325011948.GC27651@sigill.intra.peff.net>
 <4F6F7941.8060008@gmx.net>
 <20120326172145.GC7942@sigill.intra.peff.net>
 <4F70AC47.1010405@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:51:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCE4r-0003E4-CI
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176Ab2CZRv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:51:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60029
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932903Ab2CZRv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:51:27 -0400
Received: (qmail 14700 invoked by uid 107); 26 Mar 2012 17:51:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 13:51:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 13:51:25 -0400
Content-Disposition: inline
In-Reply-To: <4F70AC47.1010405@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193940>

On Mon, Mar 26, 2012 at 07:49:59PM +0200, Ivan Todoroski wrote:

> >So in your case it is putting in a line break, but not actually starting
> >a new paragraph.
> >
> Ah, that's too bad. OK, I guess we have two options:
> 
> 1) Unindent the second paragraph - looks ugly in source but good in
> final output.
> 
> 2) Just merge the two paragraphs into a single paragraph. It's not
> that much text anyway, it doesn't really *have* to be in two
> paragraphs.
> 
> Let me know which option you prefer.

I would do (1). While I (and I suspect other git devs) do just read the
source straight from Documentation/*.txt, the formatted output is read
by many more people, and should be considered the final product. So
optimize for that case.

-Peff
