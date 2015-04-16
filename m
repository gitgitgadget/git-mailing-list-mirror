From: David Miller <davem@davemloft.net>
Subject: Re: git-owner, was Re: [bug] first line truncated with `git log
 --oneline --decorate --graph`
Date: Thu, 16 Apr 2015 12:31:09 -0400 (EDT)
Message-ID: <20150416.123109.141223786207291496.davem@davemloft.net>
References: <20150416.115628.1228076242478955092.davem@davemloft.net>
	<6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
	<20150416162620.GA10573@peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: johannes.schindelin@gmx.de, git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Apr 16 18:31:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yimh9-0001AW-MW
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 18:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbbDPQbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 12:31:12 -0400
Received: from shards.monkeyblade.net ([149.20.54.216]:33630 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbbDPQbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 12:31:10 -0400
Received: from localhost (cpe-66-108-87-106.nyc.res.rr.com [66.108.87.106])
	(Authenticated sender: davem-davemloft)
	by shards.monkeyblade.net (Postfix) with ESMTPSA id C0436581AB1;
	Thu, 16 Apr 2015 09:31:09 -0700 (PDT)
In-Reply-To: <20150416162620.GA10573@peff.net>
X-Mailer: Mew version 6.6 on Emacs 24.4 / Mule 6.0 (HANACHIRUSATO)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Apr 2015 09:31:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267308>

From: Jeff King <peff@peff.net>
Date: Thu, 16 Apr 2015 12:26:21 -0400

> Weird. In a nearby thread with the same problem, the first email that
> mentions git-owner in a cc header is yours[1]. It's in reply to a
> message that does not mention git-owner at all[2], except in the
> "Sender" field. Your agent header looks like:
> 
>   User-Agent: Roundcube Webmail/1.1.0
> 
> Maybe their "reply to all" function is a little over-zealous?

This is always caused by broken reply list handling in email clients.
