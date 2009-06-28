From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Sun, 28 Jun 2009 14:52:18 -0400
Message-ID: <20090628185218.GB8634@sigio.peff.net>
References: <Pine.LNX.4.64.0906272248570.11453@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Unknown <borg@uu3.net>
X-From: git-owner@vger.kernel.org Sun Jun 28 20:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKzSW-0008Ad-Fo
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 20:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbZF1Su0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 14:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZF1Su0
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 14:50:26 -0400
Received: from peff.net ([208.65.91.99]:58883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbZF1SuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 14:50:25 -0400
Received: (qmail 8676 invoked by uid 1000); 28 Jun 2009 18:52:18 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0906272248570.11453@cube>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122417>

On Sat, Jun 27, 2009 at 10:57:13PM +0200, Unknown wrote:

> Here is a tiny patch adding -q option to git status.
> It means -uno (Show no untracked files).
> 
> Not sure where to add that in documentation.
> Maybe in git-commit man just below -u:
> -q (for git-status only, equals to -uno).
> Or something like this?

I'm not sure if this is a good idea. As you mention, there is already
"-uno" to accomplish the same thing. So we are making the interface
redundant.

It seems from the subject like you are trying to emulate a similar
option in "svn status". But my understanding (and I was never a big
subversion user, so I am going off of things said on the git list) is
that there are quite a few differences between "svn status" and "git
status".  Enough that we do not want users to really equate them (a
subject which has come up over and over on the list).

In other words, it seems like we are at best simply adding a redundant
option, and at worst, confusing people even more about the equivalence
between the "status" commands of the two systems.

-Peff
