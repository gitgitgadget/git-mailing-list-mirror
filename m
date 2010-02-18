From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git svn fetches entire trunk on tags (change from 1.6.5.2 to
	1.7.0)
Date: Wed, 17 Feb 2010 16:06:20 -0800
Message-ID: <20100218000620.GA7123@dcvr.yhbt.net>
References: <5CFEDDA0-6C6B-43DF-8BB4-E303E91C24EF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Andrew Myrick <amyrick@apple.com>, Sam Vilain <sam@vilain.net>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 01:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhtuV-0005yD-BI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 01:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab0BRAGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 19:06:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50206 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757960Ab0BRAGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 19:06:21 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82411F4FA;
	Thu, 18 Feb 2010 00:06:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5CFEDDA0-6C6B-43DF-8BB4-E303E91C24EF@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140274>

Robert Zeh <robert.allan.zeh@gmail.com> wrote:
> On Feb 17, 2010, at 5:23 PM, Eric Wong <normalperson@yhbt.net> wrote:
>> There was a rather large amount of changes between 1.6.5.2 so some
>> regressions could've slipped in.  A bisection would definitely help
>> us track down the cause.
>
> I will attempt a bisection Thursday.

Awesome, thanks.

>> Does the repository you're using svn:mergeinfo use by any chance?
>
> The repository does use mergeinfo, but    much later in the revision  
> history then when the problem shows up.
>
> Do you have any advice on how to write a test for this behaviour, since 
> the problem is not apparent from looking at the repo?  I do not like the 
> idea of a test looking at a log but that is all I can think of right now.

Andrew and Sam are the people to ask about mergeinfo, but I've found
reading logs valuable for tracking down many issues in the past.

I'm not 100% convinced mergeinfo itself is the problem (but it's the
code I'm least familiar with), and there were also some changes with
globbing (which I believe were harmless improvements).

-- 
Eric Wong
