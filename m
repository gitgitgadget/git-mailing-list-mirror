From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Git fork removal?
Date: Thu, 28 Apr 2005 04:12:37 +0200
Message-ID: <20050428021237.GA8612@pasky.ji.cz>
References: <Pine.LNX.4.21.0504272127400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:07:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyQr-0000dP-Td
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVD1CMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVD1CMk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:12:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43696 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261540AbVD1CMi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 22:12:38 -0400
Received: (qmail 18735 invoked by uid 2001); 28 Apr 2005 02:12:37 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504272127400.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 03:31:18AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> I saw that "fork" was removed when going to the cg- scripts, and the
> replacements don't do the symlinked trees thing. I found the symlinked
> trees thing vital to my workflow, so I'm going to want to reintroduce
> them, or something similar. Is there some reason you went to hardlinked
> object files instead of symlinked directories?

The user. ;-)

Apparently, too many people were confused by the local/remote branches
distinctions, and even I ceased to like it gradually (BTW, Cogito still
supports working with them - it just does not offer any interface for
manipulation with them). The current scheme is much simpler and I
believe more clear.

Also, the forked repositories were not truly independent - people
actually got burnt by forking and then removing the original repository.

If this breaks your workflow, could you please describe it? Perhaps we
could find a good semantics to support both.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
