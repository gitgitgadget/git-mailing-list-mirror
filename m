From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 11:02:27 +0200
Message-ID: <4BF10623.5000705@drmicha.warpmail.net>
References: <1274051912050-5063068.post@n2.nabble.com> <4BF0F63A.1080005@drmicha.warpmail.net> <1274084247216-5064104.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git_user101 <m.aqadjanimemar@student.ru.nl>
X-From: git-owner@vger.kernel.org Mon May 17 11:02:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODwDT-0000pR-Bm
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 11:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab0EQJCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 05:02:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49001 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800Ab0EQJCV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 05:02:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C6F04F69B1;
	Mon, 17 May 2010 05:02:20 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 17 May 2010 05:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YVZAMiqa9fF1012Zyd1pVudoPJ8=; b=Y6ORlL83G50nBuPpUNQPq92W9GY1DHiB0Qa0urBvTOm/Eiyo/7iAvl83TksYFGU+BYIFrtYPZ6Tjp09TeAMIcSyVAfVYSJo9Eo1SgCeSWdv3qFXVXCHMSkNnOQU8Bsdm6VocIfb4G9Is+iWD8u5KAOQYBn0abihUnP2TMEQwGKc=
X-Sasl-enc: wI4i0W09bMyhtKkKP9vwOWwCfNHiNsCyZSDaconoNmsr 1274086940
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2323B4AEE66;
	Mon, 17 May 2010 05:02:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274084247216-5064104.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147219>

git_user101 venit, vidit, dixit 17.05.2010 10:17:
> 
> yes!
> This is about a shared repository that is allowed to be accessed by its
> owner and group.
> The group consists of some machine users.
> Users have different accounts and modify the git-repository by own account.
> 

Then you might want to read up on core.sharedRepository in git config's
man page and set it according to your situation (all users in the same
group, e.g.). Also, you'll have to fix-up permissions manually at least
on logs/HEAD (and probably others).

Cheers,
Michael
