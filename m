From: Jeff King <peff@peff.net>
Subject: Re: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 03:53:10 -0400
Message-ID: <20130904075310.GB9637@sigill.intra.peff.net>
References: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 09:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH7tu-0003dT-57
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 09:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762197Ab3IDHxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 03:53:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:34368 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762057Ab3IDHxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 03:53:14 -0400
Received: (qmail 28254 invoked by uid 102); 4 Sep 2013 07:53:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Sep 2013 02:53:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Sep 2013 03:53:10 -0400
Content-Disposition: inline
In-Reply-To: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233814>

On Wed, Sep 04, 2013 at 09:51:26AM +0200, Francis Moreau wrote:

> When rebasing a branch which contains commits with notes onto another
> branch it happens that some commits are already presents in the target
> branch.
> 
> In that case git-rebase correctly drops those (already present)
> commits but it also drops the notes associated with them.
> 
> Can the notes be transfered somehow in the target branch on the
> already present commits ?

Yes, see the notes.rewriteRef config option to enable this.

-Peff
