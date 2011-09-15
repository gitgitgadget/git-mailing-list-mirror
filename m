From: Stephen Bash <bash@genarts.com>
Subject: Re: vcs-svn and friends
Date: Thu, 15 Sep 2011 17:13:52 -0400 (EDT)
Message-ID: <3435337.18574.1316121232672.JavaMail.root@mail.hq.genarts.com>
References: <20110915204815.GA31508@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Michael Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 23:14:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JG1-0007Id-Hi
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935003Ab1IOVOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:14:00 -0400
Received: from hq.genarts.com ([173.9.65.1]:63237 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934775Ab1IOVN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:13:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A0EF015C8002;
	Thu, 15 Sep 2011 17:13:58 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44cqjCVgKOr8; Thu, 15 Sep 2011 17:13:52 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id B5A6315C8001;
	Thu, 15 Sep 2011 17:13:52 -0400 (EDT)
In-Reply-To: <20110915204815.GA31508@elie>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181506>

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> Sent: Thursday, September 15, 2011 4:48:15 PM
> Subject: Re: vcs-svn and friends
>
> Stephen Bash wrote:
> 
> > For those of us interested but out of the loop, does this mean you
> > have a working example where I can point it at a SVN repo and see
> > what happens? Having done our SVN to Git conversion last year, I
> > know our repo has a lot of the common SVN screw cases (non-branching
> > copies, partial merges, mis-merges, *lots* of retagging, changes
> > committed to tags, etc.) so if it's relatively easy to setup a test
> > I'm happy to run one.
> 
> Thanks. It's very bare-bones at the moment: it just imports each
> revision as a whole tree, with no branch and merge tracking at all.
> So it would be very interesting to get this basic stuff out into the
> wild and then add some code implementing those things for you to break
> on top of it.

Okay, that matches my last known state of the project, guess I just got optimistic ;)  

Since last summer I've been meaning to take a crack at svn-filter-root.py, but it keeps sliding off the priority list.  If you guys don't beat me to it, maybe I'll eventually get around to it...

Thanks,
Stephen
