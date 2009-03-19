From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Advice wanted to set up GIT repository manually sync'ed form
 SVN
Date: Thu, 19 Mar 2009 11:16:49 +0100
Message-ID: <49C21B91.40304@drmicha.warpmail.net>
References: <79BA5EFC11BE4E06A78D39D06D1549AF@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFKv-0005GF-68
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbZCSKRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZCSKRI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:17:08 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59964 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752361AbZCSKRF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 06:17:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B6F512F496E;
	Thu, 19 Mar 2009 06:17:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 06:17:03 -0400
X-Sasl-enc: uDExqUMcG4xdu12F7OWfR/6H05VP9prh8zeumzQsF+AI 1237457823
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29C1145FDA;
	Thu, 19 Mar 2009 06:17:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <79BA5EFC11BE4E06A78D39D06D1549AF@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113745>

Aaron Gray venit, vidit, dixit 18.03.2009 21:46:
> Hi,
> 
> I am a realitive GIT newbie, ie I have not used GIT on a project but have 
> read quite a lot of documentation on it, over the last year or so.
> 
> We are wanting to have a git and git-web repository that is synced to a main 
> SVN repository, wh only want to read the SVN repository at this stage. I am 
> planning on using git-svn raw, and do fetch'es by hand.
> 
> Is there any advice that I should know at this point before proceeding ?

Read-only access should be mostly pain-free, unless the structure of the
svn repo is unfriendly. If it exists already and is large I'd suggest to
do a few test conversions with limited revision range first, adjust the
config, optionally set up an author map and then go live.

Michael
