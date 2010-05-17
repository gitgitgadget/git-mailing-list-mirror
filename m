From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Development Environment Setup
Date: Mon, 17 May 2010 10:00:46 +0200
Message-ID: <4BF0F7AE.7050207@drmicha.warpmail.net>
References: <00b801caf560$6d07be50$47173af0$@burgmann.anu.edu.au> <12452_1274073815_4BF0D2D7_12452_439_1_4BF0D2CC.8090605@gmail.com> <00f901caf583$67ba1650$372e42f0$@burgmann.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: 'Gabriel Filion' <lelutin@gmail.com>, git@vger.kernel.org
To: Albert Krawczyk <albert@burgmann.anu.edu.au>
X-From: git-owner@vger.kernel.org Mon May 17 10:00:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODvFp-0001rj-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 10:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab0EQIAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 04:00:40 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39807 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320Ab0EQIAk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 04:00:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BB095F5267;
	Mon, 17 May 2010 04:00:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 17 May 2010 04:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fZ6YPHW7PscCCISICJPpaQkcUwI=; b=UEFnNYHojVmvFVm2+4mOYTvPXJ+8gZbDO+d+QjxwJmkIenUkVPfKNPWMWduavL6nRJodtY0+hW0oLvoUQg6EIrRKI4DWxznZbxJgRLgQdN9hhXD3Bhu2eB3hlZHdD0402TWSuwyIO4N3jFlzh4uf6NXtzrxJrVgVNMN1IRhRsdg=
X-Sasl-enc: 9/rxjwrAcQD+1GYLKSgUhxrhp/7YPXkVfuso8rVDN+ez 1274083239
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EFBB94D69EE;
	Mon, 17 May 2010 04:00:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <00f901caf583$67ba1650$372e42f0$@burgmann.anu.edu.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147216>

Albert Krawczyk venit, vidit, dixit 17.05.2010 07:40:
> Hi Gabriel,
> 
> I probably expressed myself incorrectly. 
> 
> What IDE do people use to develop / debug Git.
> 
> Albert 

You expressed yourself correctly but top-posted in response which is
worse ;)

Git as a project isn't that large, I would think that most people's
"IDE" is vim/emacs plus bash/dash for the C, shell and Perl parts. In
fact, "git blame", "git log" and "git bisect" are probably among the
most important tools for Git development, but all of them trailing the
utmost important one:

more Documentation/SubmittingPatches

Cheers,
Michael
