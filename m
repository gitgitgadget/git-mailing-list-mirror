From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 10:11:39 -0400
Message-ID: <20090424141139.GC10761@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxM9W-0005PB-Ol
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759497AbZDXOLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759484AbZDXOLt
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:11:49 -0400
Received: from peff.net ([208.65.91.99]:59248 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759458AbZDXOLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 10:11:48 -0400
Received: (qmail 28650 invoked by uid 107); 24 Apr 2009 14:11:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 10:11:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 10:11:39 -0400
Content-Disposition: inline
In-Reply-To: <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117439>

On Thu, Apr 23, 2009 at 03:45:46PM -0500, Michael Witten wrote:

> However, a discussion of blobs, trees, commits, objects, and
> references isn't necessarily low-level. It seems to me that it is a
> high-level understanding of the git world. Without those
> *definitions*, people are left to their own wrong, inconsistent
> thoughts.
> 
> The low-level stuff is HOW those concepts have been used in the
> implementation of git: Where certain files are stored, how certain
> bytes are organized in memory, what are the underlying porcelain
> tools, etc. That what's low-level.

I think I wasn't clear in my original message. I didn't mean teaching
low-level stuff like plumbing or file layouts. By "bottom-up" I really
meant teaching concepts (like objects, their types, and references),
from which user operations and workflows can be explained (or often
deduced by the user). Whereas a top-down approach would _start_ with
workflows and say "To accomplish X, do Y".

So I think we are in agreement about the right "level" to start at.

-Peff
