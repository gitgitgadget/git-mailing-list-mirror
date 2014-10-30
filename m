From: Eric Wong <normalperson@yhbt.net>
Subject: Re: differences between old clone and new  Re: git-svn performance
Date: Thu, 30 Oct 2014 23:08:31 +0000
Message-ID: <20141030230831.GA14160@dcvr.yhbt.net>
References: <20141030002136.GA31920@dcvr.yhbt.net>
 <1414630550.65737.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 00:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjypZ-0000Qy-QK
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 00:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbaJ3XId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 19:08:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39252 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161332AbaJ3XId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 19:08:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 2D0071F7C9;
	Thu, 30 Oct 2014 23:08:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414630550.65737.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> That's quite straight-forward, I think  - except for the recent burst (I am essentially
> adapting the git 2.1.0 release shipped by the upcoming fedora 21 scheduled for christmas)
> I tend to update to the latest fedora release about a week or two after release;
> fedora 17 was shipped in May 2012 and only just enter Alpha in 22 Feb 2012.
> and I tracked R at least as frequently as weekly around then;
> So I would be using what ever version of git was shipping with fedora 16 around late
> Feb 2012.
> 
> On fedora's build farm, git-1.7.7.5 was bult in dec 2011 and git-1.7.7.6 was built
> on 2012-01-19 . Depending on how soon
> 1.7.7.6 filtered down to update, and when I update my git and also tracked R,
> (all three of these events probably happened around 22 Feb), I could be
> using either 1.7.7.5 or 1.7.7.6. I still have the system software update log around
> (the repo was cloned on a now-dead system, then moved over when it died),
> and presumably I can get git log to show me the fetch date (?), I might
> be able to tell whether it is 17.7.5 or 1.7.7.6 if you really want to know.

I tried a full clone on 1.7.7.6 (no git-svn difference from 1.7.7.5).
Even with that old git, I was able to reproduce the same merge behavior
as current (Junio's) master as well as our recent patches.

So I believe r58454, r46925, and r46906 in the R repo are all handled
correctly and no mergeinfo-handling regressions are introduced in the
latest round of git-svn changes.  Thanks.
