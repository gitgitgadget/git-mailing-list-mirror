From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 11:40:29 +0200
Message-ID: <m3vf6frvxu.fsf@defiant.localdomain>
References: <200504211113.13630.mason@suse.com>
	<Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
	<m3u0m0q69a.fsf@defiant.localdomain>
	<Pine.LNX.4.58.0504211301240.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 11:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOuaG-0005Eb-9A
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 11:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVDVJki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 05:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVDVJki
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 05:40:38 -0400
Received: from khc.piap.pl ([195.187.100.11]:16900 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261981AbVDVJkc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 05:40:32 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id DDE591082A; Fri, 22 Apr 2005 11:40:29 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504211301240.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 21 Apr 2005 13:07:25 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> And dammit, if I'm the original author and likely biggest power-user, and 
> _I_ can't be bothered to use special filesystems, then who can? Nobody.

If someone is motivated enough, and if the task is quite trivial (as it
seems to be) someone may try it. I can see nothing wrong with it as long
as it doesn't affect other people.

> This is why I absolutely do not believe in arguments like "if your
> filesystem doesn't do tail packing, you shouldn't use it" or "if your
> don't have name hashing enabled in your filesystem it's broken".

Of course. But one may consider using a filesystem with, say, different
settings. Or a special filesystem for this task, such as CNFS used by
news servers (it seems news servers do quite the same what git does,
except they also purge old contents, i.e., container files don't grow up).

> I'm perfectly willing to optimize for the common case, but that's as far 
> as it goes. I do not want to make fundamental design decisions that depend 
> on the target filesystem having some particular feature.

The optimization would be (in) the underlying filesystem (i.e., the OS
thing, or possibly a shared preloaded library?), not git itself.
-- 
Krzysztof Halasa
