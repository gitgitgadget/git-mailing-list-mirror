From: Jeff King <peff@peff.net>
Subject: Re: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 08:41:25 -0400
Message-ID: <20150810124125.GC32371@sigill.intra.peff.net>
References: <loom.20150810T124037-407@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 14:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOmOX-0000yp-2H
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 14:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbbHJMlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 08:41:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:42968 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752071AbbHJMla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 08:41:30 -0400
Received: (qmail 9824 invoked by uid 102); 10 Aug 2015 12:41:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 07:41:30 -0500
Received: (qmail 4978 invoked by uid 107); 10 Aug 2015 12:41:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 08:41:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 08:41:25 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150810T124037-407@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275614>

On Mon, Aug 10, 2015 at 10:42:30AM +0000, Ed Avis wrote:

> I would find it useful to ask 'git stash pop' to always drop the stash after
> applying it to the working tree, even if there were conflicts.  (Only if there
> was some hard error, such as an I/O error updating some of the files, should
> the stash be left on the stack.)

Hmm. That seems rather dangerous, but hey, if it's not the default, I
guess it is your own foot that you are shooting.

> Would a patch for such an --always-drop flag be accepted?

I doubt you will get a good answer to that question; the attitude here
is usually "well, we would have to see the patch". For instance, I don't
know how easy it will be to tell merge conflicts apart from I/O errors.
Figuring that out will probably be part of a rough draft patch.

-Peff
