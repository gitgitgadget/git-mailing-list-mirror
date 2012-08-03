From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc1
Date: Fri, 3 Aug 2012 13:03:36 -0400
Message-ID: <20120803170336.GA24237@sigill.intra.peff.net>
References: <7v8ve0q4yy.fsf@alter.siamese.dyndns.org>
 <20120803161916.GA16973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 19:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxLHs-0000NA-3a
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 19:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab2HCRDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 13:03:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50755 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab2HCRDi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 13:03:38 -0400
Received: (qmail 26456 invoked by uid 107); 3 Aug 2012 17:03:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 13:03:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 13:03:36 -0400
Content-Disposition: inline
In-Reply-To: <20120803161916.GA16973@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202845>

On Fri, Aug 03, 2012 at 12:19:16PM -0400, Jeff King wrote:

> On Mon, Jul 30, 2012 at 03:06:13PM -0700, Junio C Hamano wrote:
> 
> >  * git native protocol agents learned to show software version over
> >    the wire, so that the server log can be examined to see the vintage
> >    distribution of clients.
> 
> Hmm. Is this true?
> 
> I was just flipping through some old topics of mine, and I noticed that
> the final patch of jk/version-string never got applied to the topic
> branch. It was posted here:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/199059
> 
> and you picked up the other patches in the series, but not that one. So
> I think it was just a simple mistake.
> 
> I've been running with it locally for 2 months and haven't seen any
> problem.  Unfortunately it's a bit too non-trivial to be appropriate for
> 1.7.12 at this point in the cycle, so I guess we will have to let it
> cook in the next iteration.
> 
> Here's a repost for convenience.

And here's an update to the release notes.

-- >8 --
Subject: [PATCH] RelNotes: drop version-string topic from 1.7.12

The final patch which actually turns this feature on was
never applied to the topic branch, so it did not make it
into this cycle.
---
 Documentation/RelNotes/1.7.12.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/RelNotes/1.7.12.txt b/Documentation/RelNotes/1.7.12.txt
index 786a702..cffa0db 100644
--- a/Documentation/RelNotes/1.7.12.txt
+++ b/Documentation/RelNotes/1.7.12.txt
@@ -51,10 +51,6 @@ UI, Workflows & Features
    read. The error message in this case was updated to give better
    hints to the user.
 
- * git native protocol agents learned to show software version over
-   the wire, so that the server log can be examined to see the vintage
-   distribution of clients.
-
  * "git help -w $cmd" can show HTML version of documentation for
    "git-$cmd" by setting help.htmlpath to somewhere other than the
    default location where the build procedure installs them locally;
