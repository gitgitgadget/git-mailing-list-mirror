From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log vs git-rev-list
Date: Fri, 30 May 2008 13:22:37 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805301320460.3141@woody.linux-foundation.org>
References: <20080530165641.GG18781@machine.or.cz> <alpine.LFD.1.10.0805301021310.3141@woody.linux-foundation.org> <20080530194635.GI593@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 22:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2B8Q-0008MK-Ot
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYE3UWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYE3UWn
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:22:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50850 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752009AbYE3UWm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 16:22:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UKMciQ018303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 13:22:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UKMcab009697;
	Fri, 30 May 2008 13:22:38 -0700
In-Reply-To: <20080530194635.GI593@machine.or.cz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.395 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83323>



On Fri, 30 May 2008, Petr Baudis wrote:
> 
> Because it confused me, I'm probably not the first to be confused and it
> will probably confuse others in the future too. The UI should be more
> consistent.

Btw, the reason this is irrelevant is that "git rev-list" isn't even a UI. 
It's internal plumbing, and almost all of it's flags etc are directly from 
historical reasons. IOW, it does bisection because it used to be the only 
program that did any revision walking. It can do pretty much what git log 
does for the same reason.

So breaking git rev-list because somebody thinks it's "UI" is odd totally 
misses the whole _point_ of the command.

		Linus
