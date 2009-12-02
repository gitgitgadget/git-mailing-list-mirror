From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 14:26:14 -0500
Message-ID: <20091202192614.GD30778@coredump.intra.peff.net>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:26:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuqO-0002UB-NP
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZLBT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZLBT0I
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:26:08 -0500
Received: from peff.net ([208.65.91.99]:43809 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbZLBT0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:26:08 -0500
Received: (qmail 27167 invoked by uid 107); 2 Dec 2009 19:30:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 14:30:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 14:26:14 -0500
Content-Disposition: inline
In-Reply-To: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134378>

On Tue, Dec 01, 2009 at 01:27:32AM +0100, Miklos Vajna wrote:

> This is useful in case git commit --amend is used but the user wants to
> set the date of the new commit to a specified one, since GIT_AUTHOR_DATE
> is ignored in such a situation.

Do you really want to set the date to something arbitrary, or do you
just want to set it to "now"? If the latter case, do you really just
want the recently discussed --reset-author?

Also, is there a good reason why GIT_AUTHOR_DATE is not respected in
this case?  If not, should we simply be fixing that bug instead?

-Peff
