From: Wolfgang Denk <wd@denx.de>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 10:09:31 +0200
Message-ID: <20050815080931.64F0D352633@atlas.denx.de>
References: <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 10:26:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4aIN-0000We-6P
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVHOI0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVHOI0I
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:26:08 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:19413 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932106AbVHOI0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 04:26:07 -0400
Received: from fwd23.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1E4a2S-0006dK-00; Mon, 15 Aug 2005 10:09:44 +0200
Received: from denx.de (r9B54wZOZe2TWNHXSaCyvqIB1PIQ7EXo9C7YPXAOukyIq6K4dvkeYu@[84.150.74.59]) by fwd23.sul.t-online.de
	with esmtp id 1E4a2H-09C2Ns0; Mon, 15 Aug 2005 10:09:33 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id D0D83422F3; Mon, 15 Aug 2005 10:09:31 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 64F0D352633;
	Mon, 15 Aug 2005 10:09:31 +0200 (MEST)
To: Linus Torvalds <torvalds@osdl.org>
In-reply-to: Your message of "Sun, 14 Aug 2005 17:46:30 PDT."
             <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> 
X-ID: r9B54wZOZe2TWNHXSaCyvqIB1PIQ7EXo9C7YPXAOukyIq6K4dvkeYu@t-dialin.net
X-TOI-MSGID: c4479e1f-ba44-4312-b1da-fd671806be39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> you wrote:
> 
> One thing that "git cvsimport" does not know to do is to show when a
> branch was merged back into the HEAD. That would be a very interesting
> thing to see, but I don't think there's any way to get that information
> out of CVS (so you'd have to basically make an educated guess by looking
> at the changes).
> 
> So in a cvsimport, you'll never see a merge back to the head, even if one 
> technically took place. 

I asked this question before without receiving any reply:

Assume I know exactly where the merge back happenend - is  there  any
way to tell git about it, so I don't see all these dangling heads any
more?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The number  of  Unix  installations  has  grown  to  10,  with  more
expected."    - The Unix Programmer's Manual, 2nd Edition, June, 1972
