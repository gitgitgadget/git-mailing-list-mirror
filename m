From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 15:53:05 -0500
Message-ID: <20091127205305.GB26921@coredump.intra.peff.net>
References: <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
 <6839293b0911270827x54947c64q5f93e37664bc20f3@mail.gmail.com>
 <7vk4xbn7nl.fsf@alter.siamese.dyndns.org>
 <4B101ED1.9000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Uri Okrent <uokrent@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 21:53:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7oS-00013E-Mo
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZK0Uw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbZK0Uw5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:52:57 -0500
Received: from peff.net ([208.65.91.99]:56478 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbZK0Uw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:52:56 -0500
Received: (qmail 29515 invoked by uid 107); 27 Nov 2009 20:57:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 15:57:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 15:53:05 -0500
Content-Disposition: inline
In-Reply-To: <4B101ED1.9000607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133936>

On Fri, Nov 27, 2009 at 10:47:45AM -0800, Uri Okrent wrote:

> >Changing "grep" is too late for 1.7.0, but we are trying to find an easy
> >migration path like you mentioned in your message and that is exactly what
> >this thread is about.
> 
> I wasn't actually suggesting we change grep for 1.7. As a matter of
> fact, my personal opinion (which I probably neglected to mention) is
> that grep default behavior should stay the same since it is semantically
> closer to unix (or gnu) grep.

Keeping consistency with non-git grep has been mentioned a few times in
this thread.  I really don't understand how default file selection is
supposed to maintain consistency with non-git grep. Regular grep
defaults to stdin if no paths are given. That mode doesn't make any
sense for git grep.

So of the two options (grepping the list of files from the full tree, or
the list of files rooted at the current directory), how is one closer to
non-git grep than the other?

-Peff
