From: Jeff King <peff@peff.net>
Subject: Re: how to do "git merge --abort"
Date: Fri, 21 Aug 2009 11:19:26 -0400
Message-ID: <20090821151926.GE6850@coredump.intra.peff.net>
References: <20090821145157.GA6471@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 17:19:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeVtw-0006Jb-1E
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 17:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZHUPT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbZHUPT0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 11:19:26 -0400
Received: from peff.net ([208.65.91.99]:46854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbZHUPT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 11:19:26 -0400
Received: (qmail 1644 invoked by uid 107); 21 Aug 2009 15:19:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 21 Aug 2009 11:19:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2009 11:19:26 -0400
Content-Disposition: inline
In-Reply-To: <20090821145157.GA6471@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126731>

On Fri, Aug 21, 2009 at 10:51:57PM +0800, bill lam wrote:

> How to abort a merge if it said there are conflicts but I do not want
> to (or can not) resolve it for the moment.  I can not find the --abort
> option as that for git-rebase.

It is spelled "git reset --merge" (though --merge was introduced in
v1.6.1; prior to that, you had to use "git reset --hard").

I don't know if it is worth adding "git merge --abort" as syntactic
sugar.

-Peff
