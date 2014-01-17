From: Jeff King <peff@peff.net>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such
 ref: ''" for branches without an upstream
Date: Thu, 16 Jan 2014 21:21:52 -0500
Message-ID: <20140117022152.GB12444@sigill.intra.peff.net>
References: <52D8827E.3060007@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, john@keeping.me.uk
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3z4K-00066r-GX
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaAQCV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:21:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:33911 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751960AbaAQCVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:21:54 -0500
Received: (qmail 9019 invoked by uid 102); 17 Jan 2014 02:21:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 20:21:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 21:21:52 -0500
Content-Disposition: inline
In-Reply-To: <52D8827E.3060007@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240559>

On Thu, Jan 16, 2014 at 05:08:14PM -0800, Siddharth Agarwal wrote:

> With git-next, where git pull --rebase can print out "fatal: No such
> ref: ''" if git pull --rebase is run on branches without an upstream.

This is already fixed in bb3f458 (rebase: fix fork-point with zero
arguments, 2014-01-09), I think.

-Peff
