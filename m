From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] Makefile: add check-headers target
Date: Sat, 6 Sep 2014 19:58:09 -0400
Message-ID: <20140906235808.GA20625@peff.net>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
 <540B7AA0.4050208@web.de>
 <20140906225738.GA15039@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 01:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQPs6-0004ET-JI
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 01:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbaIFX6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 19:58:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:45134 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751941AbaIFX6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 19:58:11 -0400
Received: (qmail 30558 invoked by uid 102); 6 Sep 2014 23:58:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Sep 2014 18:58:11 -0500
Received: (qmail 22013 invoked by uid 107); 6 Sep 2014 23:58:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Sep 2014 19:58:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Sep 2014 19:58:09 -0400
Content-Disposition: inline
In-Reply-To: <20140906225738.GA15039@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256606>

On Sat, Sep 06, 2014 at 03:57:39PM -0700, David Aguilar wrote:

> > This checks all .h files in the top directory.  Would it be better
> > to check all files in LIB_H instead?  Or even all .h files in the
> > tree (using "git ls-files '*.h'")?  The latter might be difficult
> > because some of the files in compat/ #include system-specific
> > headers.
> 
> Ah, I hadn't thought of using LIB_H; that might be the most
> practical solution.

Maybe not; see d85b0dff7297fb43a57a0c1e697417bb7723247c, which is in
'next'.

-Peff
