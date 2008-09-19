From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Branches with git-svn
Date: Fri, 19 Sep 2008 14:35:07 +0200
Message-ID: <48D39C7B.9020709@drmicha.warpmail.net>
References: <1221819302.6784.4.camel@zdra-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Xavier Claessens <xclaesse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 14:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgfDq-0002h8-ND
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 14:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbYISMfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYISMfN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 08:35:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33857 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880AbYISMfM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 08:35:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D7B37165F3B;
	Fri, 19 Sep 2008 08:35:10 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 19 Sep 2008 08:35:10 -0400
X-Sasl-enc: k4KdkpAW+pLJfRSnxhVAsJd/eDZw3JF2npKHobNRufQu 1221827710
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2199719A72;
	Fri, 19 Sep 2008 08:35:10 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <1221819302.6784.4.camel@zdra-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96279>

Xavier Claessens venit, vidit, dixit 19.09.2008 12:15:
> Hi,
> 
> I created a git repository using "git-svn clone <url>" a long time ago.
> But now I realise that I don't get SVN branches into my git repository.
> I see that the doc tells to use "git clone -t tags -b branches -T trunk
> <url>" to create the repository. If I create a new repository with that
> command, I get branches and tags.
> 
> However I have lots of contributors having branches based on my git
> repository. Is there a way to add SVN branch to my existing git repo?

If you haven't use those options back then, then what was the svn repo
structure - no trunk, just main?
Did you change the structure now?

If you git-svn fetch from that new structure then all your new branches
etc. will show up as subdirectories, which is most certainly not what
you want.

So, what was the structure in svn like before, and have your
contributors based their branches on the mis-imported new structure already?

Michael
