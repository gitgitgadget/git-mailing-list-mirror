From: Jeff King <peff@peff.net>
Subject: Re: git-format-patch patch
Date: Thu, 18 Dec 2008 03:35:15 -0500
Message-ID: <20081218083515.GB29356@coredump.intra.peff.net>
References: <877i5yy149.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Dec 18 09:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDEN1-000292-3z
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 09:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbYLRIfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 03:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYLRIfS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 03:35:18 -0500
Received: from peff.net ([208.65.91.99]:1166 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbYLRIfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 03:35:17 -0500
Received: (qmail 32747 invoked by uid 111); 18 Dec 2008 08:35:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Dec 2008 03:35:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Dec 2008 03:35:15 -0500
Content-Disposition: inline
In-Reply-To: <877i5yy149.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103446>

On Thu, Dec 18, 2008 at 04:53:42AM +0800, jidanni@jidanni.org wrote:

> I'm still reading the manpage about submitting proper patches, so for now:

It looks like you didn't even use git to create it (since it is a
context diff and the filenames are obviously bogus). If you are
committed to improving git, then surely using it is not so bad? :)

Try cloning git://git.kernel.org/pub/scm/git/git.git, or if you just
have a tarball, at least do "cd /path/to/git && git init && git add . &&
git commit -m 'import from git version $whatever'". Then you can make
your changes and have git track them and prepare them for submission.

Then read Documentation/SubmittingPatches, which covers some of the
basics. Besides the format not being applicable by regular git tools:

 - there is no commit message describing the changes, nor the reasoning
   behind them

 - it was not sent to the maintainer (who does read the list, but does
   not always read every message).

>   --in-reply-to=Message-Id::
>   	Make the first mail (or all the mails with --no-thread) appear as a
>   	reply to the given Message-Id, which avoids breaking threads to
> ! 	provide a new patch series. Generates coresponding References and
> ! 	In-Reply-To headers. Angle brackets around <Message-Id> are optional.

As for the change itself, it looks reasonable to me.

-Peff
