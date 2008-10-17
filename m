From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Excluding files from git-diff
Date: Fri, 17 Oct 2008 17:18:26 +0200
Message-ID: <48F8ACC2.1010903@drmicha.warpmail.net>
References: <20081017145313.GA23471@eriks>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Hahn <erik_hahn@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 17 17:20:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqr7G-0007l3-Gc
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 17:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbYJQPSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 11:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbYJQPSc
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 11:18:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41579 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756036AbYJQPS3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 11:18:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 153D3181283;
	Fri, 17 Oct 2008 11:18:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Oct 2008 11:18:29 -0400
X-Sasl-enc: 7tw33k1Ag+21lWYxIDFvOcIVoDxdmZTD60MdPWa7IdTr 1224256708
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91DD6207E2;
	Fri, 17 Oct 2008 11:18:28 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <20081017145313.GA23471@eriks>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98484>

Erik Hahn venit, vidit, dixit 17.10.2008 16:53:
> I'm currently working on a script whose developer does not use
> git. Hence, when I mail him the patch, I don't want to include the
> .gitignore file. Is it possible to exclude a file from git-diff (except
> not adding it to git, of course?)

Am I right in assuming that by "script" you mean a manuscript consisting
of several files, rather than a single script (programme in scripting
language)? In any case:

git diff commit1 commit2 file

gives you the diff for "file" between those commits, so if you're really
interested in one file that's the way to go; you can also specify more
than one file here.

On the other hand, your .gitignore probably doesn't change that often,
so that it shouldn't show up in the diff after that anyways. Or put it
in .git/info/excludes.

Cheers,
Michael
