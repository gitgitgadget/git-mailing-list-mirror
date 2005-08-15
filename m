From: Wolfgang Denk <wd@denx.de>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 22:22:47 +0200
Message-ID: <20050815202247.62E00352633@atlas.denx.de>
References: <46a038f90508151309269ffc04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 22:24:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4lUG-00075c-4O
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 22:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVHOUXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 16:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHOUXG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 16:23:06 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:7657 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964943AbVHOUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 16:23:05 -0400
Received: from fwd22.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1E4lU0-0006pv-01; Mon, 15 Aug 2005 22:22:56 +0200
Received: from denx.de (SUiYNsZvZeOradpibZBhvUXFpM-5yNrPpcr-KLZ0hhA-lx-OT8X30Q@[84.150.74.59]) by fwd22.sul.t-online.de
	with esmtp id 1E4lTt-1v4j440; Mon, 15 Aug 2005 22:22:49 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 9B7FD42E15; Mon, 15 Aug 2005 22:22:47 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 62E00352633;
	Mon, 15 Aug 2005 22:22:47 +0200 (MEST)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-reply-to: Your message of "Tue, 16 Aug 2005 08:09:02 +1200."
             <46a038f90508151309269ffc04@mail.gmail.com> 
X-ID: SUiYNsZvZeOradpibZBhvUXFpM-5yNrPpcr-KLZ0hhA-lx-OT8X30Q@t-dialin.net
X-TOI-MSGID: bd0a9d90-f955-4174-b526-fbc12a971948
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <46a038f90508151309269ffc04@mail.gmail.com> you wrote:
>
> If I find the time, I'll add some sort of pattern-match parameters to
> be tried against the commitmsg to extract likely head/branch names
> where we are merging from. My problem right now is that the only cvs
> repo with interesting branches and merges I have is huge, and takes an
> hour to import. That puts a damper on things, unfortunately.

In a first step, and to try things out, it might be sufficient if one
could feed in this information manually, like by providing a list  of
PatchSet ID's which are known to be merges ?

At least in my case where the number of branches and merges is  small
this would be completely satisfactory.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is mind?  No matter.  What is matter?  Never mind.
                                      -- Thomas Hewitt Key, 1799-1875
