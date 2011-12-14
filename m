From: Jeff King <peff@peff.net>
Subject: Re: Suppressing the user.name warning
Date: Wed, 14 Dec 2011 17:16:08 -0500
Message-ID: <20111214221608.GA12644@sigill.intra.peff.net>
References: <4EE91A1D.6080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Levitt <jay.levitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 23:16:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rax7Z-0005o0-1o
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 23:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268Ab1LNWQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 17:16:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50229
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547Ab1LNWQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 17:16:10 -0500
Received: (qmail 3094 invoked by uid 107); 14 Dec 2011 22:22:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 17:22:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 17:16:08 -0500
Content-Disposition: inline
In-Reply-To: <4EE91A1D.6080908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187173>

On Wed, Dec 14, 2011 at 04:50:21PM -0500, Jay Levitt wrote:

> Is there a way to suppress the user.name/email warning without
> configuring them in .gitconfig? I want to pass them in SSH as
> GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL; git uses the values, but still
> warns me every time.
> 
> Seems like if git can get that data in any form, it shouldn't
> complain about not having it.  No?

Git should not be complaining if it gets the data from the environment.
However, you should also be setting GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL. Otherwise they will come from the passwd file, and
git will issue the warning.

-Peff
