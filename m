From: Jeff King <peff@peff.net>
Subject: Re: `git log --graph` with multiple roots is confusing
Date: Wed, 9 Jul 2014 02:51:45 -0400
Message-ID: <20140709065145.GB14682@sigill.intra.peff.net>
References: <CALygMcDXjMUcq=8ERVTES+5qNjLMe_OFPbmeqAosU7qmk=QuUQ@mail.gmail.com>
 <20140630080829.GB13153@serenity.lan>
 <CALygMcDr2N2oyLOkVzE3XqAXu8DMSe_LhHXdL0QwN8W3JaV9zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Gary Fixler <gfixler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4ljM-0001IW-8T
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 08:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaGIGvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 02:51:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:58536 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751450AbaGIGvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 02:51:47 -0400
Received: (qmail 28660 invoked by uid 102); 9 Jul 2014 06:51:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 01:51:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 02:51:45 -0400
Content-Disposition: inline
In-Reply-To: <CALygMcDr2N2oyLOkVzE3XqAXu8DMSe_LhHXdL0QwN8W3JaV9zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253072>

On Mon, Jun 30, 2014 at 03:04:19AM -0700, Gary Fixler wrote:

> I just made a new test repo, added and fetched two unrelated repos,
> and then did the log view (all/graph/decorate/oneline), and tacked on
> --boundary, but saw no change. The root commits looked the same.

There was some discussion a while back on making root commits more
apparent in the graph view:

  http://article.gmane.org/gmane.comp.version-control.git/239580

That topic has stalled, but perhaps you can help push it forward.

-Peff
