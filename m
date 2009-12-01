From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Transplant branch from another repository
Date: Tue, 01 Dec 2009 17:07:35 +0100
Message-ID: <4B153F47.5040504@drmicha.warpmail.net>
References: <5195c8760912010301r63d5e27axf53c17db799a798f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVHy-0008Bi-VI
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbZLAQJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZLAQJH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:09:07 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:45124 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135AbZLAQJF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 11:09:05 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6AD85C538E;
	Tue,  1 Dec 2009 11:08:54 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 01 Dec 2009 11:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OYWJmGp80LqAAnXU3extjf/QUVY=; b=pOYRjw/348cNtCj662wWJFcfBRwB/NO3rTtYGuDQ94S3kddyj3j041xEal9VY922m0joRbBeF85+kDN4Gry0Wd1OVgt+qP5DtZ2Sr++N9hUZLNciw5V88v9DlM0VSUIJs8Z93FkjBFJLeWmY7FQJKWho7XnbmBTBaVcFFSFwMk0=
X-Sasl-enc: KAsgJ2kkllZlGrSGsmWV5jpLKR9YQmbJlDEQaNzmSqUq 1259683728
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5C6C81ACD9;
	Tue,  1 Dec 2009 11:08:48 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <5195c8760912010301r63d5e27axf53c17db799a798f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134217>

Jeenu V venit, vidit, dixit 01.12.2009 12:01:
> Hi,
> 
> Say, I have two repositories A and B (local, independent, but similar
> - they are for content tracking and not collaboration purposes). A has
> a branch 'a', which I want to have in B. What I mean is that I'd like
> to have the sequence of changes in the branch 'a' to be present in B,
> thus creating an independent branch 'b' in B.
> 
> Is there any way to achieve this? One thing that I could think of is
> to use 'format-patch' to generate the list of patch files from A. But
> I don't see how to convert those patches to a sequence of commits in
> repo B. I could do a 'git apply patches/*' but then all patches
> collapse to one single commit. If format-patch is a/the way, could
> somebody tell me how to get this done? Or are there any alternatives?
> 
> FWIW: I'm running Git under Cygwin, and sendmail isn't configured.

>From within your B repo:

git fetch pathtoA a:b

Cheers,
Michael
