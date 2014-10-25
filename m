From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Sat, 25 Oct 2014 00:02:22 +0000
Message-ID: <20141025000222.GB18655@dcvr.yhbt.net>
References: <1413999510.36832.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:02:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhooM-0000z9-UA
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 02:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbaJYACX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 20:02:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36573 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757AbaJYACW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 20:02:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F81E1FB0B;
	Sat, 25 Oct 2014 00:02:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1413999510.36832.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> Comparing trunk of old and new, I see one difference -  One short
> commit message is missing in the *old* (the "Add checkPoFiles etc." part)
> and so all the sha1 afterwards differed. Is that an old bug that's fixed
> and therefore I should throw away the old clone? 

I don't recall a bug which would cause a revision to be skipped.
I suppose it's alright now the new clone has that revision.
Perhaps there was a power outage or improper shutdown?

At least we can be glad current versions see this revision...
