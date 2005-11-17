From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Thu, 17 Nov 2005 22:47:20 +0100
Message-ID: <cda58cb80511171347yef4f090g@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
	 <cda58cb80511170236p4a7e2baay@mail.gmail.com>
	 <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 22:50:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrbI-00023p-4q
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVKQVrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVKQVrV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:47:21 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:50071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751365AbVKQVrV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:47:21 -0500
Received: by zproxy.gmail.com with SMTP id 40so34643nzk
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 13:47:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gIsP8g3KCwNn6gGLwIt7bKBrVM7+kWzcAvx2h/xcRoWZMVqhOv8636LIQSB/DqzD8HIci6dlbPzuWEGL1uq3zsYqe8lMjBopOH67W1pF8RO3tTId3bDCaJLI0sxK2PymlcX/QN5oC7lqu3L3j6yswr3dtmerx4wJBKHcZFriots=
Received: by 10.36.100.4 with SMTP id x4mr5437097nzb;
        Thu, 17 Nov 2005 13:47:20 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Thu, 17 Nov 2005 13:47:20 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12158>

2005/11/17, Linus Torvalds <torvalds@osdl.org>:
>
> What you probably _can_ do is to find whatever top-most commit you want
> (say, the v2.6.0 commit), and use grafting to make that have no parents.
> Then you can do git-prune to get rid of everything under it.
>

ok that's what I was trying to do by killing the parent object.  Now
when looking a the graph using gitk all old objects have been removed.
But I'm suprised because the git repository is the same size as it was
before pruning all old objects. Can you explain why ?

Thanks
--
               Franck
