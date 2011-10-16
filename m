From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2011, #05; Fri, 14)
Date: Sun, 16 Oct 2011 12:53:29 -0400
Message-ID: <20111016165329.GA14226@sigill.intra.peff.net>
References: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 18:53:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFTy5-0005S7-52
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 18:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab1JPQxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 12:53:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33472
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab1JPQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 12:53:33 -0400
Received: (qmail 31519 invoked by uid 107); 16 Oct 2011 16:53:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 16 Oct 2011 12:53:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2011 12:53:29 -0400
Content-Disposition: inline
In-Reply-To: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183725>

On Fri, Oct 14, 2011 at 04:23:21PM -0700, Junio C Hamano wrote:

> * jk/pull-rebase-with-work-tree (2011-10-13) 1 commit
>  - pull,rebase: handle GIT_WORK_TREE better
> 
> Looked reasonable.
> Will merge to 'next'.

I'm not so sure. Didn't you demonstrate that cd_to_toplevel as-is will
not actually go to the toplevel if we're outside of the work tree?

And changing it is non-trivial, because there may be weird cases that
rely on staying there? See my final note in the thread:

  http://article.gmane.org/gmane.comp.version-control.git/183519

> * jk/daemon-msgs (2011-10-14) 1 commit
>  - daemon: give friendlier error messages to clients
> 
> Will merge to 'next'.

I'm happy to tweak the "access denied" message if other people want. I
kind of hoped it wouldn't matter, and that most sites would use
--informative-errors.

-Peff
