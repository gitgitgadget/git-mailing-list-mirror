From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 15:24:16 -0400
Message-ID: <45119560.7060102@pobox.com>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 21:26:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ7gt-0001w9-9j
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 21:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWITTYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 15:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWITTYw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 15:24:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19432 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932303AbWITTYv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 15:24:51 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GQ7g9-0004wO-86; Wed, 20 Sep 2006 19:24:50 +0000
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27395>

Linus Torvalds wrote:
> So you could either mark _all_ the remote branches with the extra "+" (to 
> say that you always want to fetch that exact state for whatever branch 
> you're tracking), or you can ask Jeff which branches he expects to do 
> strange things and just mark those individual ones.


Actually, I only rebase rarely, because it's a pain for downstream people.

Stephen just caught one of the rare occasions where I rebased 
'e100-sbit'.  Note that other branches did not get rebased.

Sorry about that Stephen, I should have posted to netdev.

	Jeff
