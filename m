From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git pull merges current branch even when <dst> is specified
Date: Thu, 25 Jun 2009 10:52:24 +0200
Message-ID: <4A433AC8.4040702@drmicha.warpmail.net>
References: <1245862052581-3149948.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tom Lambda <tom.lambda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 10:53:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJkhg-0001eN-Uo
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 10:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbZFYIw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 04:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbZFYIw4
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 04:52:56 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58964 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486AbZFYIwz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 04:52:55 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1F55637F13E;
	Thu, 25 Jun 2009 04:52:58 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 25 Jun 2009 04:52:58 -0400
X-Sasl-enc: n5xscL5VJju6d3QaCgHKp7PDNiz4kAeMJ+BKTaHo93GS 1245919977
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7DA5637B28;
	Thu, 25 Jun 2009 04:52:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090625 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1245862052581-3149948.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122185>

Tom Lambda venit, vidit, dixit 24.06.2009 18:47:
> 
> If I am in 'master' and 'bugfix' is a remote branch in 'repo' which I do not
> have locally yet, running:
> 
> git pull repo bugfix:bugfix
> 
> creates a new local branch 'bugfix' equals to 'repo/bugfix' as expected.
> However, it also merges 'bugfix' into 'master', that surprises me since I
> explicitly specify that <dst> is 'bugfix'.
> 
> I know that I can get what I want by running:
> 
> git fetch repo bugfix:bugfix
> 
> But the git-pull behavior looks odd to me. I thought that <dst> was the
> current branch by default and it could be overridden by specifying it in the
> command line.

Well, the first line of git-pull's man page says:

Runs git-fetch with the given parameters, and calls git-merge to merge
the retrieved head(s) into the current branch.

So I can't help but call your surprise somewhat unjustified ;)

Michael
