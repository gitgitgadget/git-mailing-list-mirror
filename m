From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] ls-remote: document --quiet option
Date: Sun, 17 Jan 2016 09:47:26 -0500
Message-ID: <20160117144726.GB15519@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453028643-13978-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 15:47:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKoc9-0001fT-EX
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 15:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbcAQOr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 09:47:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:55088 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbcAQOr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 09:47:29 -0500
Received: (qmail 5457 invoked by uid 102); 17 Jan 2016 14:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jan 2016 09:47:28 -0500
Received: (qmail 1883 invoked by uid 107); 17 Jan 2016 14:47:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jan 2016 09:47:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2016 09:47:26 -0500
Content-Disposition: inline
In-Reply-To: <1453028643-13978-2-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284257>

On Sun, Jan 17, 2016 at 12:03:59PM +0100, Thomas Gummerer wrote:

> cefb2a5e3 ("ls-remote: print URL when no repo is specified") added a
> quiet option to ls-remote, but didn't add it to the documentation.  Add
> it.

Great. I love it when a patch series starts by tidying up the area.

The patch looks obviously correct. Should we do the same for "--refs",
which looks like the only other undocumented option (aside from --exec,
but I think that's just for historical compatibility).

-Peff
