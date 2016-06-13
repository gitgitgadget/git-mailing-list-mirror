From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/3] use string_list initializer consistently
Date: Mon, 13 Jun 2016 13:32:47 -0400
Message-ID: <20160613173246.GA8245@sigill.intra.peff.net>
References: <20160610115726.4805-1-pclouds@gmail.com>
 <20160612220316.GB5428@sigill.intra.peff.net>
 <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com>
 <20160613053203.GB3950@sigill.intra.peff.net>
 <CACsJy8CAT54pTotUFKm-piWRppNFz9mjTsnz+5p1+7ykVg60HQ@mail.gmail.com>
 <20160613100420.GA16229@sigill.intra.peff.net>
 <CACsJy8CoOJKLUQXPKx_KvHvwbUdOfyBKu_-v5F2U7ccrmCcewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 19:33:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCVjJ-0001QH-T3
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 19:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbcFMRcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 13:32:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:54142 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751150AbcFMRcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 13:32:50 -0400
Received: (qmail 32518 invoked by uid 102); 13 Jun 2016 17:32:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 13:32:49 -0400
Received: (qmail 19446 invoked by uid 107); 13 Jun 2016 17:33:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 13:33:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 13:32:47 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CoOJKLUQXPKx_KvHvwbUdOfyBKu_-v5F2U7ccrmCcewA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297236>

On Mon, Jun 13, 2016 at 06:31:29PM +0700, Duy Nguyen wrote:

> > This is a fairly mechanical conversion; I assumed each site
> > was correct as-is, and just switched them all to NODUP.
> 
> Looking good. If we still want to reduce noise level down (by a tiny
> bit), we could remove _INIT because I think it's obvious from
> 
> struct string_list var = STRING_LIST_NODUP;
> 
> that's it's initialization (I wish we could write "auto var =
> STRING_LIST_NODUP;")

Yeah, I've always felt it's a bit long. The "INIT" does match other
similar macros, but I agree it could probably go. Definitely something
for a separate patch, though.

-Peff
