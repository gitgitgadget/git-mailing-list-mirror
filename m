From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Tue, 23 Sep 2008 23:30:09 +0200
Message-ID: <48D95FE1.30200@op5.se>
References: <48D95836.6040200@op5.se> <20080923162211.d4b15373.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:31:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFTs-0004gE-Cj
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYIWVaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYIWVaW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:30:22 -0400
Received: from mail.op5.se ([193.201.96.20]:49080 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbYIWVaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:30:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 302341B80085;
	Tue, 23 Sep 2008 23:20:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.104
X-Spam-Level: 
X-Spam-Status: No, score=-3.104 tagged_above=-10 required=6.6
	tests=[AWL=-0.605, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIJFgy4RAjty; Tue, 23 Sep 2008 23:20:47 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 8BF371B80051;
	Tue, 23 Sep 2008 23:20:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080923162211.d4b15373.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96605>

Stephen Haberman wrote:
>> Stephen, I had to modify the tests a bit to get them to work with how
>> I implemented the merge-preserving rebase, and also to remove a lot of
>> the cruft that was previously in there. Hope you're ok with the
>> attribution in the commit message.
> 
> No problem, it looks great.
> 
> This is awesome. Thanks for the insanely short turnaround.


It requires a bit of testing though. All the t/t34* tests pass with
all the patches applied, and some manual tries worked just fine too,
but if you wanna give it a twirl where you work, that'd be great.


> The
> GIT_EDITOR=: hack is neat. I did not think it would be that simple.
> 

Actually, you should be able to use vanilla "git-rebase -i -p" without
getting an editor by doing something like this:

GIT_EDITOR=: git rebase -i -p

but recommending a hack like that to work around a UI deficiency didn't
really appeal to me. If Junio doesn't like the patches though, you could
try using that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
