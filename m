From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: how do you "force a pull"?
Date: Mon, 27 Aug 2007 01:26:31 -0400
Message-ID: <20070827052631.GA3580@falcon.digizenstudio.com>
References: <20070825111946.GA7122@falcon.digizenstudio.com> <m34pimdspt.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 07:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPX7l-0005LN-Da
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 07:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbXH0F0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbXH0F0k
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 01:26:40 -0400
Received: from k2smtpout04-01.prod.mesa1.secureserver.net ([64.202.189.166]:51000
	"HELO k2smtpout04-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751247AbXH0F0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 01:26:39 -0400
Received: (qmail 871 invoked from network); 27 Aug 2007 05:26:39 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-01.prod.mesa1.secureserver.net (64.202.189.166) with ESMTP; 27 Aug 2007 05:26:39 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 5A993100A0B
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 05:26:39 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70LMMqhsfeJQ for <git@vger.kernel.org>;
	Mon, 27 Aug 2007 01:26:33 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id F2406100587
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 01:26:32 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id EEC2C7B51B; Mon, 27 Aug 2007 01:26:31 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m34pimdspt.fsf@pc7.dolda2000.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56762>

On Sun, Aug 26, 2007 at 09:02:54PM +0200, Fredrik Tolf wrote:
> 
> This is probably not as good an answer as David Watson's suggestion,
> but if what you want is to commit your current code while still having
> your savepoint commit in the history, shouldn't you be able to commit
> your current code and then use git-rebase to rebase it onto the
> savepoint commit?

Yep, I tried and it works too. A bit more verbose than a hard reset -
involved some manual merging in my case, had to update-index and then
--continue the rebase. But then I think this approach is semantically
different and probably safer than a hard reset in some cases.

All this is interesting and good to know. Thanks, Fredrik!
-- 
Jing Xue
