From: Petr Baudis <pasky@suse.cz>
Subject: server-info dumbing-down
Date: Wed, 7 Dec 2005 22:58:53 +0100
Message-ID: <20051207215853.GL22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 23:01:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek7JA-0003zv-TM
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 22:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVLGV6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 16:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVLGV6i
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 16:58:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:65418 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030381AbVLGV6h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 16:58:37 -0500
Received: (qmail 21488 invoked by uid 2001); 7 Dec 2005 22:58:53 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13347>

  Hello,

  I've noticed few commits from Dec 4 landing into the git repository,
which remove various computations and corresponding lines from the
server info (3e15c67 and few ancestors). I'm curious about this - were
the computations that hugely computationally expensive? If not, wouldn't
it be better to leave it in for future use (since it doesn't cost a lot)
rather than making the future deployment of anything using this data
much harder since the server infos won't have it anymore?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
