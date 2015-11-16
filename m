From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6] Add git-grep threads param
Date: Mon, 16 Nov 2015 08:56:14 -0500
Message-ID: <20151116135614.GA13471@sigill.intra.peff.net>
References: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA1F@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"john@keeping.me.uk" <john@keeping.me.uk>,
	Victor Leschuk <vleschuk@gmail.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 14:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyKGd-0007Nq-0e
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 14:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbbKPN4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 08:56:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:58090 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751929AbbKPN4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 08:56:17 -0500
Received: (qmail 21264 invoked by uid 102); 16 Nov 2015 13:56:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 07:56:17 -0600
Received: (qmail 12833 invoked by uid 107); 16 Nov 2015 13:56:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 08:56:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2015 08:56:14 -0500
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA1F@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281340>

On Mon, Nov 16, 2015 at 05:11:16AM -0800, Victor Leschuk wrote:

> The earlier version of this patch is already included in /pu branch,
> however as we all agreed ($gmane/280299) we have changed the default
> behavior and the meaning of "0". The question is: what is the right
> way to include changes from patch v6 (this one) into already merged
> patch to pu?

Merging to "pu" does not really mean anything; it is simply that the
maintainer has picked it up as a possible topic of interest. Patches can
(and often are) still re-written in that state.

Junio is on vacation for a few weeks, and I'm acting as maintainer in
the interim. I've added your v6 to my pile of patches to look at, but I
haven't gone over it carefully yet.

-Peff
