From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 17:56:35 +0100
Message-ID: <496F6AC3.7050704@drmicha.warpmail.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net> <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de> <496F4BF0.6020805@drmicha.warpmail.net> <alpine.DEB.1.00.0901151658060.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVXd-0007xg-Pf
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbZAOQ4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbZAOQ4i
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:56:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35345 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753809AbZAOQ4h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 11:56:37 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B8FA32158DC;
	Thu, 15 Jan 2009 11:56:35 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 15 Jan 2009 11:56:35 -0500
X-Sasl-enc: MemKMwW+ULU+PGWxR3ewpYq8185TF0jgmO/H8bhzVlsW 1232038595
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4D3114A36;
	Thu, 15 Jan 2009 11:56:34 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.DEB.1.00.0901151658060.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105854>

Johannes Schindelin venit, vidit, dixit 15.01.2009 17:04:
...
>>> The more I think about it, I think it's possible I broke it with the 
>>> introduction of the "noop".
>> It certainly worked after the noop introduction before the r-i-p series, 
>> but not any more after.
> 
> Umm... which rebase -i -p series do you mean?  "noop" was introduced 
> pretty recently if my Alzheimered brain does not fool me.

This one introduced noop:

commit ff74126c03a8dfd04e7533573a5c420f2a7112ac
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Fri Oct 10 13:42:12 2008 +0200

    rebase -i: do not fail when there is no commit to cherry-pick

This is the bad one from bisect:

commit d80d6bc146232d81f1bb4bc58e5d89263fd228d4
Author: Stephen Haberman <stephen@exigencecorp.com>
Date:   Wed Oct 15 02:44:39 2008 -0500

    rebase-i-p: do not include non-first-parent commits touching UPSTREAM

It's the last one in a longer series. And that series is after the noop
introduction.

Michael
