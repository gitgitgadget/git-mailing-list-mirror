From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use character class for sed expression instead of \s
Date: Fri, 26 Oct 2012 08:38:54 -0400
Message-ID: <20121026123854.GB1455@sigill.intra.peff.net>
References: <508935CB.9020408@web.de>
 <1351180699-24695-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tboegi@web.de, bosch@adacore.com, brian@gernhardtsoftware.com,
	git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 14:39:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRjBu-00046u-9D
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 14:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab2JZMi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 08:38:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37788 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932607Ab2JZMi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 08:38:57 -0400
Received: (qmail 22146 invoked by uid 107); 26 Oct 2012 12:39:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 08:39:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 08:38:54 -0400
Content-Disposition: inline
In-Reply-To: <1351180699-24695-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208436>

On Thu, Oct 25, 2012 at 04:58:19PM +0100, Ben Walton wrote:

> Sed on Mac OS X doesn't handle \s in a sed expressions so use a more
> portable character set expression instead.
> 
> Signed-off-by: Ben Walton <bdwalton@gmail.com>

Thanks, I think this simple solution is the best.

-Peff
