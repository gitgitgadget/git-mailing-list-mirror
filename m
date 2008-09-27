From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Sat, 27 Sep 2008 19:55:18 +0200
Message-ID: <48DE7386.2080808@op5.se>
References: <48D95836.6040200@op5.se> <20080923162211.d4b15373.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 19:56:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kje22-0008Pf-BW
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 19:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYI0RzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYI0RzZ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 13:55:25 -0400
Received: from mail.op5.se ([193.201.96.20]:54802 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbYI0RzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 13:55:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C45F01B80077;
	Sat, 27 Sep 2008 19:46:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28jmrONHwvhm; Sat, 27 Sep 2008 19:46:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 1FE331B80050;
	Sat, 27 Sep 2008 19:46:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080923162211.d4b15373.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96915>

Stephen Haberman wrote:
>> Stephen, I had to modify the tests a bit to get them to work with how
>> I implemented the merge-preserving rebase, and also to remove a lot of
>> the cruft that was previously in there. Hope you're ok with the
>> attribution in the commit message.
> 
> No problem, it looks great.
> 
> This is awesome. Thanks for the insanely short turnaround. The
> GIT_EDITOR=: hack is neat. I did not think it would be that simple.
> 

Stephen, are you using this in production? How's it turning out?

Shawn, I haven't seen this in any of your branches. Overlooked or
dropped? I think 1-2 are probably master material, while I'm not
so sure about 3/3. Would you prefer a re-send that turns it into
a 2-patch series, adding each test with the functionality it tests?

Let me know how you want it and I'll work something up tomorrow
morning, gmt + 1.

Thanks

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
