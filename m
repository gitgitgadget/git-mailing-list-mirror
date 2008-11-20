From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] tg patch: disable pager and colors for git-diff
Date: Thu, 20 Nov 2008 15:34:55 +0100
Message-ID: <20081120143455.GH10544@machine.or.cz>
References: <1227189062-11951-1-git-send-email-fonseca@diku.dk> <20081120135710.GA16303@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: madduck@debian.org, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Adh-0000Yv-4Z
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbYKTOe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbYKTOe6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:34:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37843 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413AbYKTOe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:34:57 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id A4FC63939836; Thu, 20 Nov 2008 15:34:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081120135710.GA16303@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101442>

On Thu, Nov 20, 2008 at 02:57:10PM +0100, Jonas Fonseca wrote:
> When output is not redirected to a file, git brings up the pager for
> only the diff, which can be confusing, so disable with --no-pager.
> git-diff is a porcelain command and thus subject to color options. Use
> --no-color, to avoid the patch being corrupted with terminal escape
> characters when color.diff=always.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

I still don't understand how did that color thing happen - shouldn't
git diff avoid spewing out colors when the output is not a tty? And when
it is, I want the colors myself, too.

Good point with the --no-pager, but in that case, tg patch itself should
by default invoke the pager, since it really is very desirable.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
