From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 11:38:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 20:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKILH-0007wP-UL
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765962AbXHLSjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbXHLSjH
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:39:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48201 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763162AbXHLSjG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 14:39:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CIcxam002764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 11:39:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CIcsWW016710;
	Sun, 12 Aug 2007 11:38:54 -0700
In-Reply-To: <85ir7kq42k.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.744 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55697>



On Sun, 12 Aug 2007, David Kastrup wrote:
>
> And then it struck me: Emacs has a very efficient browser for linked
> one-line information that can be expanded into complete changesets
> with diffs inside.  It is called "Gnus".  A newsreader.

A newsreader is mis-designed for all the same reasons SVN is misdesigned: 
it sees the messages (commits) as a _tree_.

Anybody who sees development as a tree is totally bogus by definition. It 
sees things forking off, but it doesn't see them merging. That's a 
fundamnetal and unfixable design bug.

Of course, for news, that's ok (it might be *nice* if you could reply to 
two messages and see it as a merge, but that's not how things work), so 
it wasn't a design mistake for _that_.

But to visualize a history, it's useless. Merges are as important as forks 
(arguably *more* important). "Forgetting" about merges is bad.

			Linus
