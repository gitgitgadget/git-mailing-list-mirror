From: Petr Baudis <pasky@suse.cz>
Subject: Should Cogito scripts be renamed?
Date: Fri, 16 Sep 2005 01:46:07 +0200
Message-ID: <20050915234607.GA10867@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 16 01:46:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG3Qk-0000HY-Fq
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 01:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVIOXqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 19:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVIOXqL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 19:46:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56215 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030345AbVIOXqK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 19:46:10 -0400
Received: (qmail 29769 invoked by uid 2001); 16 Sep 2005 01:46:08 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8651>

  Hello,

  I'd like to hear the opinion of Cogito users about renaming the Cogito
commands accordingly to the GIT big renames. This would be:

	cg-pull -> cg-fetch
	cg-update -> cg-pull

  The pros: Terminological consistency with GIT. Some also might perceive
this naming like clearer (I don't, but that's probably the matter of
your environment of origin and opinion).

  The cons: Breaking backwards compatibility and confusing users. The
situation is more vexing since 'cg-pull' would change its meaning from
fetching to fetching+merging. So that alone would require four-phased
renaming (cg-fetch alias, removing cg-pull, wait long time, cg-pull
alias, removing cg-update).

  I'm actually rather opposed to the change. Cogito is getting
established, real-world projects and a lot of people in general already
use it, and this would break the finger habits for all of them, etc.
What do you think?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
