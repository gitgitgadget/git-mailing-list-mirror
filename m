From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git p4: RCS expansion should not span newlines
Date: Thu, 8 Nov 2012 12:47:27 -0500
Message-ID: <20121108174727.GJ15560@sigill.intra.peff.net>
References: <CACtYWOYOSxmogJHy70McsRVf0m2PVuu=q+pDZ2-gAza7vpeEiA@mail.gmail.com>
 <20121104220402.GA9160@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Goard <cgoard@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 18:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWWCe-0005tY-UP
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 18:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab2KHRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 12:47:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36514 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab2KHRrb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 12:47:31 -0500
Received: (qmail 31316 invoked by uid 107); 8 Nov 2012 17:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 12:48:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 12:47:27 -0500
Content-Disposition: inline
In-Reply-To: <20121104220402.GA9160@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209178>

On Sun, Nov 04, 2012 at 05:04:02PM -0500, Pete Wyckoff wrote:

> This bug was introduced in cb585a9 (git-p4: keyword
> flattening fixes, 2011-10-16).  The newline character
> is indeed special, and $File$ expansions should not try
> to match across multiple lines.
> 
> Based-on-patch-by: Chris Goard <cgoard@gmail.com>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Thanks, I'll queue this for 'maint'. Seems obviously correct to me.

-Peff
