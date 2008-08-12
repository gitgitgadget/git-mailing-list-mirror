From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to edit commit messages?
Date: Tue, 12 Aug 2008 14:45:04 +0200
Message-ID: <48A185D0.3070003@op5.se>
References: <g7s088$o1p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dr.chiarello@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 12 14:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStH8-0000vA-3X
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 14:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYHLMpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 08:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYHLMpx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 08:45:53 -0400
Received: from mail.op5.se ([193.201.96.20]:48649 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbYHLMpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 08:45:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CE83F1B8054D;
	Tue, 12 Aug 2008 14:48:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJm--JuDqhl4; Tue, 12 Aug 2008 14:48:59 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id CC6201B8037A;
	Tue, 12 Aug 2008 14:48:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <g7s088$o1p$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92093>

dr.chiarello@gmail.com wrote:
> Hi all,
>   what are the best solution to:
> 1) interactively edit commit's messages (some or all)
> 2) batch edit commit's messages (for example using sed)
> 
> My repo is not published yet, so there is no problem in rewriting all
> history.
> 

git filter-branch --msg-filter 'sed s/foo/bar/g' master

to replace all occurrences of foo with bar in all commit
messages for all commits made on the master branch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
