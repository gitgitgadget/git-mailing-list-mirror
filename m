From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-svnimport
Date: Sat, 4 Feb 2006 16:16:22 +1300
Message-ID: <46a038f90602031916x6cfb9e6bg7dfa0fb1cc237dac@mail.gmail.com>
References: <200602031429.07894.jharrison@linuxbs.org>
	 <16255.1139021263@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jason Harrison <jharrison@linuxbs.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 04:16:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5DuU-0008Tg-MM
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 04:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946291AbWBDDQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 22:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946294AbWBDDQY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 22:16:24 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:60724 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946291AbWBDDQY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 22:16:24 -0500
Received: by wproxy.gmail.com with SMTP id i34so712357wra
        for <git@vger.kernel.org>; Fri, 03 Feb 2006 19:16:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tmx083iUIR7HC5VSd1qcB5L6EZH2SHke80B6YOEQqWTQhXJUTWdJWT1TVbYiUHW+2dtv21rYlVrVOVUO7uIKkd6+05bZqZv9t/2IDKjVWauh4v9hskD4xxsahCAiRRP1yH9y7SzjjoR7x0fX6VKvHtmcEwcsQdeJ3lQU8/cqCyg=
Received: by 10.54.76.1 with SMTP id y1mr1228196wra;
        Fri, 03 Feb 2006 19:15:58 -0800 (PST)
Received: by 10.54.71.7 with HTTP; Fri, 3 Feb 2006 19:16:22 -0800 (PST)
To: Jason Riedy <ejr@eecs.berkeley.edu>
In-Reply-To: <16255.1139021263@lotus.CS.Berkeley.EDU>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15568>

On 2/4/06, Jason Riedy <ejr@eecs.berkeley.edu> wrote:
> Looking through the git-svnimport source makes it appear
> difficult to just snarf just one directory (maybe /) out
> of a svn repository.  Actually, it makes everything svn-
> related appear difficult.  Why should I worry about
> memory management by default in Perl?!?

I think that the SVN internals are so yucky that we're lucky to get
away with "just" that bit of memory-handling crud.

>  It'd be nice if
> there were an git-svnimport-trivial that just snarfed a
> single URL without tags or branches.

We're definitely needing some updates to the doco for svnimport to
make it easier. Maybe some examples of real life scenarios with
different repo layouts

> I have to deal with a few repos with bizarre directory
> structures...

looks like you're the man for the job ;-)

cheers,


martin
