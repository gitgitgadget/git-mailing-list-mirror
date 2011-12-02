From: Stephen Bash <bash@genarts.com>
Subject: Re: Workflow Recommendation - Probably your 1000th
Date: Fri, 02 Dec 2011 10:14:36 -0500 (EST)
Message-ID: <aedcd0aa-d5b9-4fc6-a5e7-6039945287c4@mail>
References: <CAEbKVFQLvyTq+VL9DJZtp4YZLUgeR56N9u5RrsGqEB=e81O3zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bradford <fingermark@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 16:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWUp4-0006pB-OB
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 16:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab1LBPOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 10:14:41 -0500
Received: from hq.genarts.com ([173.9.65.1]:42296 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753969Ab1LBPOl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 10:14:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C9A17BE82F8;
	Fri,  2 Dec 2011 10:14:42 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u9vfRYOAqEpV; Fri,  2 Dec 2011 10:14:36 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A25A6BE82FB;
	Fri,  2 Dec 2011 10:14:36 -0500 (EST)
In-Reply-To: <CAEbKVFQLvyTq+VL9DJZtp4YZLUgeR56N9u5RrsGqEB=e81O3zQ@mail.gmail.com>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC15 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186221>

----- Original Message -----
> From: "bradford" <fingermark@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: git@vger.kernel.org
> Sent: Thursday, December 1, 2011 3:46:52 PM
> Subject: Re: Workflow Recommendation - Probably your 1000th
> 
> Thanks, Stephen.   I guess I'm looking for more input on the
> advantages and disadvantages of using a QA and production branch vs
> just doing everything out of master.
> 
> Trying to go through the following:
> http://news.ycombinator.com/item?id=1617425
> scottchacon.com/2011/08/31/github-flow.html
> 
> We have some weeks where we release very frequently and some weeks
> where we release only once a week and have to do production fixes in
> the meantime.  Sure other people have similar experiences.

Before continuing I guess two key assumptions factor into our workflow:
 1) we still work in a traditional major/minor release cycle with potentially weeks or even months between releases
 2) our customers can be running almost any historical version of our software

>From that perspective having a maintenance branch for each major revision of our software gives us a holding area where devs can fix bugs at any time without necessarily going through the entire tag/release/merge process (you can envision a "hot fix branch" that is long-lived).  For example, we often have documentation fixes that will sit on the maintenance branch until a software fix needs to go out.  But other non-critical fixes also end up waiting on something that really requires a maintenance release (or enough fixes pile up and necessitate a release themselves).

HTH,
Stephen
