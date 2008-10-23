From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement git remote mv
Date: Wed, 22 Oct 2008 23:52:14 -0400
Message-ID: <20081023035213.GA8396@coredump.intra.peff.net>
References: <JQScKsOjmj-C7kmMPApAxZ3UDmaTZ1j0HkObQuCveJ9n4G-4o6Zxbw@cipher.nrlssc.navy.mil> <1224724704-12700-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 05:53:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsrGU-00087y-OZ
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 05:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbYJWDwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 23:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbYJWDwT
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 23:52:19 -0400
Received: from peff.net ([208.65.91.99]:2697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbYJWDwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 23:52:18 -0400
Received: (qmail 6156 invoked by uid 111); 23 Oct 2008 03:52:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 23:52:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 23:52:14 -0400
Content-Disposition: inline
In-Reply-To: <1224724704-12700-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98940>

On Thu, Oct 23, 2008 at 03:18:24AM +0200, Miklos Vajna wrote:

> The new rename subcommand does the followings:
> 
> 1) Renames the remote.foo configuration section to remote.bar
> 
> 2) Updates the remote.bar.fetch refspecs
> 
> 3) Updates the branch.*.remote settings
> 
> 4) Renames the tracking branches.

I can't help but notice that the word "rename" appears all over the
commit description and in the code, but not in the user interface. Maybe
"rename" would be a better name for the command instead of (or in
addition to) "mv"?

-Peff
