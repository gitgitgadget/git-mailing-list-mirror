From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-merge performance
Date: Tue, 16 Oct 2007 19:34:10 +0200
Message-ID: <4714F612.2010905@op5.se>
References: <20071016101748.ff132685.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhqJE-000763-OX
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbXJPReO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757419AbXJPReO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:34:14 -0400
Received: from mail.op5.se ([193.201.96.20]:55667 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbXJPReN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:34:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6014717306FB;
	Tue, 16 Oct 2007 19:34:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HswqezwE7VlD; Tue, 16 Oct 2007 19:34:11 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 7323717306C4;
	Tue, 16 Oct 2007 19:34:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071016101748.ff132685.akpm@linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61229>

Andrew Morton wrote:
> My git-pulling script (git-1.4.2) seems to have got quite a bit slower
> since the post-2.6.23 patchflood.  I just did a bit of poking and it's
> git-merge which is taking most of the time.
> 

That's odd. If it had been the remote fetching it would have been
understandable. Is this also happening with more recent gits? I know there
are some significant performance-improvements in 1.5.3.4 (or below).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
