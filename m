From: Jeff King <peff@peff.net>
Subject: Re: What about renaming ga -i [r]evert to [r]eset ?
Date: Sun, 5 Oct 2008 12:41:25 -0400
Message-ID: <20081005164124.GA31903@coredump.intra.peff.net>
References: <20081005152654.GA13618@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 18:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmWgx-0001mB-88
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759521AbYJEQlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757519AbYJEQlb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:41:31 -0400
Received: from peff.net ([208.65.91.99]:4670 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528AbYJEQl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:41:29 -0400
Received: (qmail 16256 invoked by uid 111); 5 Oct 2008 16:41:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 12:41:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 12:41:25 -0400
Content-Disposition: inline
In-Reply-To: <20081005152654.GA13618@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97520>

On Sun, Oct 05, 2008 at 05:26:54PM +0200, Marc Weber wrote:

> You can get the patch from git://mawercer.de/git_my_patches branch
> revert_to_reset_renaming
> 
> Maybe someone of you beeing more familiar with perl,
> git-add--interactive and git can review it maybe telling me what should
> be done so that it can be committed upstream?

Please take a look at Documentation/SubmittingPatches. In particular:

  - this change should be split into two different patches (one for
    s/revert/reset, and one for adding "checkout").

  - patches should be sent to the list for review, as described in
    SubmittingPatches

  - commit messages should be formatted in the usual git way. I.e,

      one-line description of the change

      more elaborate description of the change, including
      details of the change, but most importantly discussing
      the rationale for the change. In order for your patch to
      be accepted, you must explain _why_ you think it's a good
      idea.

-Peff
