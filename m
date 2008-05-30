From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log vs git-rev-list
Date: Fri, 30 May 2008 13:20:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805301316580.3141@woody.linux-foundation.org>
References: <20080530165641.GG18781@machine.or.cz> <alpine.LFD.1.10.0805301021310.3141@woody.linux-foundation.org> <20080530194635.GI593@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 22:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2B68-00072Y-So
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbYE3UUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbYE3UUT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:20:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37062 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752906AbYE3UUS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 16:20:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UKKEBM018211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 13:20:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UKKDFT009663;
	Fri, 30 May 2008 13:20:13 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83322>



On Fri, 30 May 2008, Petr Baudis wrote:
> > 
> > Why would you want to use "git-rev-list" at all?
> 
> Because it was the natural command to access history from a script to me
> and nothing in the documentation hinted me that I shouldn't use it.

So use it. Or not.

Just don't think it's the same as "git log".

> Step back a bit: it's git-_REV_-list. Technically, --all --objects is
> nonsensical operation to do on revision list either.

Who cares?

Why are you arguing against *facts*?

The *fact* is, git rev-list can traverse the whole object chain.

The *fact* is that git rev-list can do other operations that have nothing 
to do with logs (bisection, for example).

The *fact* is that both git rev-list and git log can traverse a set of 
revisions, but that doesn't make them the same command.

I totally don't see your arguments. They are pointless. git rev-list and 
git log already share all the relevant internal machinery for the things 
where they overlap in capabilities. And the fact that they output 
different things is because they are different.

			Linus
