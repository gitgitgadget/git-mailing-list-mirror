From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Need help for migration from CVS to git in one go (ie,
	FORGETTING CVS history)
Date: Wed, 5 Nov 2008 15:23:48 -0800
Message-ID: <20081105232348.GP15463@spearce.org>
References: <200811060014.57046.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 00:25:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxrkG-0000a5-JI
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 00:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYKEXXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 18:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYKEXXt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 18:23:49 -0500
Received: from george.spearce.org ([209.20.77.23]:42226 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbYKEXXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 18:23:49 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7653C38151; Wed,  5 Nov 2008 23:23:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200811060014.57046.fg@one2team.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100200>

Francis Galiegue <fg@one2team.net> wrote:
> Finally, about the Eclipse plugin:
> * the README says that it has no push capacity, the popup menu says otherwise 
> (last checked last Saturday)... What should I believe?

The README is out of date.  Push is implemented, works, and folks
actually use it.  That was a nice success from our GSoC program
this year.

> * if the plugin can push, can you configure from within the plugin what 
> branches can be pushed where, or should you edit .git/config by hand?

I don't think you can edit saved configurations in the plugin UI.
The APIs are there underneath to do the reading/writing and most
of the UI to show a configuration is present, I just don't think
anyone has wired the two together for saved configurations inside
of .git/config.  So yea, edit by hand.

> * "git stash": is it supported?

Not in Eclipse, no.

> * can you "copy" a commit, or even a set of commits, and "cherry-pick" them 
> into another branch? Or even rebase a branch onto antoher?

Not in Eclipse, no.

-- 
Shawn.
