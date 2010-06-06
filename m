From: Jeff King <peff@peff.net>
Subject: Re: rebase --continue confusion
Date: Sun, 6 Jun 2010 18:18:53 -0400
Message-ID: <20100606221853.GG6993@coredump.intra.peff.net>
References: <4C01B855.7080409@gmail.com>
 <m3bpbo1f3f.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:19:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOBI-0004D6-Ph
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0FFWSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:18:55 -0400
Received: from peff.net ([208.65.91.99]:51747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab0FFWSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:18:55 -0400
Received: (qmail 12537 invoked by uid 107); 6 Jun 2010 22:19:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:19:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:18:53 -0400
Content-Disposition: inline
In-Reply-To: <m3bpbo1f3f.fsf@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148554>

On Sun, Jun 06, 2010 at 09:10:44AM -0400, Eli Barzilay wrote:

> There are a number of these things that I asked about recently.
> Here's another similarly one:
> 
>   $ git add foo
>   $ git status -s
>   M  foo
>   $ git commit --amend foo
>   # On branch master
>   # No changes
>   $ git status -s
>   M  foo

I'm confused. Is there some context for when you are issuing these
commands? Because the "git commit --amend foo" should actually commit
foo, and does for me.

-Peff
