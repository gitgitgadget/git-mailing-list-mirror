From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 12:24:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
 <85abswo9gf.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJ3g-0002jF-BQ
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936363AbXHLTZB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936127AbXHLTZB
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:25:01 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46417 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935941AbXHLTZA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:25:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJOuAU004983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 12:24:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJOmIk018257;
	Sun, 12 Aug 2007 12:24:51 -0700
In-Reply-To: <85abswo9gf.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.743 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55705>



On Sun, 12 Aug 2007, David Kastrup wrote:
>
> > But to visualize a history, it's useless.
> 
> Not half as useless as existing git-specific tools.  They thrash my
> computer to death on serious sized trees.

So, use "git log --pretty=oneline" instead, which doesn't have the 
expense.

I don't see why you think that using nntp would help anything. The 
_problem_ is still the same one, of calculating full reachability. It 
didn't go away just because you changed to another intermediate protocol.

Yes, you could perhaps use the nntp caching, but I don't know if you've 
noticed: the reason news servers tend to expire old messages is that a 
news reader and the NNTP protocol won't be able to handle huge histories 
either.

And if you just want the "expire" feature, then you might as well just 
make git date-limit things for you, ie "gitk --since=last.week"

			Linus
