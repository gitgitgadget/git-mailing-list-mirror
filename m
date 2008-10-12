From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 02:45:13 -0400
Message-ID: <20081012064512.GA32597@coredump.intra.peff.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 08:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kouij-0008BW-Az
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 08:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYJLGpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 02:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYJLGpQ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 02:45:16 -0400
Received: from peff.net ([208.65.91.99]:4363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbYJLGpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 02:45:15 -0400
Received: (qmail 13054 invoked by uid 111); 12 Oct 2008 06:45:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 12 Oct 2008 02:45:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 02:45:13 -0400
Content-Disposition: inline
In-Reply-To: <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98005>

On Sat, Oct 11, 2008 at 11:41:18PM -0700, Junio C Hamano wrote:

> And just make it mimic whatever folks accustomed to "svn st" would expect,
> modulo we would need two status letters to signal difference between
> (HEAD, index), and (index, worktree).  Perhaps three if you want to show
> difference between (HEAD, worktree) while at it.

I remember a long time ago you started on a parallel diff walker that
could diff the working tree, the index, and a tree at once. Do you
remember the issues with it?

I think that would be the right tool here to show each file only once,
but with multiple status flags. Something like:

  A M foo

to show that "foo" has been added since the last commit, but there are
modifications in the working tree that have not yet been staged.

-Peff
