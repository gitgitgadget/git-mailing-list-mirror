From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 00:23:27 -0700
Message-ID: <20150724072325.GC2111@peff.net>
References: <20150723012343.GA21000@peff.net>
 <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:23:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXKR-0005Zj-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbGXHXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:23:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:34400 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751974AbbGXHXb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:23:31 -0400
Received: (qmail 7813 invoked by uid 102); 24 Jul 2015 07:23:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 02:23:31 -0500
Received: (qmail 17858 invoked by uid 107); 24 Jul 2015 07:23:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 03:23:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 00:23:27 -0700
Content-Disposition: inline
In-Reply-To: <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274557>

On Thu, Jul 23, 2015 at 03:46:33PM -0700, Junio C Hamano wrote:

> Admittedly, that
> merely is saying that "--first-parent" is not a solution to such a
> project, and does not say much about the usefulness of the new
> configuration, so I'd queue it as-is.

Yeah, I agree that this patch does not make a judgement on particular
workflows, and can stand on its own. I buried a related deep in a
footnote in my other email, so let me bring it up again here.

I am not entirely convinced this won't bite somebody who gets a sha1
from some other source, and then wants to run:

  git log $some_other_sha1

who might be quite confused to start a first-parent traversal from
somewhere other than the tip of "master" or the tip of a topic branch.

-Peff
