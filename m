From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-remote - Unset core.origin when deleting the
	default remote
Date: Tue, 15 Jan 2008 11:50:41 -0500
Message-ID: <20080115165041.GB9478@coredump.intra.peff.net>
References: <478A3284.1000102@gmail.com> <1200241631-3300-1-git-send-email-mlevedahl@gmail.com> <1200241631-3300-2-git-send-email-mlevedahl@gmail.com> <20080114110512.GA12723@coredump.intra.peff.net> <478C3E75.2030801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.org, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEp0j-0006Be-K3
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 17:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYAOQup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 11:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYAOQup
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 11:50:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3791 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbYAOQuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 11:50:44 -0500
Received: (qmail 14281 invoked by uid 111); 15 Jan 2008 16:50:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 15 Jan 2008 11:50:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2008 11:50:41 -0500
Content-Disposition: inline
In-Reply-To: <478C3E75.2030801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70531>

On Tue, Jan 15, 2008 at 12:02:45AM -0500, Mark Levedahl wrote:

>> I'm not sure I see the use case that this helps.
>>   
> Just being thorough: the man page claims that "git remote rm foo" removes 
> all mention of remote foo.

I was going to respond "by that rationale, 'git remote rm' should be
removing branch.*.remote keys that point to the removed remote". But
looking at the code, it already does that. So your change actually keeps
things consistent.

Not the choice I would have made, but I guess it just goes to show that
I use "vi" instead of "git remote". Consider my objection withdrawn.

-Peff
