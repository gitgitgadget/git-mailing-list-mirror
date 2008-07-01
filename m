From: Jeff King <peff@peff.net>
Subject: Re: git push requires a subsequent git reset --hard ?
Date: Tue, 1 Jul 2008 13:19:13 -0400
Message-ID: <20080701171913.GA8911@sigill.intra.peff.net>
References: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDjX9-0001Ck-Kr
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 19:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYGARTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYGARTS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 13:19:18 -0400
Received: from peff.net ([208.65.91.99]:3599 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbYGARTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 13:19:17 -0400
Received: (qmail 22345 invoked by uid 111); 1 Jul 2008 17:19:15 -0000
Received: from lawn-128-61-25-46.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.46)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 01 Jul 2008 13:19:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2008 13:19:13 -0400
Content-Disposition: inline
In-Reply-To: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87056>

On Tue, Jul 01, 2008 at 07:51:26PM +0300, Neshama Parhoti wrote:

> On my return, I just "git push myuser@my-station:/my/git/repo" from my laptop.
> It seemed to work with no probs.
> On my station the git repo got the new commits, as I can see in
> git-log, but the actual files were left untouched.
> 
> So I need to do something like "git reset --hard HEAD" to get
> the changes into the local files.
> 
> Is that considered normal ?
> 
> or did I do something wrong ?

See:

  http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

  and

  http://git.or.cz/gitwiki/GitFaq#head-46de97a5ac549d3adf406c22674b3325ae25d09c

What you did is OK, but there is a better way to do it.

-Peff
