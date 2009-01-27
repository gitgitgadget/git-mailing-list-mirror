From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: connecting existing local git repository to svn
Date: Tue, 27 Jan 2009 11:35:50 +0100
Message-ID: <497EE386.5050805@drmicha.warpmail.net>
References: <497E8927.1060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 11:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRlK4-0002c6-TZ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 11:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZA0Kfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 05:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZA0Kfy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 05:35:54 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39364 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951AbZA0Kfx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 05:35:53 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.fastmail.fm (Postfix) with ESMTP id A8FDA25C045;
	Tue, 27 Jan 2009 05:35:51 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 27 Jan 2009 05:35:51 -0500
X-Sasl-enc: D0+7tcRKBjzcEGrEUCYWL5NI88fwq/FzAL30kZA9fGSb 1233052551
Received: from [139.174.44.153] (sobolev.math.tu-clausthal.de [139.174.44.153])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3C782B2FB;
	Tue, 27 Jan 2009 05:35:50 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <497E8927.1060506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107330>

Ittay Dror venit, vidit, dixit 01/27/09 05:10:
> Hi,
> 
> 
> I'd like to create a branch in a subversion repository so that I can
> work with git-svn on it.
> 
> 
> My git repository is already with a history, that I don't want to
> replicate to subversion, I want to start with subversion having just the
> latest revision and then continue from there normally (git svn
> dcommit/rebase).
> 
> 
> How can I do that?

Create the svn branch (with svn) and "git svn clone". Pull in your git
branch under a new name (if that is what you want).
Now, you can e.g. "git merge -s theirs" your other git branch into
master, git svn rebase and dcommit. Untested, but comes with best wishes ;)

Do you want to discard your existing git history completely?

Cheers,
Michael
