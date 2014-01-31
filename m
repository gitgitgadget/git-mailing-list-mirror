From: Jeff King <peff@peff.net>
Subject: Re: Performance regression in git fetch between 1.8.3.4 and 1.8.5.3
Date: Fri, 31 Jan 2014 16:35:05 -0500
Message-ID: <20140131213505.GA21264@sigill.intra.peff.net>
References: <20140131210154.GA632399@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 22:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Lk2-0003A4-9V
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 22:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbaAaVfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 16:35:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:42381 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932629AbaAaVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 16:35:07 -0500
Received: (qmail 23297 invoked by uid 102); 31 Jan 2014 21:35:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 31 Jan 2014 15:35:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Jan 2014 16:35:05 -0500
Content-Disposition: inline
In-Reply-To: <20140131210154.GA632399@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241321>

On Fri, Jan 31, 2014 at 09:02:15PM +0000, brian m. carlson wrote:

> At work, we recently upgraded our git version from 1.8.3.4 to 1.8.5.3.
> We've noticed a significant performance regression in git fetch.  The
> numbers below are for an up-to-date branch (that is, no data is actually
> being fetched) for a git-over-ssh remote on our gitorious server.

Is it better with v1.9-rc1? There was a slowdown in v1.8.4.2 that I
addressed with commit 200abe7 (which is slated for v1.9).

-Peff
