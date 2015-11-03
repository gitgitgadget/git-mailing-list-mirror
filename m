From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] diff-highlight: add `less -r` to cmd in README
Date: Tue, 3 Nov 2015 16:14:36 -0500
Message-ID: <20151103211435.GA22484@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztiuh-0005Ys-R6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbbKCVOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:14:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:52295 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750753AbbKCVOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:14:39 -0500
Received: (qmail 634 invoked by uid 102); 3 Nov 2015 21:14:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 15:14:39 -0600
Received: (qmail 28807 invoked by uid 107); 3 Nov 2015 21:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:15:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 16:14:36 -0500
Content-Disposition: inline
In-Reply-To: <1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280819>

On Mon, Nov 02, 2015 at 09:05:31PM -0500, Jonathan Lebon wrote:

> As it is, the suggested command for trying out diff-highlight will just
> dump the whole git log output to the terminal. Let's pipe it through
> `less` so users aren't surprised on the first try.

That makes sense. I use "diff-highlight | less" myself, of course. I
think I excluded it from the README in the name of simplicity, but you
are right that it is probably better to give a complete working example.

I agree with Junio that "-R" is a more sensible default, but I don't
think that should be necessary. We already set LESS when running the
pager (and if you are overriding it, you are already in trouble, because
git itself will generate ANSI codes by default).

-Peff
