X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 01:40:59 +0000 (UTC)
Message-ID: <ejgfjb$bm7$2@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<200611151858.51833.andyparkins@gmail.com>
	<Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 16 Nov 2006 01:45:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 35
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-175-230.dynamic.dsl.as9105.com
User-Agent: pan 0.117 (We'll fly and we'll fall and we'll burn)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31539>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkWIh-00076w-7h for gcvg-git@gmane.org; Thu, 16 Nov
 2006 02:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031046AbWKPBoC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 20:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031050AbWKPBoB
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 20:44:01 -0500
Received: from main.gmane.org ([80.91.229.2]:56805 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031046AbWKPBoA (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 20:44:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkWGd-0006fy-AY for git@vger.kernel.org; Thu, 16 Nov 2006 02:42:16 +0100
Received: from 88-110-175-230.dynamic.dsl.as9105.com ([88.110.175.230]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 02:42:15 +0100
Received: from wildfire by 88-110-175-230.dynamic.dsl.as9105.com with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16
 Nov 2006 02:42:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 11:18:36 -0800, Linus Torvalds wrote:

> On Wed, 15 Nov 2006, Andy Parkins wrote:
>>
>> On the one hand you're arguing that git syntax is easy to learn, and on the 
>> other that no one will be able to learn a new syntax just as easily.
> 
> I'm saying that people who are new to git will _have_ to learn new 
> concepts ANYWAY.
> 
> I don't think the naming is the hard part. 

It isn't - the unexpectedness of what happens is.

I've started by teaching how to do stuff locally, then "pushing" it out to
others (me).  All the while being able to point out how this is either all
local, or sends stuff (without any local modifications) to others.

Come up to 'pull' and ere you have to point out that not only will you get
the remote changes but they are also merged into your repository. On the
wrong branch?

Too bad.

The problem with git-pull behaving illogically drove me to look at cogito
(an aside, perhaps cg-throw should be the corrollary to cg-fetch?)
instead. Alas it has problems with a cogito branch not being something you
can mentally map back to a git branch.

> But I bet people don't teach it that way. They _start_ by teaching "pull". 
> Right?

Nope.

Anand
