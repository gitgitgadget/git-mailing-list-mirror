From: Adam Spiers <git@adamspiers.org>
Subject: Re: git cherry could honour "cherry-picked from commit" messages?
Date: Mon, 7 Oct 2013 21:20:42 +0100
Message-ID: <20131007202042.GD31277@pacific.linksys.moosehall>
References: <20131007201617.GC31277@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 07 22:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTHIO-0000n0-Uj
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 22:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3JGUUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 16:20:44 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:33400 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3JGUUo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 16:20:44 -0400
Received: from localhost (0.5.1.a.e.e.2.c.9.3.4.f.4.4.1.4.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:4144:f439:c2ee:a150])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 2E1282EB7D
	for <git@vger.kernel.org>; Mon,  7 Oct 2013 21:20:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20131007201617.GC31277@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235764>

On Mon, Oct 07, 2013 at 09:16:17PM +0100, Adam Spiers wrote:
> Currently git cherry determines whether a commit has been merged
> upstream by calculating its patch-id and looking for that in the
> upstream branch.  Is there any reason why it couldn't also look for
> "(cherry picked from commit ...)" lines which are automatically added
> by cherry-pick's -x switch?  This would combat the blind spot in
> cherry's current approach concerning the case where the patch-id is
> changed by the cherry-picking process (e.g. when the diff context
> changes).
> 
> Most likely there would be good reasons to make such behaviour
> optional (e.g. via git-config), but it seems like a waste for cherry
> to complete ignore these lines which provide useful information.

Also, whether or not this approach works, it would also be useful to
introduce a config option for cherry-pick so that it adds the "(cherry
picked from commit ...)" lines by default.  When introducing this
config option, another command-line switch would be required to allow
users to negate it.
