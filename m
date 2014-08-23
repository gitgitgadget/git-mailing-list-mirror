From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Sat, 23 Aug 2014 07:04:59 -0400
Message-ID: <20140823110459.GA13087@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 23 13:05:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL98M-0002ox-N4
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 13:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaHWLFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 07:05:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:57400 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752479AbaHWLFB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 07:05:01 -0400
Received: (qmail 30779 invoked by uid 102); 23 Aug 2014 11:05:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 06:05:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 07:04:59 -0400
Content-Disposition: inline
In-Reply-To: <20140823105640.GA6881@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255745>

On Sat, Aug 23, 2014 at 06:56:40AM -0400, Jeff King wrote:

> So I think your patch is doing the right thing.

By the way, if you want to add a test to your patch, there is
infrastructure in t5308 to create packs with duplicate objects. If I
understand the problem correctly, you could trigger this by having a
delta object whose base is duplicated, even without the missing object.

-Peff
