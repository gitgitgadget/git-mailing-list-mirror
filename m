From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 13:07:16 -0500
Message-ID: <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	 <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	 <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 19:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnJzH-0002HK-DB
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 19:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVLPSHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 13:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVLPSHT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 13:07:19 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:32212 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbVLPSHR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 13:07:17 -0500
Received: by zproxy.gmail.com with SMTP id 14so1416449nzn
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 10:07:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b5dLj9q+w+CB9mCqciTLMxV+YEGbJgSstWJAf6xMYKFhero0n3yIwu/4Ufo2wX8SwkY39WdQAPd2To5pkyQVvFZklNBijiNjwxCKDaywZCUu5vWmPT0wJuXoGXvYfbo3sNLberzxgecoM56xGCQQCgPccd49BkeyxoGQ69ocUZs=
Received: by 10.36.31.4 with SMTP id e4mr31457nze;
        Fri, 16 Dec 2005 10:07:16 -0800 (PST)
Received: by 10.36.88.14 with HTTP; Fri, 16 Dec 2005 10:07:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13743>

> While I am sympathetic, this "Oops, I said pull when I meant
> fetch" sounds remotely similar to "oops, I said 'rm -r' when I
> meant to say 'ls -r'".  Is it that the tool is too fragile?

Didn't bk come with some kind of (one-level) undo pull?  It should not
be too hard to create something similar considering that one could
just leave new objects in the db orphaned.

M.
