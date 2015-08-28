From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lockfile: remove function "hold_lock_file_for_append"
Date: Fri, 28 Aug 2015 13:32:10 -0400
Message-ID: <20150828173210.GB9126@sigill.intra.peff.net>
References: <1440780952-5859-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:32:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVNVi-0008Gy-AX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbbH1RcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:32:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:51581 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752312AbbH1RcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:32:13 -0400
Received: (qmail 17428 invoked by uid 102); 28 Aug 2015 17:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 12:32:12 -0500
Received: (qmail 5822 invoked by uid 107); 28 Aug 2015 17:32:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 13:32:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2015 13:32:10 -0400
Content-Disposition: inline
In-Reply-To: <1440780952-5859-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276738>

On Fri, Aug 28, 2015 at 06:55:52PM +0200, Ralf Thielow wrote:

> With 77b9b1d (add_to_alternates_file: don't add duplicate entries,
> 2015-08-10) the last caller of function "hold_lock_file_for_append"
> has been removed, so we can remove the function as well.

Heh. I have the same patch, but was holding it back until mh/tempfile
graduated to master, which it did a few days ago.  I diffed mine against
yours, and came up empty aside from one or two minor wrapping choices.

So looks good to me.

-Peff
