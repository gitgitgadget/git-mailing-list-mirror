From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add post-init hook
Date: Tue, 7 Oct 2008 21:53:52 -0400
Message-ID: <20081008015352.GA29313@coredump.intra.peff.net>
References: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Wed Oct 08 03:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnOGc-0003gN-3j
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 03:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbYJHBx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 21:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbYJHBx4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 21:53:56 -0400
Received: from peff.net ([208.65.91.99]:2933 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbYJHBxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 21:53:55 -0400
Received: (qmail 11140 invoked by uid 111); 8 Oct 2008 01:53:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 07 Oct 2008 21:53:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2008 21:53:52 -0400
Content-Disposition: inline
In-Reply-To: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97755>

On Wed, Oct 08, 2008 at 12:10:33AM +0100, Jonathan del Strother wrote:

> I have a number of hooks that I have to install every time I
> create/clone a repository.  This patch adds a post-init hook that's
> perfect for setting up that sort of stuff.

Why is the --template parameter to clone and init not sufficient?

-Peff
