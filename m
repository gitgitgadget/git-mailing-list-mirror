From: Jeff King <peff@peff.net>
Subject: Re: CURLOPT_NOBODY
Date: Thu, 30 Apr 2015 16:13:21 -0400
Message-ID: <20150430201321.GA7067@peff.net>
References: <CACnwZYdCitEJ=pr=1+C_Wz5pKTbSYj4hD7mQHLC3gaDO8CqnrA@mail.gmail.com>
 <20150430035512.GC12361@peff.net>
 <CACnwZYeVVKrTDM5rTaZz9sTjQ9tjWsk52D8WMu8kDM3vxEiVLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 22:13:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynups-0008IT-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 22:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbbD3UNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 16:13:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:52514 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752095AbbD3UNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 16:13:24 -0400
Received: (qmail 16617 invoked by uid 102); 30 Apr 2015 20:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 15:13:23 -0500
Received: (qmail 9299 invoked by uid 107); 30 Apr 2015 20:13:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 16:13:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 16:13:21 -0400
Content-Disposition: inline
In-Reply-To: <CACnwZYeVVKrTDM5rTaZz9sTjQ9tjWsk52D8WMu8kDM3vxEiVLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268104>

On Thu, Apr 30, 2015 at 04:57:28PM -0300, Thiago Farina wrote:

> The same logic you apply to CURLOPT_FILE -> CURLOPT_WRITEDATA?

Maybe. I had to track down the appropriate curl versions for the NOBODY
case manually. If you'd like to do the same for CURLOPT_FILE, be my
guest (and if it has always been that way, I do not mind a cleanup
patch).

-Peff
