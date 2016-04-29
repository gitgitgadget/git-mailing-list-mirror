From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 10:08:17 -0400
Message-ID: <20160429140817.GA26643@sigill.intra.peff.net>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
 <57230F71.2020401@alum.mit.edu>
 <xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
 <57233E19.4000200@alum.mit.edu>
 <20160429121228.GA27952@sigill.intra.peff.net>
 <572367B4.4050207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:08:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw95v-0004bH-7U
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbcD2OIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:08:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:59098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753127AbcD2OIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:08:21 -0400
Received: (qmail 8080 invoked by uid 102); 29 Apr 2016 14:08:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 10:08:20 -0400
Received: (qmail 22007 invoked by uid 107); 29 Apr 2016 14:08:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 10:08:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 10:08:17 -0400
Content-Disposition: inline
In-Reply-To: <572367B4.4050207@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292999>

On Fri, Apr 29, 2016 at 03:55:00PM +0200, Michael Haggerty wrote:

> It's beyond the ambition of this patch to fix this old rename_ref()
> code, but...
> [...]

Thanks for the explanation. That all makes sense to me, and I can
definitely live with "historical warts that aren't worth touching in
this series" as the verdict.

-Peff
