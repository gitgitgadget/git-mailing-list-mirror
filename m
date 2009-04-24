From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Removed redundant static functions such as
	update_tracking_ref() and verify_remote_names() from
	builtin-send-pack.c, and made the ones in transport.c not be static
	so they can be used instead.
Date: Fri, 24 Apr 2009 17:23:14 -0400
Message-ID: <20090424212313.GA14435@coredump.intra.peff.net>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net> <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxStD-0003tK-F5
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbZDXVXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758062AbZDXVXZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:23:25 -0400
Received: from peff.net ([208.65.91.99]:42355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676AbZDXVXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:23:24 -0400
Received: (qmail 31563 invoked by uid 107); 24 Apr 2009 21:23:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 17:23:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 17:23:14 -0400
Content-Disposition: inline
In-Reply-To: <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117490>

On Fri, Apr 24, 2009 at 04:13:14PM -0500, Andy Lester wrote:

> This was what I was looking for.  I think what I'll do is fold your  
> message into Documentation/SubmittingPatches and submit that as a patch 
> first.

That probably makes sense.

I keep thinking about writing a separate "how to write a good commit
message" document that would be more universal than just "here's how you
submit a patch to git". And some of what I wrote to you could probably
go in such a document. But I don't know if it makes sense to start a new
document just with what I said there; it might be a bit sparse (OTOH,
maybe people would then be encouraged to add their tips to it).

-Peff
