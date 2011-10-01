From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: [PATCH] gitk: Show patch for initial commit
Date: Sat, 1 Oct 2011 20:42:16 +0200
Message-ID: <20111001184216.GA5796@kennedy.acc.umu.se>
References: <20110930215021.GA3005@kennedy.acc.umu.se>
 <4E86E343.5070704@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Oct 01 20:42:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA4W1-0000tb-8b
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 20:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab1JASmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 14:42:20 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:47562 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab1JASmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 14:42:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 677F0455;
	Sat,  1 Oct 2011 20:42:18 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id 26CDE454;
	Sat,  1 Oct 2011 20:42:17 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id 066E961; Sat,  1 Oct 2011 20:42:16 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <4E86E343.5070704@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182568>

On Sat, Oct 01, 2011 at 11:54:11AM +0200, Zbigniew J??drzejewski-Szmek wrote:
> On 09/30/2011 11:50 PM, Marcus Karlsson wrote:
> >Make gitk show the patch for the initial commit.
> >
> >Signed-off-by: Marcus Karlsson<mk@acc.umu.se>
> >---
> >  gitk-git/gitk |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/gitk-git/gitk b/gitk-git/gitk
> >index 4cde0c4..20aeae6 100755
> >--- a/gitk-git/gitk
> >+++ b/gitk-git/gitk
> >@@ -7436,7 +7436,7 @@ proc diffcmd {ids flags} {
> >  	    lappend cmd HEAD
> >  	}
> >      } else {
> >-	set cmd [concat | git diff-tree -r $flags $ids]
> >+	set cmd [concat | git diff-tree -r --root $flags $ids]
> >      }
> >      return $cmd
> >  }
> Cool, this works for me! But I think I would be really nice if gitk
> respected the configuration value of log.showroot. This would give
> nice consistency amongst the various tools.

I agree, that would be reasonable. I'll prepare a new patch with that
behavior.

Marcus
