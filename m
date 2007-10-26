From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Make rebase smarter
Date: Fri, 26 Oct 2007 09:42:09 +0200
Message-ID: <47219A51.9090001@op5.se>
References: <1193328386.4522.352.camel@cacharro.xalalinux.org> <1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, federico@novell.com
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 09:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlJrA-00084L-Jn
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 09:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbXJZHmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbXJZHmS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 03:42:18 -0400
Received: from mail.op5.se ([193.201.96.20]:45262 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197AbXJZHmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 03:42:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 25AB417306E6;
	Fri, 26 Oct 2007 09:41:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8iKt+mT661nU; Fri, 26 Oct 2007 09:41:31 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 771A217306D8;
	Fri, 26 Oct 2007 09:41:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62399>

Steven Walter wrote:
> It is a common workflow to run "git fetch; git rebase origin/<foo>" Where
> foo is the remote tracking branch.  git-rebase should default to using
> the remote tracking branch if no other ref is given.
> 

I like it. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
