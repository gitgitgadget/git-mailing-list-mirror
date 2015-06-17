From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fetch-pack: check for shallow if depth given
Date: Wed, 17 Jun 2015 13:00:01 -0400
Message-ID: <20150617170001.GC22689@peff.net>
References: <xmqqzj46dlfw.fsf@gitster.dls.corp.google.com>
 <1434541694-12748-1-git-send-email-adgar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Mike Edgar <adgar@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:00:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Gh7-00047D-ID
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbbFQRAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 13:00:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:47500 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753033AbbFQRAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:00:03 -0400
Received: (qmail 18847 invoked by uid 102); 17 Jun 2015 17:00:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 12:00:03 -0500
Received: (qmail 27236 invoked by uid 107); 17 Jun 2015 17:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 13:00:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 13:00:01 -0400
Content-Disposition: inline
In-Reply-To: <1434541694-12748-1-git-send-email-adgar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271871>

On Wed, Jun 17, 2015 at 07:48:14AM -0400, Mike Edgar wrote:

> When a repository is first fetched as a shallow clone, either by
> git-clone or by fetching into an empty repo, the server's capabilities
> are not currently consulted. The client will send shallow requests even
> if the server does not understand them, and the resulting error may be
> unhelpful to the user. This change pre-emptively checks so we can exit
> with a helpful error if necessary.
> 
> Signed-off-by: Mike Edgar <adgar@google.com>

Looks good to me.

-Peff
