From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git pull on ia64 linux tree
Date: Thu, 28 Apr 2005 00:58:21 +0200
Message-ID: <20050427225821.GI22956@pasky.ji.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvPg-00086w-UE
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVD0W6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVD0W6j
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:58:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39852 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262072AbVD0W62 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 18:58:28 -0400
Received: (qmail 12922 invoked by uid 2001); 27 Apr 2005 22:58:21 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 12:35:07AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> One problem with this is that "grep" always thinks lines end in '\n', and 
> what we'd really want (from a scriptability angle) is
> 
> 	diff-tree -z -r $orig $final | grep -0 '^-'
> 
> but I don't think you can tell grep to think that lines are
> zero-terminated instead of terminated with \n'. But I don't see how to do
> that with grep.

Actually, grep has -z parameter. ;-)

Fixed and pushed out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
