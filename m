From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 10:42:55 +0200
Message-ID: <4DAD4B0F.9030908@drmicha.warpmail.net>
References: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC6WX-0002pT-4Y
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 10:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab1DSIm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 04:42:59 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43828 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753318Ab1DSIm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 04:42:58 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4EBA320942;
	Tue, 19 Apr 2011 04:42:57 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 19 Apr 2011 04:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=noVe3MteTguUt504eH8wGm7GZgs=; b=mcx3Q/dg8GPapoeA9pSRBebwSEx1g6qwCCVBURjecAA5F6sPOngC4NnvNZebA12QFKlsK5LaoKExDNAwuuerv2LXPWPz+rHJVyxVsL6uc+tgWHKtqQZ/r8C8ddYmLsjw2Oy07t+BE+Wf6D4ZUMfHb9Sx60zD6X48v/42wzQMFeo=
X-Sasl-enc: 8RaqBsyRiUyyu9pXnQPM4/ptLqnBqh37X7GltlWFuwjQ 1303202577
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB419447116;
	Tue, 19 Apr 2011 04:42:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171781>

Francis Moreau venit, vidit, dixit 19.04.2011 09:32:
> Hello,
> 
> I'm wondering if it would be a good idea for git rebase to allow not
> rebasing reverted patch which are part of the rebased branch.
> 
> For example I'm currently rebasing my branch 'devel' onto master. This
> branch have several commits and specially one called A and another one
> called A' which reverts A.
> 
> When rebasing 'devel' branch, rebase could try to drop both A and A'.
> 
> What do you think ?
> 
> BTW is there a way to do this currently ?

You can do this with "rebase -i" by removing A and A' from the commit
list (or squashing them or dealing with them in whatever way you like).

Michael
