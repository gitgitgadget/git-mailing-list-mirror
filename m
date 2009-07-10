From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Fri, 10 Jul 2009 16:58:25 +0200
Message-ID: <4A575711.1050007@drmicha.warpmail.net>
References: <h37fga$5ie$1@ger.gmane.org> <4A575416.2090304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Graeme Geldenhuys <graemeg@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jul 10 16:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPHYp-0001tg-96
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 16:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbZGJO6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbZGJO6o
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 10:58:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44997 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809AbZGJO6n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 10:58:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 181F43B0402;
	Fri, 10 Jul 2009 10:58:43 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 10 Jul 2009 10:58:42 -0400
X-Sasl-enc: Lguv5rwrxWwdFnN9yxrWmMQ2J9+1u0cXLtMxX9x/1esQ 1247237922
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 64DF813217;
	Fri, 10 Jul 2009 10:58:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A575416.2090304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123055>

Michael J Gruber venit, vidit, dixit 10.07.2009 16:45:
...
> I think what you really want is to push everything under remote
> (assuming there are only svn branches) into proper heads on github, i.e.
> a refspec like '+refs/remotes/*:refs/*' for your pushes.

Uhm, make that '+refs/remotes/*:refs/heads/*' ;)
