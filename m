From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for author-oriented git-rev-list switches [rev 9]
Date: Fri, 10 Jun 2005 09:10:42 +1000
Message-ID: <2cfc4032050609161059a0f0c@mail.gmail.com>
References: <20050609090141.21555.qmail@blackcubes.dyndns.org>
	 <2cfc403205060902373e5c284f@mail.gmail.com>
	 <2cfc4032050609085341e46242@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 01:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgW75-0006K6-9B
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 01:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVFIXKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVFIXKv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 19:10:51 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:9945 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262197AbVFIXKo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 19:10:44 -0400
Received: by rproxy.gmail.com with SMTP id i8so39433rne
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 16:10:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOqdWw+05Ggl8jn8B/ZC/YL5DA7NktQPOnifADzJFP027VbogmnFhNh+ki/NmeRTC+wsz5dPt45HGsT2iDYd/fzCTlpYSaZfHajbI6u6bHIUGIqLvh3/WT4O1j2SIhXwL/Da36yUX2Jb3rcvhqQophkIo5k/3LkfS71ZOdeNTm8=
Received: by 10.38.78.79 with SMTP id a79mr555555rnb;
        Thu, 09 Jun 2005 16:10:42 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 9 Jun 2005 16:10:42 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <2cfc4032050609085341e46242@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[rev 9]   

* oops, missed some whitespace in my commit.c edits - begone,
whitespace, begone!
* slight change to semantics of --prune-at-author - now includes the
author's own commits
but prunes the parents of the author's own changes. This helps put the
cut points into some kind of context when the author has contributions
in multiple branches.

As before available from:
http://blackcubes.dyndns.org/epoch/wrt-patch-latest.patch

If anyone has objections to the changed semantics, let's discuss.

jon.
